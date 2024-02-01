#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h" // Inclua o cabeçalho gerado pelo Yacc/Bison.

extern FILE *yyin; // Declaração externa para o arquivo de entrada do Flex.
extern int yyparse(void); // Declaração externa para a função gerada pelo Yacc/Bison.
extern int linha; // Contador de linhas para mensagens de erro.

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <arquivo>\n", argv[0]);
        exit(1);
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror(argv[1]);
        exit(1);
    }

    yyin = file; // Direciona o yyin para ler do arquivo especificado.
    yyparse(); // Chama o analisador sintático.
    fclose(file);

    return 0;
}
