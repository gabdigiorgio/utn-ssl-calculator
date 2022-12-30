calc: parser.y scanner.l

	bison -d parser.y

	flex  -o scanner.lex.c scanner.l

	gcc -Wall *.c -o calc -lfl -lm



clean:

	rm -rf calc