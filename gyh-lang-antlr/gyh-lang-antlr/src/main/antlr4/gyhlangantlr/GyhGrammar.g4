grammar GyhGrammar;

@header{
    import java.util.ArrayList;
    import com.felipe.gyh.lang.antlr.Symbol;
    import com.felipe.gyh.lang.antlr.SymbolTable;
    import com.felipe.gyh.lang.antlr.GyhProgram;
    import com.felipe.gyh.lang.antlr.Command;        
    import com.felipe.gyh.lang.antlr.CommandEscrita; 
    import com.felipe.gyh.lang.antlr.CommandLeitura;
    import com.felipe.gyh.lang.antlr.CommandAtribuicao;
    import com.felipe.gyh.lang.antlr.CommandCondicao;
    import com.felipe.gyh.lang.antlr.CommandRepeticao;
}

@members{
    private SymbolTable SymbolTable = new SymbolTable();
    private int errosSemanticos = 0;
    private String _writeVar; 
    private String _readVar; 
    private String _expVar;
    private String _expContent;
    private String cond;

    private ArrayList<Command> lt = new ArrayList<Command>();
    private ArrayList<Command> lf = new ArrayList<Command>();
    private ArrayList<Command> listCmd = new ArrayList<Command>();
    private ArrayList<Command> listAux = new ArrayList<Command>();

    public void verificaEDeclaraVariavel(String name, String type) {
        Symbol sym = new Symbol(name, type, null);
        if(!symbolTable.exists(name)){
            symbolTable.add(sym);
            System.out.println("Adicionei um simbolo " + sym);
        } else {
            System.err.println("Erro Semântico: Variável já declarada! -> " + name);
            errosSemanticos++;
        }
    }

    public void verificaUsoVariavel(String name) {
        if(!SymbolTable.exists(name)) {
            System.err.println("Erro Semântico: Variável não declarada! -> " + name);
            errosSemanticos++;
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
        Symbol sym = symbolTable.get(name);
        if (sym != null) {
            if (sym.getType() == Symbol.INT && tipoExpressao == Symbol.REAL) {
                System.err.println("Erro Semantico: Incompatibilidade de tipos! Variavel '" + name + "' e INT e nao pode receber REAL.");
                errosSemanticos++;
            }
        }
    }
}

// Programa → ':' 'DEC' ListaDeclaracoes ':' 'PROG' ListaComandos;
programa: Delim PCDec listaDeclaracoes Delim PCProg listaComandos 
          { 
            // Vai buscar o total de erros sintáticos e léxicos detetados pelo ANTLR
            int errosSintaticosELexicos = getNumberOfSyntaxErrors();

            if (errosSintaticosELexicos == 0 && errosSemanticos == 0) {
                GyhProgram program = new GyhProgram(SymbolTable, listCmd);
                program.generateTarget();
                System.out.println("\n[Sucesso] BUILD SUCCESS! Codigo C gerado.");
            } else {
                System.err.println("\n[Falha] Geracao de codigo abortada devido a erros no codigo GYH:");
                System.err.println("-> Erros Sintaticos/Lexicos: " + errosSintaticosELexicos);
                System.err.println("-> Erros Semanticos: " + errosSemanticos);
                System.err.println("O arquivo 'programaGyh.c' NAO foi criado ou atualizado.");
            }
          } 
        ;

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
        $tipo = symbolTable.getVariableType(_input.LT(-1).getText());
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
comandoAtribuicao: Var { 
        _expVar = _input.LT(-1).getText();
        verificaUsoVariavel(_expVar); 
      } 
      Atrib e=expressaoAritmetica 
      { 
        verificaTipoAtribuicao(_expVar, $e.tipo); 
        
        _expContent = $expressaoAritmetica.text; 
        
        CommandAtribuicao cmd = new CommandAtribuicao(_expVar, _expContent);
        listCmd.add(cmd);
      } 
    ;

// ComandoEntrada → 'LER' VARIAVEL;
comandoEntrada: PCLer Var 
                    { verificaUsoVariavel(_input.LT(-1).getText()); 
                      _readVar = _input.LT(-1).getText();
                      CommandLeitura cmd = new CommandLeitura(_readVar);
                      listCmd.add(cmd);
                    } 
              ;

// ComandoSaida → 'IMPRIMIR'  VARIAVEL | 'IMPRIMIR' CADEIA;
comandoSaida: PCImprimir Var 
                        { verificaUsoVariavel(_input.LT(-1).getText()); 
                        _writeVar=_input.LT(-1).getText();
                        CommandEscrita cmd = new CommandEscrita(_writeVar);
                        listCmd.add(cmd);
                        }
             | PCImprimir Cadeia;

// ComandoCondicao → 'SE' ExpressaoRelacional 'ENTAO' Comando | 'SE' ExpressaoRelacional 'ENTAO' Comando 'SENAO' Comando;
comandoCondicao: 
    PCSe expressaoRelacional { cond = $expressaoRelacional.text; }
    PCEntao 
    {
        listAux = new ArrayList<Command>(listCmd);
        listCmd.clear();
    }
    comando 
    {
        lt = new ArrayList<Command>(listCmd);
        listCmd.clear();
    }
    (PCSenao comando
    {
        lf = new ArrayList<Command>(listCmd);
        listCmd.clear();
    })?
    {
        CommandCondicao cmdCond = new CommandCondicao(cond, lt, lf);
        
        listCmd = listAux;
        listCmd.add(cmdCond);
    }
;

// ComandoRepeticao → 'ENQTO' ExpressaoRelacional Comando;
comandoRepeticao: 
    PCEnqto expressaoRelacional { cond = $expressaoRelacional.text; }
    {
        // 1. Salva o que já estava na lista principal do programa na listAux
        listAux = new ArrayList<Command>(listCmd);
        listCmd.clear(); // Limpa para capturar APENAS o comando (ou bloco) do ENQTO
    }
    comando
    {
        // 2. Transfere os comandos internos capturados para a nossa lista do laço
        lt = new ArrayList<Command>(listCmd);
        listCmd.clear();
        
        // 3. Cria o objeto do comando de repetição
        CommandRepeticao cmdRep = new CommandRepeticao(cond, lt);
        
        // 4. Restaura a lista do programa principal e adiciona o bloco WHILE nela
        listCmd = listAux;
        listCmd.add(cmdRep);
    }
;

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