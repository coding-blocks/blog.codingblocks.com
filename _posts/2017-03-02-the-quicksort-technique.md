---
layout: post
title: "The quicksort technique"
description: "How to sort an array ?"
headline: "Understanding the quicksort technique"
modified: 2017-03-02 02:40:18 +0530
category: [Algorithms]
tags: [algorithms, programming, cpp, search, quicksort]
feature-img: "img/post/quicksort/quicksort.png"
author: Mayank Ladia
mathjax: 
chart: 
comments: true
featured: false
---
Quick Sort works on **Divide and Conquer** technique.
Lets first take a basic idea of quick sort ,

 1.  It picks up an element(any element) in the array as pivot(nothing imp we have just named it)
 2.  Go through every element of array and **place** this **pivot** at its **correct place** i.e.
     All elements smaller than pivot should be left of it,
     and all elements greater than pivot should be at right of it
 3.  Recursively call this again and again


### Choosing Pivot:

Now what should be choosen as pivot element . how to choose that as said it can be any element either last element , mid index , first , or any index'th element.

>Example :<br> [10,9,8,20,30,40,10,6,1,11] <br>
>we let choose the last element as pivot hence we choose 11 as pivot i.e. index at p.

Rearrange the array such that all other elements less than this ellement is in left of it and greater are right of it and this method of rearranging is called as partitioning.
We dont have to think the order of other elements rather the pivot should be at correct place only.

Now Divide and conquer this thing recursively for the subarrays *A[0..p-1]* and *A[p+1..n]* .


***To understand this more clearly lets implement it***..


```c
// as said any element can be taken as partition but , lets implement by taking only the last element now
// what it does is placing all smallers in left and all greater in right half
void partition(int A[],int low,int high)
{
	// pivot i.e. to be place at correct position
	pivot = A[high];

	// from where to start array
	p=low

	for(i=low;i<=high;i++)
	{
		if(A[i]<=pivot)
		{
			swap(A[i],A[p])
			p++;
		}
	}
	swap(A[p],A[high])
	return p;
}

void quick_sort(int A[],int low,int high)
{
	if(low<high)
	{
		// partitioning takes place i.e. now A[p] will be at correct position
		int p = partition(A,low,high)

		// call recursively for left half and right half
		quick_sort(A,low,p-1)
		quick_sort(A,p+1,high)
	}
}
```

For **[visualisation](https://visualgo.net/sorting)**


**Time Complexity** :

Worst Case Time Complexity | O(n^2)<br>
Best Case Time Complexity | O(n log n)<br>
Average Time Complexity | O(n log n)<br>
Worst Space Complexity | O(n)<br>
Best Space Complexity | O(log n)<br>
Average Space Complexity | O(log n)<br>

