%{    
  #include <stdio.h>
  #include <stdlib.h>
  #include <math.h>

   void yyerror(char*msg);
   void multMatrix(int matriz1[3][3],int matriz2[3][3]);
   void somaMatrix(int matriz1[3][3],int matriz2[3][3]);
   void subMatrix(int matriz1[3][3],int matriz2[3][3]);
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
%token PAA
%token PAF 
%token CA 
%token CF 
%token VIRG 
%token FINAL
%token LETTER
%token TRANSPOSTA
%token DETERMINANTE
%token MULTIPLICACAO
%token SOMA
%token SUBTRACAO
%token PONTVR


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
EXPRESSION: MULTIPLICACAO PAA MATRIX PONTVR MATRIZ PAF FINALIZEMULT;
EXPRESSION: SOMA PAA MATRIX PONTVR MATRIZ PAF FINALIZESOMA;
EXPRESSION: SUBTRACAO PAA MATRIX PONTVR MATRIZ PAF FINALIZESUB;
EXPRESSION: TRANSPOSTA PAA MATRIX PAF FINALIZETRANSPOSTA;
EXPRESSION: DETERMINANTE PAA MATRIX PAF FINALIZEDETERMINANTE;

FINALIZEMULT : FINAL{multMatrix(matriz1, matriz2);} 
| LETTER {printf("\nSentença inválida ");}

FINALIZESOMA : FINAL{somaMatrix(matriz1, matriz2);} 
| LETTER {printf("\nSentença inválida ");}

FINALIZESUB : FINAL{subMatrix(matriz1, matriz2);} 
| LETTER {printf("\nSentença inválida ");}

FINALIZETRANSPOSTA : FINAL{transpostaMatrix(matriz1);} 
| LETTER {printf("\nSentença inválida ");}

FINALIZEDETERMINANTE: FINAL{determinanteMatrix(matriz1);} 
| LETTER {printf("\nSentença inválida ");}

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
  printf("\nA sentença é inválida: %s",s);
  
}
int main(int argc,char **argv){

  printf("\n--------------Operações com matrizes 3x3--------------\n\n");
  
  printf("\n Multiplicação: *({x,x,x}{x,x,x}{x,x,x};{x,x,x}{x,x,x}{x,x,x})end\n");
  printf("\n Soma: +({x,x,x}{x,x,x};{x,x,x}{x,x,x})end\n");
  printf("\n Subtração: -({x,x,x}{x,x,x};{x,x,x}{x,x,x})end\n");
  printf("\n Transposta: transp({x,x,x}{x,x,x}{x,x,x})end\n");
  printf("\n Determinante: det({x,x,x}{x,x,x}{x,x,x})end\n");

  printf("\n-------------------------------------------------------\n\n");

  printf("\nDigite: ");
  
  if (argc>1)
	yyin=fopen(argv[1],"rt");
  else
	yyin=stdin;

  yyparse();
  return 0;
 
}

void determinanteMatrix(int matriz[3][3]){
	printf("\n\n\t:: Determinante da matriz ::\n\n");
	float det = 0;
	det=((matriz[0][0]*matriz[1][1]*matriz[2][2])+(matriz[0][1]*matriz[1][2]*matriz[2][0])+(matriz[0][2]*matriz[1][0]*matriz[2][2]))-((matriz[2][0]*matriz[1][1]*matriz[0][2])+(matriz[2][1]*matriz[1][2]*matriz[0][0])+(matriz[2][2]*matriz[1][0]*matriz[0][1]));
	printf("Determinante da matriz = %0.2f\n",det);
	printf("\n");
}

void transpostaMatrix(int matriz[3][3]){
	printf("\n\n\t:: Transposta da matriz ::\n\n");
	int f=0, g=0;
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  -------------------\n");

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

	printf("\n\n\t:: Soma das matrizes ::\n\n");
	int f=0, g=0;
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz1[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  -------------------\n");
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
	printf("\t  -------------------\n\n\n");
	
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

void subMatrix(int matriz1[3][3],int matriz2[3][3]){

	printf("\n\n\t:: Subtração das matrizes ::\n\n");
	int f=0, g=0;
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz1[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  -------------------\n");
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
	printf("\t  -------------------\n\n\n");
	
	f=0; g=0;
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz1[f][g]-matriz2[f][g]);
			g++;
		}
		printf("\n");
		f++;
     }         
}

void multMatrix(int matriz1[3][3],int matriz2[3][3]){
	
	printf("\n\n\t:: Produto das matrizes ::\n\n");
	int result[3][3]={{0,0,0},{0,0,0},{0,0,0}};
	int f=0, g=0;
	while(f<3){
		g=0;
		while(g<3){
			printf("\t  %d",matriz1[f][g]);
			g++;
		}
		f++;
		printf("\n");
	}
	printf("\t  -------------------\n");
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
	printf("\t  -------------------\n\n\n");

	int i, j, k;
    for(i = 0; i < 3; i++)
    {
            for(j = 0; j < 3; j++)
            {
                    for(k = 0; k < 3; k++)
                    {
                            result[i][j] +=  matriz1[i][k] *  matriz2[k][j];
                    }
            }
    }

	f=0;g=0;
    for (f = 0; f < 3; f++)
    {
        for(g = 0; g < 3; g++){
			printf("\t  %d",result[f][g]);
        }
        printf("\n");
    }   
         
}