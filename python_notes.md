# Python Basics 
## Types
Python is both strongly typed and dynamically typed, so a variable can have different types over its lifetime, but attempting to add a string and an integer will raise an exception.
You can check something's data type with the function type()

## For Loops
Python for loops act like foreach loops. They iterate over a collection.   
In order to simulate a traditional for loop, you use the range function, which takes in 1-3 parameters and produces a list of numbers. 
If you only provide one parameter, it will count from zero to that number, iterating by 1.  
If you use the range function and modify the iterator in the loop it sets to one after the initial value, ignoring any changes you made.  

## Collections 
You can determine the size of a collection with the len() function.  
> size = len(collection)  


### Lists
Lists are ordered and mutable.  
You can create a list with  
> new\_list = [1,2,3]  
Indexing starts at 0.  

### Tuples
Tuples are ordered and immutable  


### Dictionaries
Dictionaries are ordered.  
You can create a dictionary in Python with 
> dictionary = {}   
> dictionary[key] = value  

You can access dictionary entries with  
> value = dictionary[key]  

You can delete keys with either  

> del dictionary[key]  

or  
> removed\_value = dictionary.pop(key, return\_value\_if\_key\_is\_not\_ofound)  

### Sets
Sets are not ordered.
You can create a set in Python with  
> my\_set = set()  
> my\_set.add(value)  
or  
> my\_set = { val1, val2, val3... }  

Check set length  
> len(my\_set)  

Check for set membership  
> if 1 in set:  
> &nbsp;&nbsp; do\_something  



## File I/O
The basic idea is you create a file variable with the below syntax  
file\_var = open("path")  
some\_value = f.read() //this will read in a value from the file and move the cursor towards the end of the file  
f.seek(cursor\_position) //this will set the cursor position to a particular place in the file  

Using a "with" instead of a try-catch can streamline code, especially file I/O. An example is below   
> with open('path','w') as file:  
> &nbsp;&nbsp; file.write('this text will only display if the file opened correctly')  

## Error Handling
The format for error handling is shown below  
> try:  
> &nbsp;&nbsp; raise RuntimeWarning("error message goes here")  
> except RuntimeWarning as e //as e is optional  
> &nbsp; &nbsp; do\_something\_with(e)  

To ignore errors, simply replace the "do something" block with "pass"  

You can ignore exceptions using  
> with suppress(exception)  
> &nbsp;&nbsp; {block of code}  


## Keywords

pass does nothing, but prevents errors  lets you have an empty block of code.   
