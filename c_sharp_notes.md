# C#

## Basics
C# is just Java with some extra capital letters.    
C# runs on a "virtual execution system" call .NET  
C# has objects and functions, just like Java  
> class MyClass{  
> &nbsp;&nbsp; public static void Main(){  
> &nbsp;&nbsp;&nbsp;&nbsp;do\_code\_things()  
> &nbsp;&nbsp; }  
> }  

## Data Types
C# is statically typed.  
There is a keyword *var* that essentially means *auto*  

## Data Structures
Function calls on data structures start with a capital lettter.  
> list.Add(element);

### Lists
Lists are created with    
> var my\_list = new List<type> {'optional', 'initializing', 'members'};  

Add elements with Add.  
> list.Add(element);  

Remove elements with Remove.  
> list.Remove(element);  

Access elements with square brackets.  
> element1 = list[0];

Lists can be sorted easily with  
> list.sort()  

## Flow Control

### Foreach
C# has a foreach loop shown below  
> foreach(var v in collection){  
> &nbsp;&nbsp; do\_code\_things();  
> }  

### if-then-else
C# if-then-else blocks are identical to Java.
