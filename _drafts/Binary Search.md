#BINARY SEARCH

If we are given random array and search for a given element !! <br>
Simple Approach : traversing the array once.

*Little modification : Now what if we are given an sorted array , now how can one find the element !!* <br>
Simple Approach : Linear search i.e. again by traversing the array elements one by one.

```c
// to check whethear element present or not
bool find_element(int A[],int length,int elem_to_found)
{
	bool ans = false; // assume not found till now
	for(int i=0;i<length;i++)
		if(A[i]==elem_to_found)	
			ans = true; // element found
	
	return ans;
}
```

>Task : Think what should we have to do in order to find at which index element find in array


Now, think what is use of sorting for searching a element.<br>
Here comes best tool **binary search** i.e. you dont have to traverse a whole array for searching the element and <br>here how it works : 

<br>
Binary search looks for a element_to_be_found by comparing the middle index of array (mid)<br>
If its less than the element_to_be_found then it search in the right half of the array i.e. (from mid till end of array) <br>
otherwise if its greater than element_to_be_found than it searches in the left half i.e. (from 0 till mid of array)<br>



Lets look at the *implementation of binary search* first move to *recursive* function : 

```c
// lets look at the base cases first ( most imp for recursive function )
// if element_to_be_found is found return 
// if low(left) and high(right) goes out of bound then return 

binary_search_recur(int A[],int element_to_be_found,int low,int high)
{
	// element_to_be_found not present in the array
	if(low>high)	return -1;
	
	int mid = (low+high)/2;
	// element found at mid position
	if(A[mid]==element_to_be_found)	return mid;
	
	// if its greater than the mid element recurse again for left half of array i.e. (low,mid-1)
	if(element_to_be_found>A[mid])
		binary_search_recur(A,element_to_be_found,low,mid-1)
	
	// else its less than the mid element recurse again for right half of array i.e. (mid+1,high)
	else(element_to_be_found>A[mid])
		binary_search_recur(A,element_to_be_found,mid+1,high)
}
```


Now look at the *iterative* one : ;) 

```c
binary_search(int A[],int element_to_be_found)
{
	int low = 0, high = size(A);

	// search for the whole array
		
	while(low<=high)
	{
		// find the middle value
		mid = (low+high)/2;
		
		// if middle element eequals element_to_be_found return index
		if(element_to_be_found==A[mid])
			return mid;
		// if its less then the middle element then it searches for right half and leave the left half
		else if(element_to_be_found<A[mid])
			low = mid+1;
		// if its greater then the middle element then it searches for left half and leave the right half			
		else
			high = mid-1;
	}
	// target not found
}

// seems easy ;) 
// we can make fun with binary search with structures, trees, reverse binary search 
```


**Complexity** : 

As in each comparision it uses half of the search space ( leaving left part or leaving right part from middle ) <br>
i.e. in each comparision it does like<br>
N -> N/2 -> N/4 ....<br>
i.e. it simply proves it takes (big-o-notation) **O(log(N))**<br>





Upcoming blog of binary search will be more interesting ,<br>
it will tell the actual power of binary search ;) <br>
Stay Tuned with Coding Blocks ....   <br>


-- Mayank Ladia
