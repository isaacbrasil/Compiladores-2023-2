CC = gcc
CFLAGS = -Wall -g
LEX = flex
YACC = bison
YFLAGS = -d
OBJS = lex.yy.o y.tab.o main.o

all: cafezinho

cafezinho: $(OBJS)
	$(CC) $(CFLAGS) -o cafezinho $(OBJS) -lfl

lex.yy.o: cafezinho.l y.tab.h
	$(LEX) cafezinho.l
	$(CC) $(CFLAGS) -c lex.yy.c

y.tab.o: cafezinho.y
	$(YACC) $(YFLAGS) cafezinho.y
	$(CC) $(CFLAGS) -c y.tab.c

main.o: main.c
	$(CC) $(CFLAGS) -c main.c

clean:
	rm -f cafezinho $(OBJS) lex.yy.c y.tab.c y.tab.h
