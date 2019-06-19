%{
  #include "matrix.tab.h"
  #include<stdlib.h>
  #include <stdio.h>
  int  yylex ();
  int line=0;
%}
%option noyywrap

DIGITO [0-9]
NUMERO {DIGITO}+
IGNORA [" "|\t]

%%   
{NUMERO} {yylval.integer=atoi(yytext); return(NUMERO);}
"*" {return (MULTIPLICACAO);}
"+" {return (SOMA);}
"-" {return (SUBTRACAO);}
"t" {return (TRANSPOSTA);}
"d" {return (DETERMINANTE);}
"(" {return (PAA); }
")" {return (PAF); }
"{" {return (CA); }
"}" {return (CF); }
"," {return (VIRG); }
";" {return (PONTVR); }
"end" {return (FINAL);}
"/n" 	{line++;}
" "	{}
[a-zA-Z]+ {return LETTER;}
[\t\r\f\n] {}
. {
	printf("Erro léxico na linha %d",line);
}
%%