package tokenizer;

%%

%class AnalizadorLexico
%unicode
%line
%column

%type String        

%{
  private String numeros = "";
%}

%eof{
    System.out.println("Números encontrados:");
    System.out.println(numeros); 
%eof}

FinLinea = \r|\n|\r\n
Espacios = {FinLinea} | [ \t\f]
Decimal = 0 | [1-9][0-9]*

%%

";" { /* ignorar */ }
{Decimal} { numeros += "["+ yyline + ":"+ yycolumn + "] " + yytext() + "\n"; }
{Espacios} {  }
. { System.err.println("ERROR: Caracter inválido" + yytext() + "["+ yyline + ":"+ yycolumn + "]"); }
