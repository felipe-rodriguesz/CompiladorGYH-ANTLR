grammar GyhGrammar;

@header{
    import java.util.ArrayList;
    import com.felipe.gyh.lang.antlr.Symbol;
    import com.felipe.gyh.lang.antlr.SymbolTable;
}

@members{
    private SymbolTable SymbolTable = new SymbolTable();

    public void verificaEDeclaraVariavel(String name, String type) {
        Symbol sym = new Symbol(name, type, null);
        if(!SymbolTable.exists(name)){
            SymbolTable.add(sym);
            System.out.println("Adicionei um simbolo " + sym);
        } else {
            System.out.println("Erro Semântico: Variável já declarada! -> " + name);
        }
    }

    public void verificaUsoVariavel(String name) {
        if(!SymbolTable.exists(name)) {
            System.out.println("Erro Semântico: Variável não declarada! -> " + name);
        }
    }

    public int verificaTipoOpAritmetica(int tipo1, int tipo2) {
        if (tipo1 == -1 || tipo2 == -1) return -1;
        if (tipo1 == Symbol.REAL || tipo2 == Symbol.REAL) {
            return Symbol.REAL;
        }
        return Symbol.INT;
    }

    public void verificaTipoAtribuicao(String name, int tipoExpressao) {
        if (tipoExpressao == -1) return;
        Symbol sym = SymbolTable.get(name);
        if (sym != null) {
            if (sym.getType() == Symbol.INT && tipoExpressao == Symbol.REAL) {
                System.out.println("Erro Semântico: Incompatibilidade de tipos! Variável '" + name + "' é INT e não pode receber REAL.");
            }
        }
    }
}

// Programa → ':' 'DEC' ListaDeclaracoes ':' 'PROG' ListaComandos;
programa: Delim PCDec listaDeclaracoes Delim PCProg listaComandos;

// ListaDeclaracoes → Declaracao ListaDeclaracoes | Declaracao;
listaDeclaracoes: declaracao listaDeclaracoes | declaracao;

// Declaracao → VARIAVEL ':' TipoVar;
declaracao: Var Delim tipoVar { verificaEDeclaraVariavel(_input.LT(-3).getText(), _input.LT(-1).getText()); } ;

// TipoVar → 'INT' | 'REAL';
tipoVar: PCInt | PCReal;

// ExpressaoAritmetica → ExpressaoAritmetica '+' TermoAritmetico | ExpressaoAritmetica '-' TermoAritmetico | TermoAritmetico;
expressaoAritmetica returns [int tipo]
    : e=expressaoAritmetica OpAritSoma t=termoAritmetico { $tipo = verificaTipoOpAritmetica($e.tipo, $t.tipo); }
    | e=expressaoAritmetica OpAritSub t=termoAritmetico { $tipo = verificaTipoOpAritmetica($e.tipo, $t.tipo); }
    | t=termoAritmetico { $tipo = $t.tipo; }
    ;

// TermoAritmetico → TermoAritmetico '*' FatorAritmetico | TermoAritmetico '/' FatorAritmetico | FatorAritmetico;
termoAritmetico returns [int tipo]
    : t=termoAritmetico OpAritMult f=fatorAritmetico { $tipo = verificaTipoOpAritmetica($t.tipo, $f.tipo); }
    | t=termoAritmetico OpAritDiv f=fatorAritmetico { $tipo = verificaTipoOpAritmetica($t.tipo, $f.tipo); }
    | f=fatorAritmetico { $tipo = $f.tipo; }
    ;

// FatorAritmetico → NUMINT| NUMREAL | VARIAVEL | '(' ExpressaoAritmetica ')'
fatorAritmetico returns [int tipo]
    : NumInt { $tipo = Symbol.INT; }
    | NumReal { $tipo = Symbol.REAL; }
    | Var { 
        verificaUsoVariavel(_input.LT(-1).getText()); 
        $tipo = SymbolTable.getVariableType(_input.LT(-1).getText());
      } 
    | AbrePar e=expressaoAritmetica FechaPar { $tipo = $e.tipo; }
    ;

