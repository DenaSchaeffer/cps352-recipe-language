# Team Project #

University of Dayton 

Department of Computer Science

CPS 352 - Concepts and Implementation of Programming Languages, Fall 2020

Instructor: Dr. Phu Phung

### Private Repository for CPS 352 - Fall 2020 ###

# Team Members

1. Dena Schaeffer, <backd1@udayton.edu>
2. Quan Nguyen, <nguyenq2@udayton.edu>

### What is this repository for? ###
- This repo stores the information and code for the CPS352 final project.

# Language Design
## The language: Syntax and Semantics
```{bnf}
<rice>          ::= <ingredient>
<ingredient> 	::= <grams>
		        ::= <name>
		        ::= (<action> <ingredient> <ingredient>)
		        ::= cook {<name> using <ingredient>}^+(&) with <ingredient>
		        ::= taste <ingredient> yummy <ingredient> bummy <ingredient>
		        ::= recipe {<name>}^+(&) mix <ingredient> stop
				::= prepare <name> contains {<ingredient>}^+(&) stop
; fry + | cut - | combine * | split / | more > | less < | ferment ^ 
<action>        ::= "fry" | "cut" | "combine" | "split" | "more" | "less" | "ferment"  
<grams>         ::= [sign]<digit> | [sign]<digit>.<digit>
<sign>			::= + | -
<digit>        	::= [0-9]+
<name>          ::= [A-Za-z][A-Za-z0-9]*
```
## Language Description
The following explains the correlations between the language we developed and the basic syntax. We wanted to mimic our language like a recipe book, where variables act as ingredients and functions act as what you do with the ingredients.

* Rice = program
* Ingredient = expression
* Grams = a number
* Name = identifier that begins with a letter and can be followed by letters or numbers
* Action = operator (+, -, *, ^, /, >, <)
* Cook, using, and with are similar to the let expression for local binding. 
* Taste, yummy, and bummy is used for conditional evaluation (if, then, else respectively)
* Recipe acts as a function
* Prepare is used to call a recipe (function)
* Number = integer 

## Programming in your language
### Simple program
1. `(cut 1 (fry 2 3))`
2. `cook fish using 20 & cook egg using 5 with (fry fish egg)`
3. `taste 1 yummy 5 bummy 0`

### Program with function definition

```
	cook soup using recipe ingredient1 & ingredient2 { //two arguments in the function
		taste //cond
			more ingredient1 ingredient2				
		yummy //true
			ingredient1
		bummy //false
			ingredient2
	} with 
		cook noodles using 30 & chicken using 2 with //bind two identifiers with two numbers 
			cook meal using prepare soup contains noodles & chicken with (combine soup 5)
```

# Language Implementation and Evaluation
## Language Implementation

Our language design was implemented through the interpretation method. The Scheme code from Lab 4 was used as a guide for this part of our final project. We went through the following steps to implement our language:

1. Revised the-grammer in sllgen-grammar.rkt to include the new syntax and semantics. This includes the inclusion of an assignement function, conditional statement, function definition, and function call. We also defined the grammar for add, subtract, multiply, divide, less-than, more-than, and power functions.
2. Revised eval-primapp in myinterpreter.rkt to include implementation of the functions with primitives (add, subtract, multiply, divide, less-than, more-than, power).
3. Implemented error handling to catch invalid sentences. 

## Evaluation
