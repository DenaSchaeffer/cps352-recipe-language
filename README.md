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
## The language: Syntax and semantic
```{bnf}
<program> ::= <expr>
<expr> 	::= <number>
		::= <identifier>
		::= (<operation> <expr> <expr>)
		::= let {<identifier> = <expr> }^+(,) in <expr>
		::= if <expr> then <expr> else <expr>
		::= function(<identifier>) { <expr> }
<operation> ::= + | - | * | / | ^
<number> ::= <integer> | -<integer> | <integer>.<integer> | -<integer>.<integer>
<integer> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
```

## Programming in your language