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
		        ::= recipe <name> contains <ingredient> 
<action>        ::= "fry" | "cut" | "combine" | "split" | "ferment"  ; fry + | cut - | combine * | split / | ferment ^
<grams>         ::= <number> | -<number> | <number>.<number> | -<number>.<number>
<number>        ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
<name>          ::= [A-Za-z]*
```
## Language Description
The following explains the correlations between the language we developed and the basic syntax.

* Rice = program
* Ingredient = expression
* Grams = number
* Name = identifier
* Action = operator
* Cook, using, and with are similar to the let expression for local binding. 
* Taste, yummy, and bummy is used for conditional evaluation (if, then, else respectively)
* Recipe and contains act as functions
* Number = integer 

## Programming in your language
### Simple program
1. (cut 1 (fry 2 3))
2. cook fish using 20 & cook egg using 5 with (fry fish egg)
3. taste 1 yummy 5 bummy 0
