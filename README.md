# Turlang
The language of the future

![turing-pic](http://www.worldofcomputing.net/wp-content/uploads/2013/01/turingMachine.gif)

Turlang is in the most basic form of a state machine language. It allows you to build
a simple state machine super loosely based off a turing machine.

## Installing

Its a gem!

`gem install turlang`

## Running

`turlang turlangfile.tl`

## Syntax

|Command|Description|
|---|---|
|[a, b]|Sets the stack|
|:LABEL:|Sets a label (Or if its nested tells what label to jump to.|
|COND:|Conditional|
|*:|Wildcard Conditional|
|_:|Blank Conditional|
|<<|Move stack pointer to the left|
|>>|Move stack pointer to the right|
|PRINT "msg"|Print the message|
|EXIT code|Exit with code|
|Everything Else|Write it as a symbol to the current stack address|
## Example

Here is a basic turlang file:

```turlang
[1, 0, 0, 1]

:P:
  0:
    >>
    PRINT "ZERO"
    :P:
  1:
    >>
    PRINT "ONE"
    :P:
  _:
    PRINT "END"
    EXIT 0
```

This will print the stack as words:
```
ONE
ZERO
ZERO
END
```
