%{
#include "seu_analisador_lexico.h" // Incluir o cabeçalho do analisador léxico

void yyerror(const char *s);
%}

%token PROGRAMA CAR INTCONST ID STRING_LITERAL
%start Programa

%%
Programa: DeclFuncVar DeclProg { /* Código semântico aqui */ };

// Adicionar as outras regras gramaticais...
%%

void yyerror(const char *s) {
    fprintf(stderr, "ERRO: %s na linha %d\n", s, yylineno);
}

int main(int argc, char **argv) {
    // Adicionar o código para abrir o arquivo e iniciar o parsing
    return yyparse();
}
