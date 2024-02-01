%{
#include "y.tab.h" // Inclui o cabeçalho gerado pelo Yacc/Bison para comunicação
%}

%%

"programa"       { return PROGRAMA; }
"int"            { return INT; }
"car"            { return CAR; }
";"              { return SEMICOLON; }
","              { return COMMA; }
"["              { return LBRACKET; }
"]"              { return RBRACKET; }
"("              { return LPAREN; }
")"              { return RPAREN; }
"{"              { return LBRACE; }
"}"              { return RBRACE; }
"retorne"        { return RETORNE; }
"leia"           { return LEIA; }
"escreva"        { return ESCREVA; }
"novalinha"      { return NOVALINHA; }
"se"             { return SE; }
"entao"          { return ENTAO; }
"senao"          { return SENAO; }
"enquanto"       { return ENQUANTO; }
"execute"        { return EXECUTE; }
"ou"             { return OU; }
"e"              { return E; }
"=="             { return EQ; }
"!="             { return NE; }
"<"              { return LT; }
">"              { return GT; }
"<="             { return LE; }
">="             { return GE; }
"+"              { return PLUS; }
"-"              { return MINUS; }
"*"              { return ASTERISK; }
"/"              { return SLASH; }
"%"              { return PERCENT; }
"="              { return ASSIGN; }
"?"              { return QUESTION; }
":"              { return COLON; }
[0-9]+           { yylval = atoi(yytext); return INTCONST; }
\"[^\"]*\"       { return STRING_LITERAL; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }

[ \t\n]+         // Ignora espaços em branco
.               { return *yytext; } // Caracteres individuais

%%
