%{    
  #include <stdio.h>
  #include <stdlib.h>
  #include <math.h>

   void yyerror(char*msg);
   void multMatrix(int matriz1[3][3],int matriz2[3][3]);
   void somaMatrix(int matriz1[3][3],int matriz2[3][3]);
   void transpostaMatrix(int matriz[3][3]);
   void determinanteMatrix(int matriz[3][3]);
   
   extern char *yytext;
   extern int line;
   extern FILE *yyin;
   extern int yylex(void);
   int matriz1[3][3]; 
   int matriz2[3][3];
    
%}
%union

{
  int integer;
}
%token <integer> NUMERO
%token MULT 
%token SOMAR
%token PAA
%token PAF 
%token CA 
%token CF 
%token VIRG 
%token TMULT
%token TSOMA
%token FINAL
%token LETTER
%token TRANSPOSTA
%token DETERMINANTE

%type <integer> A
%type <integer> B
%type <integer> C
%type <integer> D
%type <integer> E
%type <integer> F
%type <integer> G
%type <integer> H
%start Statement

%%

Statement: 
| Statement EXPRESSION;
EXPRESSION: MULT PAA MATRIX TMULT MATRIZ PAF FINALIZEMULT;
EXPRESSION: SOMAR PAA MATRIX TSOMA MATRIZ PAF FINALIZESOMA;
EXPRESSION: TRANSPOSTA PAA MATRIX PAF FINALIZETRANSPOSTA;
EXPRESSION: DETERMINANTE PAA MATRIX PAF FINALIZEDETERMINANTE;

FINALIZEMULT : FINAL{multMatrix(matriz1, matriz2);} 
| LETTER {printf("\nInvalid Sentence ");}

FINALIZESOMA : FINAL{somaMatrix(matriz1, matriz2);} 
| LETTER {printf("\nInvalid Sentence ");}

FINALIZETRANSPOSTA : FINAL{transpostaMatrix(matriz1);} 
| LETTER {printf("\nInvalid Sentence ");}

FINALIZEDETERMINANTE: FINAL{determinanteMatrix(matriz1);} 
| LETTER {printf("\nInvalid Sentence ");}

MATRIX: VET1  VET2 VET3;
VET1 : CA A VIRG B VIRG C CF;
VET2 : CA D VIRG E VIRG F CF;
VET3 : CA G VIRG H VIRG I CF;
A:NUMERO{ matriz1[0][0]= $1;}; 
B:NUMERO{ matriz1[0][1]= $1;};
C:NUMERO{ matriz1[0][2]= $1;};
D:NUMERO{ matriz1[1][0]= $1;};
E:NUMERO{ matriz1[1][1]= $1;};
F:NUMERO{ matriz1[1][2]= $1;};
G:NUMERO{ matriz1[2][0]= $1;};
H:NUMERO{ matriz1[2][1]= $1;};
I:NUMERO{ matriz1[2][2]= $1;};

MATRIZ:VET4 VET5 VET6;  
VET4 : CA J VIRG K VIRG L CF;
VET5 : CA M VIRG N VIRG O CF; 
VET6 : CA P VIRG Q VIRG R CF; 
J:NUMERO{ matriz2[0][0]= $1;}; 
K:NUMERO{ matriz2[0][1]= $1;};
L:NUMERO{ matriz2[0][2]= $1;};
M:NUMERO{ matriz2[1][0]= $1;};
N:NUMERO{ matriz2[1][1]= $1;};
O:NUMERO{ matriz2[1][2]= $1;};
P:NUMERO{ matriz2[2][0]= $1;};
Q:NUMERO{ matriz2[2][1]= $1;};
R:NUMERO{ matriz2[2][2]= $1;};

%%
void yyerror(char *s){
  printf("\nThat sentense is invalid: %s",s);
  
}
int main(int argc,char **argv){

  printf("\n--------------Operações com matrizes 3x3--------------\n\n");
  
  printf("\n Multiplicação: multiplicar({x,x,x}{x,x,x}{x,x,x}:{x,x,x}{x,x,x}{x,x,x})end\n");
  printf("\n Soma: somar({x,x,x}{x,x,x}:{x,x,x}{x,x,x})end\n");
  printf("\n Transposta: transposta({x,x,x}{x,x,x})end\n");
  printf("\n Determinante: determinante({x,x,x}{x,x,x})end\n");

  printf("\n-------------------------------------------------------\n\n");

  printf("\nDigite: ")
  
  if (argc>1)
	yyin=fopen(argv[1],"rt");
  else
	yyin=stdin;

  yyparse();
  return 0;
 
}

void determinanteMatrix(int matriz[3][3]){
	float det = 0;
	det=((matriz[0][0]*matriz[1][1]*matriz[2][2])+(matriz[0][1]*matriz[1][2]*matriz[2][0])+(matriz[0][2]*matriz[1][0]*matriz[2][2]))-((matriz[2][0]*matriz[1][1]*matriz[0][2])+(matriz[2][1]*matriz[1][2]*matriz[0][0])+(matriz[2][2]*matriz[1][0]*matriz[0][1])); /*formula para calcular a determinante */
	printf("Determinante da matriz = %0.2f\n",det);
}
void transpostaMatrix(int matriz[3][3]){
	int f=0, g=0;
	printf("\n\n\t:: Transposta ::\n\n");
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  ----------\n");

	f=0; g=0;
	while(f<3){
		g=0;
		while(g<3){
			if(f==g){
				printf("\t %d",matriz[f][g]);
			}else{
				printf("\t %d",matriz[g][f]);
			}
			g++;
		}
		printf("\n");
		f++;
     }


}
void somaMatrix(int matriz1[3][3],int matriz2[3][3]){

	int f=0, g=0;
	printf("\n\n\t:: Sum ::\n\n");
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz1[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  ----------\n");
	f=0; g=0;
	
	
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz2[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  ----------\n\n\n");
	
	f=0; g=0;
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz1[f][g]+matriz2[f][g]);
			g++;
		}
		printf("\n");
		f++;
     }

         
         
}

void multMatrix(int matriz1[3][3],int matriz2[3][3]){

	int f=0, g=0;
	printf("\n\n\t:: Product ::\n\n");
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz1[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  ----------\n");
	f=0; g=0;
	
	
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz2[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  ----------\n\n\n");
	
	f=0; g=0;
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz1[f][g]*matriz2[f][g]);
			g++;
		}
		printf("\n");
		f++;
     }

         
         
}

