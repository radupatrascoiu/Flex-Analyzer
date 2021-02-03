Patrascoiu Ion - Radu, 336CC
%{
#include<stdio.h>
int nr_var_loc = 0;
char* return_type;
char* name_function;
char local_variables[100];
%}
%s URMATOR
%s STARE_1
%s STARE_2
%s STARE_3
start \/\* 
end  \*\/
preprocessor_directive #.*
instruction for|while|do|if|return
type char|double|float|int|long|short|void|signed
var_type char|double|float|int|long|short|signed
letter [a-zA-Z_]
symbol [{};.=*&^%$#@!'":|\/?><]
digit [0-9]
brackets [\[]]*
after_comma [, ]
space [ ]
letter_digit [a-zA-Z0-9_]
semicolon [;]*
right_bracket [\)]*
new_line [\n]
inequality [<>=]
sign [+-]
operations [+*/%^&-]
%%

<INITIAL>{type}+{space}+ {
	nr_var_loc = 0;
	return_type = malloc(yyleng);
	strcpy(return_type, yytext);
	return_type[yyleng - 1] = '\0';
	yymore();
	BEGIN(STARE_1);
}

<STARE_1>{letter_digit}+"("+ {
	int strlen_name = yyleng - strlen(return_type) - 1;
	name_function = malloc(strlen_name);
	strcpy(name_function, yytext + strlen(return_type) + 1);
	name_function[strlen_name - 1] = '\0';

	yymore();
	BEGIN(STARE_2);
}

<STARE_2>{type}+{space}+{letter_digit}*{brackets}*","*|","+{space}*{type}*{space}+{letter_digit}*{brackets}*","* {
	printf("%s ", yytext);
}

<STARE_2>","*{space}*{type}*{space}*{letter_digit}*{brackets}*")"+ {
	printf("%s\n", yytext);
	printf("       tip intors: %s\n", return_type);
	printf("       nume: %s\n", name_function);
	BEGIN(STARE_3);
}

<STARE_3>{instruction}{space}*"("{letter_digit}+{space}*{inequality}+{space}*{letter_digit}*";"+{space}*{letter_digit}+{space}*{inequality}+{space}*{letter_digit}*";"+{space}*{letter_digit}+{space}*{sign}+{sign}+")" ;
<STARE_3>{instruction}{space}*"("{letter_digit}+{space}*{inequality}+{space}*{letter_digit}*")"+ ;
<STARE_3>"return"+{space}+{letter_digit} BEGIN(INITIAL);
<STARE_3>{letter}+{space}*"="+{space}*{letter_digit}*{space}*{operations}+{space}*{letter_digit}* ;

<STARE_3>{var_type}+{space}+{letter}+{brackets}*"["*{digit}*"]"*/";"+ {
	printf("       variabile locale: 1 (%s)\n\n", yytext);

	BEGIN(INITIAL);
}

<STARE_3>{var_type}+{space}+{letter}+{brackets}*{space}*/"="+{space}*"{"+{letter_digit}+ {
	nr_var_loc++;
	if (strcmp(&yytext[yyleng - 1], " ") == 0) {
		yytext[yyleng - 1] = '\0';
	}
	strcat(local_variables, yytext);
	strcat(local_variables, ", ");
	if (strcmp(&yytext[yyleng - 1], ";") == 0) {
		char new_string[100]; 
		memcpy(new_string, local_variables, strlen(local_variables) - 3);
		memset(local_variables, 0, strlen(local_variables));
		printf("       variabile locale: %d (%s)\n\n", nr_var_loc, new_string);
		nr_var_loc = 0;
		BEGIN(INITIAL);
	}
	BEGIN(STARE_3);
}

<STARE_3>{digit}+ ;
<STARE_3>{letter}+{space}*{brackets}*{space}*/"="+{space}+{letter_digit}+";"* {
	nr_var_loc++;
	if (strcmp(&yytext[yyleng - 1], " ") == 0) {
		yytext[yyleng - 1] = '\0';
	}
	strcat(local_variables, yytext);
	strcat(local_variables, ", ");
	if (strcmp(&yytext[yyleng - 1], ";") == 0) {
		char new_string[100]; 
		memcpy(new_string, local_variables, strlen(local_variables) - 3);
		memset(local_variables, 0, strlen(local_variables));
		printf("       variabile locale: %d (%s)\n\n", nr_var_loc, new_string);
		nr_var_loc = 0;
		BEGIN(INITIAL);
	}
	BEGIN(STARE_3);
}

<STARE_3>{var_type}+{space}+{letter}+{brackets}*/","*";"* {
	nr_var_loc++;
	strcat(local_variables, yytext);
	strcat(local_variables, ", ");
	if (strcmp(&yytext[yyleng - 1], ";") == 0) {
		char new_string[100]; 
		memcpy(new_string, local_variables, strlen(local_variables) - 3);
		memset(local_variables, 0, strlen(local_variables));
		printf("       variabile locale: %d (%s)\n\n", nr_var_loc, new_string);
		nr_var_loc = 0;
		BEGIN(INITIAL);
	}
	BEGIN(STARE_3);
}

<STARE_3>{letter}+"["+{digit}+"]"+","*";"* {
	nr_var_loc++;
	strcat(local_variables, yytext);
	strcat(local_variables, ", ");
		if (strcmp(&yytext[yyleng - 1], ";") == 0) {
		char new_string[100]; 
		memcpy(new_string, local_variables, strlen(local_variables) - 3);
		memset(local_variables, 0, strlen(local_variables));
		printf("       variabile locale: %d (%s)\n\n", nr_var_loc, new_string);
		nr_var_loc = 0;
		BEGIN(INITIAL);
	}
	BEGIN(STARE_3);
}

<STARE_3>","+{space}*{letter}+{space}*"="*{space}*/","+ {
	nr_var_loc++;
	memcpy(yytext, yytext + 2, strlen(yytext));
	strcat(local_variables, yytext);
	strcat(local_variables, ", ");
	BEGIN(STARE_3);
}

<STARE_3>{letter}+{brackets}*";"+ {
	nr_var_loc++;
	strcat(local_variables, yytext);
	strcat(local_variables, ", ");
	if (strcmp(&yytext[yyleng - 1], ";") == 0) {
		char new_string[100]; 
		memcpy(new_string, local_variables, strlen(local_variables) - 3);
		memset(local_variables, 0, strlen(local_variables));
		printf("       variabile locale: %d (%s)\n\n", nr_var_loc, new_string);
		memset(new_string, 0, strlen(new_string));
		nr_var_loc = 0;
		BEGIN(INITIAL);
	}
	BEGIN(STARE_3);
}

{preprocessor_directive} ;
"printf" ;
\/\/(.*) ; // comentariu pe o singura linie
{start}.*{end} ; // comentariu pe mai multe linii
{symbol} ;
\n ;
, ;
{letter_digit}+{space}*{operations}*{space}*"="{space}*{letter_digit} ;
" " ;

%%

int main(void){
	yyin = fopen("file3.c","r");
	yylex();
	fclose(yyin);
} 
int yywrap(){
	return(1);
}