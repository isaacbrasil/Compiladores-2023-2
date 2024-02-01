%{
#include "y.tab.h"
int linha = 1; // Variável para contar as linhas
%}

%option noyywrap

%%

"programa"   { return PROGRAMA; }
"car"        { return CAR; }
"int"        { return INT; }
"retorne"    { return RETORNE; }
"leia"       { return LEIA; }
"escreva"    { return ESCREVA; }
"novalinha"  { return NOVALINHA; }
"se"         { return SE; }
"entao"      { return ENTAO; }
"senao"      { return SENAO; }
"enquanto"   { return ENQUANTO; }
"execute"    { return EXECUTE; }
"?"          { return QUESTION; }
":"          { return COLON; }
"%"          { return PERCENT; }
"!"          { return NOT; } 

\"[^"\n]*\"  {
    yylval.str = strdup(yytext);
    return CONSTSTRING;
}

[a-zA-Z_][a-zA-Z_0-9]* {
    yylval.str = strdup(yytext);
    return ID;
}

"/*" {
    char c, prev = 0;
    while ((c = input()) != 0) {
        if (c == '\n') linha++;
        if (c == '/' && prev == '*') break;
        prev = c;
    }
    if (c == 0) {
        printf("ERRO: COMENTARIO NAO TERMINA na linha %d\n", linha);
        exit(1);
    }
}

\n            { linha++; }
[\t ]         ; // Ignora espaços em branco e tabs
.             { printf("ERRO: CARACTERE INVALIDO '%c' na linha %d\n", *yytext, linha); exit(1); }

%%