// ExpressaoRelacional → ExpressaoRelacional OperadorBooleano TermoRelacional | TermoRelacional;
expressaoRelacional: expressaoRelacional operadorBooleano termoRelacional | termoRelacional;

// TermoRelacional → ExpressaoAritmetica OP_REL ExpressaoAritmetica | '(' ExpressaoRelacional ')';
termoRelacional: expressaoAritmetica opRel expressaoAritmetica | AbrePar expressaoRelacional FechaPar;

// OperadorBooleano → 'E' | 'OU';
operadorBooleano: OpBoolE | OpBoolOu;

opRel: OpRelMenor | OpRelMenorIgual | OpRelMaior | OpRelMaiorIgual | OpRelIgual | OpRelDif;

// ListaComandos → Comando ListaComandos | Comando;
listaComandos: comando listaComandos | comando;

// Comando → ComandoAtribuicao | ComandoEntrada | ComandoSaida | ComandoCondicao | ComandoRepeticao | SubAlgoritmo;
comando: comandoAtribuicao | comandoEntrada | comandoSaida | comandoCondicao | comandoRepeticao | subAlgoritmo;

// ComandoAtribuicao → VARIAVEL ':=' ExpressaoAritmetica;
comandoAtribuicao
@init{ String varName = ""; }
    : Var { 
        varName = _input.LT(-1).getText();
        verificaUsoVariavel(varName); 
      } 
      Atrib e=expressaoAritmetica { verificaTipoAtribuicao(varName, $e.tipo); } 
    ;

// ComandoEntrada → 'LER' VARIAVEL;
comandoEntrada: PCLer Var { verificaUsoVariavel(_input.LT(-1).getText()); } ;

// ComandoSaida → 'IMPRIMIR'  VARIAVEL | 'IMPRIMIR' CADEIA;
comandoSaida: PCImprimir Var { verificaUsoVariavel(_input.LT(-1).getText()); } | PCImprimir Cadeia;

// ComandoCondicao → 'SE' ExpressaoRelacional 'ENTAO' Comando | 'SE' ExpressaoRelacional 'ENTAO' Comando 'SENAO' Comando;
comandoCondicao: PCSe expressaoRelacional PCEntao comando (PCSenao comando)?;

// ComandoRepeticao → 'ENQTO' ExpressaoRelacional Comando;
comandoRepeticao: PCEnqto expressaoRelacional comando;

// SubAlgoritmo → 'INI' ListaComandos 'FIM';
subAlgoritmo: PCIni listaComandos PCFim;

PCDec: 'DEC';
PCProg: 'PROG';
PCInt: 'INT';
PCReal: 'REAL';
PCLer: 'LER';
PCImprimir: 'IMPRIMIR';
PCSe: 'SE';
PCSenao: 'SENAO';
PCEntao: 'ENTAO';
PCEnqto: 'ENQTO';
PCIni: 'INI';
PCFim: 'FIM';
OpAritMult: '*';
OpAritDiv: '/';
OpAritSoma: '+';
OpAritSub: '-';
OpRelMenor: '<';
OpRelMenorIgual: '<=';
OpRelMaior: '>';
OpRelMaiorIgual: '>=';
OpRelIgual: '==';
OpRelDif: '!=';
OpBoolE: 'E';
OpBoolOu: 'OU';
Delim: ':';
Atrib: ':=';
AbrePar: '(';
FechaPar: ')';
Var: [a-z][a-zA-Z0-9]*;
NumInt: [0-9]+;
NumReal: [0-9]+'.'[0-9]+;
Cadeia: '"' (~["\r\n])* '"';
Comment: '#' ~[\r\n]* -> skip;
WS: [ \t\r\n]+ -> skip;