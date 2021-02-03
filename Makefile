# Patrascoiu Ion - Radu, 336CC 

build:
	flex tema.l
	gcc lex.yy.c -o tema

run:
	./tema

clean:
	rm tema lex.yy.c
