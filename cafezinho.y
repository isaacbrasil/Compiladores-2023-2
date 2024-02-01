%{
#include <stdio.h>
#include <stdlib.h>
extern int linha; // Para acesso à variável de contagem de linhas do Flex.

void yyerror(const char *s);
%}

%token PROGRAMA CAR INT RETORNE LEIA ESCREVA NOVALINHA SE ENTAO SENAO ENQUANTO EXECUTE
%token QUESTION COLON PERCENT NOT CARCONST
%token ID INTCONST STRING_LITERAL
%token SEMICOLON COMMA LBRACKET RBRACKET LPAREN RPAREN LBRACE RBRACE ASSIGN PLUS MINUS
%token ASTERISK SLASH EQ NE LT GT LE GE OU E

// Definições de tipos para valores passados entre as regras gramaticais, se necessário.
%union {
    char* str;
    int intval;
}

%type <str> ID STRING_LITERAL
%type <intval> INTCONST

%%

programa: declfuncvar declprog
    ;

declfuncvar
    : tipo ID declvar SEMICOLON declfuncvar
    | tipo ID LBRACKET INTCONST RBRACKET declvar SEMICOLON declfuncvar
    | tipo ID declfunc declfuncvar
    | /* ε */
    ;

declprog: PROGRAMA bloco
    ;

declvar
    : COMMA ID declvar
    | COMMA ID LBRACKET INTCONST RBRACKET declvar
    | /* ε */
    ;

declfunc: LPAREN lista_parametros RPAREN bloco
    ;

lista_parametros
    : /* ε */
    | lista_parametros_cont
    ;

lista_parametros_cont
    : tipo ID
    | tipo ID LBRACKET RBRACKET
    | tipo ID COMMA lista_parametros_cont
    | tipo ID LBRACKET RBRACKET COMMA lista_parametros_cont
    ;

bloco: LBRACE lista_declvar lista_comando RBRACE
    | LBRACE lista_declvar RBRACE
    ;

lista_declvar
    : /* ε */
    | tipo ID declvar SEMICOLON lista_declvar
    | tipo ID LBRACKET INTCONST RBRACKET declvar SEMICOLON lista_declvar
    ;

tipo: INT
    | CAR
    ;

lista_comando
    : comando
    | comando lista_comando
    ;

instrucao_if
    : SE LPAREN expr RPAREN ENTAO comando SENAO comando
    | SE LPAREN expr RPAREN ENTAO comando
    ;


comando
    : SEMICOLON
    | expr SEMICOLON
    | RETORNE expr SEMICOLON
    | LEIA lvalueexpr SEMICOLON
    | ESCREVA expr SEMICOLON
    | ESCREVA STRING_LITERAL SEMICOLON
    | NOVALINHA SEMICOLON
    | instrucao_if
    | ENQUANTO LPAREN expr RPAREN EXECUTE comando
    | bloco
    ;

expr: assignexpr
    ;

assignexpr
    : condexpr
    | lvalueexpr ASSIGN assignexpr
    ;

condexpr
    : orexpr
    | orexpr QUESTION expr COLON condexpr
    ;

orexpr
    : orexpr OU andexpr
    | andexpr
    ;

andexpr
    : andexpr E eqexpr
    | eqexpr
    ;

eqexpr
    : eqexpr EQ desigexpr
    | eqexpr NE desigexpr
    | desigexpr
    ;

desigexpr
    : desigexpr LT addexpr
    | desigexpr GT addexpr
    | desigexpr LE addexpr
    | desigexpr GE addexpr
    | addexpr
    ;

addexpr
    : addexpr PLUS mulexpr
    | addexpr MINUS mulexpr
    | mulexpr
    ;

mulexpr
    : mulexpr ASTERISK unexpr
    | mulexpr SLASH unexpr
    | mulexpr PERCENT unexpr
    | unexpr
    ;

unexpr
    : MINUS primexpr
    | NOT primexpr
    | primexpr
    ;

lvalueexpr
    : ID LBRACKET expr RBRACKET
    | ID
    ;

primexpr
    : ID LPAREN listexpr RPAREN
    | ID LPAREN RPAREN
    | ID LBRACKET expr RBRACKET
    | ID
    | INTCONST
    | CARCONST
    | LPAREN expr RPAREN
    ;

listexpr
    : assignexpr
    | listexpr COMMA assignexpr
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "ERRO: %s na linha %d\n", s, linha);
}

int main(int argc, char *argv[]) {
    extern FILE *yyin;
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <arquivo>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror(argv[1]);
        return 1;
    }

    yyparse();
    fclose(yyin);
    return 0;
}
