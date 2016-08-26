package tokenizer;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

%%


%class AnalizadorLexico
%unicode             
%line                
%column              
        
%type String         

%{
private ArrayList<String> tokensList; 

private void writeOutputFile() throws IOException { 
	String filename = "file.out";
	BufferedWriter out = new BufferedWriter(new FileWriter(filename));
	for (String s:this.tokensList) {
		System.out.println(s);
		out.write(s + "\n");
	}
	out.close();
}
%}

%eof{
    try { 
            this.writeOutputFile();
        } catch (IOException ex) {
            Logger.getLogger(AnalizadorLexico.class.getName()).log(Level.SEVERE, null, ex);
        }
    System.exit(0); 
%eof}

%init{ 
this.tokensList = new ArrayList();
%init}

Decimal     = [0-9]+                
Octal       = "o"[0-7]+             
Hex         = "0x"[0-9|A-F]+        
Binary      = [1][0-1]*d
Identifier  = [a-zA-Z][a-zA-Z0-9_]* 
ParenL      = "("
ParenR      = ")"
%xstates A

%%
{ParenL}        { this.tokensList.add("Entrando a A:");
                    yybegin(A); }
<A> {
  {Binary}      {this.tokensList.add("[" + yyline + "," + yycolumn + "] Binario: " + yytext());}
  {ParenR}      { this.tokensList.add("Salidneo de A");
                  yybegin(YYINITIAL);}
  \r|\n|\r\n    {} 
  .             { System.out.println("caracter no valido:[" + yyline + "," + yycolumn + "]" + yytext()); }
}
{Decimal}       {this.tokensList.add("[" + yyline + "," + yycolumn + "] Decimal: " + yytext());}     
{Octal}         {this.tokensList.add("[" + yyline + "," + yycolumn + "] Octal: " + yytext());}       
{Hex}           {this.tokensList.add("[" + yyline + "," + yycolumn + "] Hexadecimal: " + yytext());} 
{Identifier}    {this.tokensList.add("[" + yyline + "," + yycolumn + "] Identifier: " + yytext());}  
\r|\n|\r\n      {}           
.               {}  
