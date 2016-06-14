%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
%}

%%

[0-9]+\.[0-9]+	{
			yylval.floatValue = atof(yytext);
			return FLOAT;
		}
[0-9]+		{
			yylval.integerValue = atoi(yytext);
			return INTEGER;
		}

[-+()/*\n]		return *yytext;

[ \t]		; /* skip whitespace */

.		yyerror("invalid character");

%%

int yywrap(void) {
	return 1;
}

