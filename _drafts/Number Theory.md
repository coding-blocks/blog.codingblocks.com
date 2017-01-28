#NUMBER THEORY-1

Lets talk about primes !! <br>
*A Prime Number can be divided evenly only by 1, or itself. 
And it must be a whole number greater than 1.*

Let's think how can we can check a given number is prime or not !!

**Brute approach** : 

Check for divisibility till 2 to n-1 i.e. number divisible by any of them or not !!
(as 1 and the number itself would be divisible :p )<br>
Let's implement it first : 

```c
bool prime_or_not(int n)
{
	for(int i=2;i<n;i++)
	{
		// if number divisible then return false i.e. not prime number else prime
		if(n%i==0)
			return false;
	}
	// number is prime as not divisible by any of the number 
	return true;
} 
```
 
Complexity : <br>
As traversing till that number so O(N)..


Can we **optimise** it from our basic knowledge of numbers we learnt in schools :p <br>
Let's first see , that if a number*(n)* is divisible by *x* then its also divisible by *n/x* i.e.<br>
>if 15(n) is divisible by 3(x) then its also divisible by 5(15/3) , so we can observe that we dont have to go till<br>
the n i.e. we can stop our loop till sqrt(n) : 


```c
bool prime_or_not(int n)
{
	for(int i=2;i<=sqrt(n);i++)
	{
		// if number divisible then return false i.e. not prime number else prime
		if(n%i==0)
			return false;
	}
	// number is prime as not divisible by any of the number 
	return true;
} 
```

<br><br>	
Here comes the best tool for prime numbers , **Seive of Erasthothenes** <br>
We can generate the list of primes less than n most effeciently ....

###Here is the algorithm : <br>
What it does that is turn by turn eliminates the all numbers containing any factor of prime number i.e.

>If list is 2,3,4,5,6,7,8,9,10,11,12,13,14 <br>
>then start with f = 2 <br>
>remove all 2f,3f,4f,5f... i.e. 4,6,8,10,12,14 <br>
>now list remains 2,3,5,7,9,11,13 <br>
>then start with f = 3 <br>
>remove all 2f,3f,4f,5f... i.e. 6,9,12 <br>
>now it remains 2,3,5,7,11,13 <br>
>then start with f = 5 <br>
>repeat this and you will get the list of primes <br> 


Isn't this interesting !! 

###Algorithm : 
1) Create a list from 2 to n: (2, 3, 4, …, n).<br>
2) Let F equal 2, the first prime number. <br>
3) Starting from F, count up in increments of F and mark each of these numbers greater than F itself in the list. These numbers will be 2F, 3F, 4F ....  note that some of them may have already been marked.<br>
4) Find the first number greater than F in the list that is not marked. <br>
   If there was no such number, stop. <br>
   Otherwise, let F now equal this number (which is the next prime), and repeat from step 3.<br>


```c
// prime is an array and prime[i]=0 states that i'th is prime number

void seive(int n)
{
	int prime[n];
	memset(prime,0,sizeof prime); 	// initialise prime with 0's
	prime[1]=1;
	// iterate till n
	for(int i=2;i<=n;i++)
	{
		// check if i'th is 0 i.e. prime then remove all further numbers which are having factor of this
		if(prime[i]==0)
		{
			for(int j=2*i;j<n;j+=i)
				prime[j]=1;
		}
	}	
}
```
	


This is basic algorithm to find primes !!<br>
Once you get this you will be amazed to think what this seive can do !!<br>
**To be continued** in Number Theory Part - 2<br>
Stay tuned to CB...<br>

-- Mayank Ladia 
