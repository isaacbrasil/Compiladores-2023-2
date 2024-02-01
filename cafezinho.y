%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
%}

%token PROGRAMA INT CAR ID INTCONST STRING_LITERAL
%token SEMICOLON COMMA LBRACKET RBRACKET LPAREN RPAREN LBRACE RBRACE
%token RETORNE LEIA ESCREVA NOVALINHA SE ENTAO SENAO ENQUANTO EXECUTE
%token OU E EQ NE LT GT LE GE PLUS MINUS ASTERISK SLASH PERCENT ASSIGN QUESTION COLON

%%

programa: declfuncvar declprog
        ;

declfuncvar: tipo ID declvar SEMICOLON declfuncvar
           | tipo ID LBRACKET INTCONST RBRACKET declvar SEMICOLON declfuncvar
           | tipo ID declfunc declfuncvar
           | /* ε */
           ;

declprog: PROGRAMA bloco
        ;

declvar: COMMA ID declvar
       | COMMA ID LBRACKET INTCONST RBRACKET declvar
       | /* ε */
       ;

/* Continuar com as demais regras da gramática */

%%
void yyerror(const char *s) {
    fprintf
