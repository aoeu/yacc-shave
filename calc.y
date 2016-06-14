%{
	#include <stdio.h>
	int yylex(void);
	int yyparse(void);
	void yyerror(char *);
%}

%union
{
	int integerValue;
	float floatValue;
}

%token INTEGER FLOAT
%type<floatValue> expr FLOAT
%type<integerValue> INTEGER

%%

program:
	program expr '\n'		{ printf("%g\n", $2); }
	|
	;

expr:
	FLOAT				{ $$ = $1; }
	| INTEGER			{ $$ = $1; }
	| expr '+' expr			{ $$ = $1 + $3; }
	| expr '-' expr			{ $$ = $1 - $3; }
	| expr '*' expr			{ $$ = $1 * $3; }
	| expr '/' expr			{ $$ = $1 / $3; }
	| '(' expr ')'			{ $$ = $2; }
	;

%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyparse();
	return 0;
}

