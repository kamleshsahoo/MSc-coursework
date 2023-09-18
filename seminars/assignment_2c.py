'''
Define a function "function_2c" that takes 4 inputs. Then do the following:

 1) Multiply the 2nd to the 3rd input and store the result in a variable.

 2) Divide the 2nd by 3rd input and store the result in a variable.

 3) Add the 1st to the last input and store the result in a variable.

 4) Subtract the last from the 1st input and store the result in a variable.

 5) Create a final result variable that stores a list of all the above variables along with the corresponding arithmetic operation associated with each variable. 
For eg: if the result of multiplication is 10 then the output should look like -  'Multiply: 10'. 

 6) Return the result variable.

"""
def function_2c(w, x, y, z):

    multiplication = x * y
    division = x / y
    addition = w + z
    subtraction = w - z

    results = {"multiply": multiplication,
               "divide": division,
               "add": addition,
               "subtract": subtraction}

    return results