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
'pi = 3.14       # Immutable, inferred type as float

# pi += 1
# Error: Cannot modify `pi` because it is immutable

.hello = "hello" # Mutable, inferred type as str

hello += "!"     # hello becomes "hello!"
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

# ">>" insert strings into console output
>> "enter a number: "

# Equivalent to:
# "enter a number: " >> cout

# "<<" reads a line and returns result
'first_input = << cin

# Entered: 2
# first_input == "2"

>> "\nenter another number: "

# "<<" can also read a line and insert into existing strings
.second_input = "1"

second_input <<= cin
# Equivalent to:
# second_input = second_input << cin

# Entered: 3
# second_input == "13"

# Automatic string formatting via "{}"
>> "\nresult: {to_int(first_input) + to_int(second_input)}\n"

# Output: result: 15
```

### Function Declaration
```
# Function names allow only alphabet characters and "_"

## Function with inferred return type of void
'greet_user():
	>> "hello user!\n"

# Somewhat equivalent to the following:
# 'greet_user = ||:
#    >> "hello user!\n"

greet_user()
# Output: hello user!

## Function with single parameter, type must be specified
'greet(str user):
	>> "hello {user}!\n"

greet("person")
# Output: hello person!

# Symbolically named functions are declared using "`",
# and only allow the following characters:
# +, -, /, *, ^, %, <, >, <<, >>

# Symbolically named functions don't need parenthesis
# when calling. Additionally, defining them also
# automatically generate shortcuts like `+=` and `<<=`

## Two parameters are specified, the first one must
## be on the left side of the function when called.
## Return type must be specified if not void.
`+(str left, int right) str:
	"left{right}"

# str + int, so the function "+" is called
>> "forty-two is " + 42
# Output: forty-two is 42
```

### Struct Declaration
```
# Blueprint for creating an object
'Person:

	# Fields must be type annotated
	int age
	str name

	# Static fields, these values stay with blueprints
	# and are not initialized with new instances.
	# They can't be type annotated and must have a default
	# value or else it would be treated as an enum.
	'core = "heart"
	'Tall
	'Short

	Person.* height
	# equivalent to `Person.{Tall, Short}`

'joe = Person(42)
joe.name = "Joe"
joe.height = Person.Tall

>> "{joe.name} is {joe.age} years old, and he's {joe.height}."
# Output: Joe is 42 years old, and he's Tall.
```

### For Loop
```
# All of these loops have the same output!

'i @ [0, 1, 2]:
	>> i + 1

>> " "

'i @ 3:
	>> i + 1

>> " "

'i @ 1..4:
	>> i

>> " "

'i @ "012":
	>> to_int(i) + 1

# Output: 123 123 123 123
```