# Soulith

> **Soul** + Zen**ith** = **Soulith**

A compiled programming language with a focus on built-in graphics capability

## Syntax

### Comments
```
# This is a single-line comment.

## This is a descriptor for things like functions and structs,
## and also extends if chained together!
'my_func():
	...
```

### Variable Declaration
```
# Inferred type as float
'pi = 3.14

# Inferred type as str
'hello = "hello"
```

### Importing Libraries
```
# Import std
::std

# Import cout from std
::std.cout

# Import multiple from std
::std.{cin, cout}

# Import everything from std
::std.*
```

### Console Input/Output
```
# std is imported by default!
# ::std.*

# ">>" insert strings into a file
"enter a number: " >> cout

# "<<" reads a line and returns result
'first_input = << cin
# entered: 2
# first_input == "2"

"\nenter another number: " >> cout

# "<<" can also read a line and insert into existing strings
'second_input = "1"
second_input << cin
# entered: 3
# second_input == "13"

# automatic string formatting via "{}"
"\nresult: {to_int(first_input) + to_int(second_input)}\n" >> cout
# output: result: 15
```

### Function Declaration
```
# function names allow only alphabet characters and "_"

## function with inferred return type of void
'greet_user():
	"hello user!\n" >> cout

greet_user()
# output: hello user!

## function with single parameter, type must be specified
'greet(user; str):
	"hello {user}!\n" >> cout

greet("person")
# output: hello person!

# symbolic functions are declared using "`", and 
# allow only unique characters like "<" and "+".
# symbolic functions don't need parenthesis
# when calling, and is not allowed to
# have more than 2 parameters

## Two parameters are specified, the first one must
## be on the left side of the function when called.
## Inferred return type of str.
`+(left; str, right; int):
	"left{right}"

# str + int, so the function "+" is called
"forty-two is " + 42 > cout
# output: forty-two is 42
```

### Struct Declaration
```
# Blueprint for creating an object
'Person:

	# Fields with no default value must be type annotated
	age; int

	# Fields with default value don't need type annotation
	name = "anon"

	# Static fields, these values stay with blueprints
	# and are not initialized with new objects.
	# They can't be type annotated and must have a default
	# value or else it would be treated as an enum.
	'core = "heart"
	'Tall
	'Short

	height = Short

'joe = Person(42)
joe.name = "Joe"
joe.height = Person:Tall

"{joe.name} is {joe.age} years old, and he's {Joe.height}." >> cout
# output: Joe is 42 years old, and he's Tall.
```

### For Loop
```
# All of these loops have the same output!

i @ [0, 1, 2]:
	"{i + 1}" >> cout

i @ 3:
	" {i + 1}" >> cout

i @ 1..4:
	" {i}" >> cout

i @ "012":
	" {to_int(i) + 1}" >> cout

# output: 123 123 123 123
```