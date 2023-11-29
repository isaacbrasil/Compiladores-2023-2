%{
#include "y.tab.h" // Inclua o arquivo de cabeçalho gerado pelo Bison/YACC
%}

%option noyywrap

// Lista das palavras reservadas
%token PROGRAMA CAR INT RETORNE LEIA ESCREVA NOVALINHA SE ENTAO SENAO ENQUANTO EXECUTE

%%
%%

// Definições das palavras reservadas
programa        { return PROGRAMA; }
car             { return CAR; }
int             { return INT; }
retorne         { return RETORNE; }
leia            { return LEIA; }
escreva         { return ESCREVA; }
novalinha       { return NOVALINHA; }
se              { return SE; }
entao           { return ENTAO; }
senao           { return SENAO; }
enquanto        { return ENQUANTO; }
execute         { return EXECUTE; }

// Definição de identificador
[a-zA-Z_][a-zA-Z0-9_-]* { yylval.string = strdup(yytext); return ID; }

// Comentários
"/*"            { BEGIN(COMMENT); }
<COMMENT>"*/"   { BEGIN(INITIAL); }
<COMMENT>.|\n   { /* Ignore tudo dentro dos comentários */ }

// Erros
<<EOF>>         { if (YY_START == COMMENT) {
                    yyerror("Comentário não terminado.");
                  }
                }
.               { yyerror("Caractere inválido."); }

// Esta seção deve conter código para retornar tokens para literais numéricos, strings, operadores, etc.
// Adicione suas próprias regras aqui.

%%
