grammar GyhGrammar;

// Programa → ':' 'DEC' ListaDeclaracoes ':' 'PROG' ListaComandos;
programa: Delim PCDec listaDeclaracoes Delim PCProg listaComandos;

// ListaDeclaracoes → Declaracao ListaDeclaracoes | Declaracao;
listaDeclaracoes: declaracao listaDeclaracoes | declaracao;

// Declaracao → VARIAVEL ':' TipoVar;
declaracao: Var Delim tipoVar;

// TipoVar → 'INT' | 'REAL';
tipoVar: PCInt | PCReal;

// ExpressaoAritmetica → ExpressaoAritmetica '+' TermoAritmetico | ExpressaoAritmetica '-' TermoAritmetico | TermoAritmetico;
expressaoAritmetica: expressaoAritmetica OpAritSoma termoAritmetico | expressaoAritmetica OpAritSub termoAritmetico | termoAritmetico;

// TermoAritmetico → TermoAritmetico '*' FatorAritmetico | TermoAritmetico '/' FatorAritmetico | FatorAritmetico;
termoAritmetico: termoAritmetico OpAritMult fatorAritmetico | termoAritmetico OpAritDiv fatorAritmetico | fatorAritmetico;

// FatorAritmetico → NUMINT| NUMREAL | VARIAVEL | '(' ExpressaoAritmetica ')'
fatorAritmetico: NumInt | NumReal | Var | AbrePar expressaoAritmetica FechaPar;

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
comandoAtribuicao: Var Atrib expressaoAritmetica;

// ComandoEntrada → 'LER' VARIAVEL;
comandoEntrada: PCLer Var;

// ComandoSaida → 'IMPRIMIR'  VARIAVEL | 'IMPRIMIR' CADEIA;
comandoSaida: PCImprimir Var | PCImprimir Cadeia;

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
WS: [ \t\r\n]+ -> skip;