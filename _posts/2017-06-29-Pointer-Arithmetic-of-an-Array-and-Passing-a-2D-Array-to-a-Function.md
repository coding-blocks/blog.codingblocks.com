---
layout: post
title: "Pointer Arithmetic of an Array and Passing a 2D Array to a Function"
description: " "
headline: ""
modified: 2017-06-20 12:20:09 +0530
category: ['Pointers', 'Arrays']
tags: [Pointers, Arrays]
feature-img: "img/post/pointer-arthemetic/pointers.jpg"
mathjax:
author: 'Abhishek Singh'
chart: 
comments: true
featured: false
---

Let's see how a one-dimensional array is stored in a computer memory.


For example, let an array:
                         A = [   3   ][   4   ][   5   ][   6   ][   7   ]      -> value stored in an integer array
                                 200    204     208    212     216         -> these are the address of the memory of the array. As it is an integer array each element has a storage of 4 bytes.

To declare a pointer to a one-dimensional array we simply write:
 
    int *ptr = A; 
this pointer ptr points to the starting block of the array A. Also, the name of the array i.e A just returns a pointer to the first element of the array.
With the pointer declared we can use pointer arithmetic and dereferencing to access the address and elements of the array.
for example,

print ptr  will give output = 200

print *ptr will give output = 3, i.e the value stored at that memory location (this is called as                                                                                                                                           dereferencing )
print *(ptr +2)  will give us the output 5  as ptr is a pointer to an integer so increasing ptr two times will enhance it to further 8 bytes.

print (ptr +2)  = 208

The language flexibility allows us to use the name of the array as a pointer. Therefore instead of using ptr we can directly use A.
i.e ,

print A = 200
print *A = 3
print *(A+2) = 5
print A+2 = 208

in short,
*(A+i) is same as A[i]
and (A+i) is same as &A[i]

Therefore, ptr = A  but A != ptr .

we can pass a one-dimensional array  in a function as follows:

void myfunction (int *arr)
{
       int n = arr.size();
       cout<<arr[i];
}

int main()
{
   int arr = {1,2,3,4,5,6};
   myfunction(arr);
}

We can do the same thing in a multi-dimensional array. What does it mean when we say multi-dimensional array? A multi-dimensional array is an array of array.
 Let's talk about the two-dimensional array:

Suppose we have a 2-D array:
 B[2][3] = [  [ 2 , 3, 6 ] , [ 4 , 5  ,8  ] ]
                     400             412            -> memory address of the arrays.
Now each element  B[0] and B[1] is an array of integers consisting of three integers each. Hence each block would have a size of 3*4 bytes i.e 12 bytes. Therefore B[0] contains the starting address of the first array  i.e 400  and B[1] contains the starting address of the second array i.e 412.

if we  write,
int *ptr = B ; this will return an error because ptr is a pointer to integer but B is a pointer to a 1-D array of integers.
We can define a pointer to 1-D array of three integers like this:
int (*ptr)[3] = B ;

print B  is same as print (B+0)  and from the above-given statement in 1-D array, (B+i) = &B[i]
 Therefore print B = print  &B[0]  = 400 .

Similarly,
print *B is same as print B[0]  which is equal to a variable name of an array as B[0] is itself a 1-D array, therefore, B[0] will act as a pointer to the address of  first  element of the array B[0] i.e &B[0][0] which is equal to 400.  

Now the output of
print B+1 = &B[1] which is equal to 412 .

print *(B+1) is same as print B[1] which is equal to a variable name of an array as B[1] is itself a   1-D array, therefore, B[1] will act as a pointer to the address of  first  element of the array B[1] i.e &B[1][0] which is equal to 412.

print *(B+1) + 2 = 420. As *(B+1) is a pointer to an integer containing the address of B[1][0] and if we do pointer arithmetic this will occur in terms of bytes. Therefore B[1] + 2 will give the address of B[1][2].

print *(*B + 1) = 3 . As *B returns a pointer to the first integer of the array B[0] and adding 1 to it will take it to the address of B[0][1] which is equal to the value of &B[0][1] again dereferencing it will give the value stored at B[0][1] which is equal to 3.

For 2-D array,
B[i][j] = *(B[i] + j) = *(*(B+i) + j) 

Now passing  a two-dimensional array into a function:

void myfunction(int **A ,int i, int j)
{
  cout<<A[0][2];
}

int main()
{
  A[2][3] = {{1,2,3},{4,5,6}};

  myfunction(A,2,3);
}
 we can also return a 2-D array from a function by just changing the return type to:
 int **  (if it's a 2D- array of integers)
