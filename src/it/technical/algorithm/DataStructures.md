---
title: "算法与数据结构小结"
tags: algorithm datastructure
---



#算法与数据结构小结#

##概述##
本科阶段学习数据结构与算法主要是受高中NOIP、NOI以及大学ACM等比赛的影响。
另一方面，感觉这些东西能够激发自己的兴趣爱好，何乐而不为呢？

在大一下学期时，我立下了一个目标: 争取认真阅读《算法导论》并力争完成所有的课后题。
现在翻看过去的笔记，已经是多少年以前的事情了。
至此，我准备借着复习之际将当时的笔记与现在的体会放在这个Wiki上面。

##算法导论##
###第一部分 基础知识###
####分析基础####
利用渐进分析技术对具体算法的时间复杂度进行分析。

####基本设计方法####
#####分而治之#####
在算法结构上主要呈递归模式: 为了解决一个给定的问题，算法要一次或多次地递归调用其自身来解决相关的子问题。

分治策略: 将原文题划分成n个规模较小而结构与原问题相似的子问题；递归地解决这些子问题，然后再合并其结果，就得到原问题的解。

每一层递归上的基本步骤:
  1. 分解，将原问题分解成一系列子问题
  1. 解决，递归地解各个子问题。若子问题足够小，则直接求解
  1. 合并，将子问题的结果合并成原问题的解

####随机分析和随机算法####
在算法中添加随机处理技术，将固有的问题做随机化处理，使其能够有效地呈现出一般趋势。


###第二部分 排序和顺序统计学###

####O(n^2^)排序方法####

#####插入排序#####
{% highlight c %}
#A[1..length]
INSERTION-SORT(A)
  for j <- 2 to length[A]
  do
    key <- A[j]
    i <- j - 1
    while i>0 and A[i]>key
    do
      A[i+1] <- A[i]
      i <- i - 1
    A[i+1] <- key
{% endhighlight %}

#####冒泡排序#####
{% highlight c %}
#A[1..length]
BUBBLE-SORT(A)
  #注意边界
  for j <- 1 to length[A]
  do
    for i <- length[A] downto j+1
    do
      if A[i]<A[i-1]
      then
        A[i-1] <-> A[i]
{% endhighlight %}

#####选择排序#####
#####希尔排序#####

####O(nlog(n))排序方法####

#####归并排序#####
{% highlight c %}
#include <stdio.h>

#define MAX (5)

int data[MAX];
int tmp[MAX];

void merge(int b,int e)
{
  printf("[%d,%d)\n",b,e);
  int m = (b+e)/2;
  int p = b;
  int q = m;
  int i = 0;
  while((p<m)&&(q<e)&&(i<e-b+1)){
    if(data[p]<=data[q]) {
      tmp[i]=data[p];
      p++;
    }else{
      tmp[i]=data[q];
      q++;
    }
    i++;
  }
  while(p<m)tmp[i++]=data[p++];
  while(q<e)tmp[i++]=data[q++];
  for(i=b;i<e;i++)
    data[i]=tmp[i-b];
}

void merge_sort(int b,int e)
{
  if(e-b>1){
    int m = (e+b)/2;
    merge_sort(b,m);
    merge_sort(m,e);
    merge(b,e);
  }
}

void msort(int length)
{
  merge_sort(0,length);
}

int main()
{
  int i;
  for(i=0;i<MAX;i++)
    data[i]=MAX-i;
  msort(MAX);
  for(i=0;i<MAX;i++)
    printf("%d,",data[i]);
  printf("\n");
  return 0;
}
{% endhighlight %}

#####堆排序#####
{% highlight c %}

#include <stdio.h>

#define MAX (2000)

int data[MAX];
int length;
int heapsize;

inline int left(int i)
{
  return 2*i;
}

inline int right(int i)
{
  return 2*i+1;
}

inline int parent(int i)
{
  return i/2;
}

void swap(int &a , int &b)
{
  int tmp = a;
  a = b;
  b = tmp;
}

void max_heapity(int i)
{
  int l=left(i);
  int r=right(i);
  int largest = i;
  if((l<heapsize)&&(data[largest]<data[l]))largest=l;
  if((r<heapsize)&&(data[largest]<data[r]))largest=r;
  if(i!=largest){
    swap(data[i],data[largest]);
    max_heapity(largest);
  }
}

void build_heap(int len)
{
  int i;
  length = len;
  heapsize=length;
  for(i=length/2;i>=1;i--)
    max_heapity(i);
}

void heap_sort(int len)
{
  int i;
  build_heap(len);
  for(i=len-1;i>=1;i--){
    swap(data[0],data[i]);
    heapsize--;
    max_heapity(0);
  }
}

int extract()
{
  if(heapsize<=0){
    printf("Heap Empty.\n");
    return -1;
  }
  int value = data[0];
  data[0] = data[heapsize-1];
  heapsize--;
  max_heapity(0);
  return value;
}

void increase(int i,int key)
{
  data[i] = key;
  int p = parent(i);
  while(data[p]<data[i]){
    swap(data[p],data[i]);
    i=p;
    p = parent(i);
  }
}

void insert(int key)
{
  if(heapsize>=MAX){
    printf("Heap Full.\n");
    return;
  }
  increase(heapsize,key);
  heapsize++;
}

int main()
{
  int i;
  int value;
  for(i=0;i<MAX;i++)
    data[i]=MAX-i;
  heap_sort(MAX);
  for(i=0;i<MAX;i++)
    if(i+1!=data[i])
      printf("%d,",data[i]);
  printf("Finish Sort\n");
  heapsize = 0;
  printf("%d\n",extract());
  for(i=0;i<10;i++)
    insert(i);
  for(i=0;i<11;i++)
    if(9-i!=(value=extract()))
      printf("Er:%d,",value);
  printf("Finish IO\n");

  return 0;
}
{% endhighlight %}

#####快速排序#####
{% highlight c %}

#include <stdio.h>

#define MAX (2000000)

int data[MAX];
void swap(int &a , int &b)
{
  int tmp = a;
  a = b;
  b = tmp;
}

void qsort(int l,int r)
{
  int mid = (l+r)/2;
  int m=l;
  int n=r;
  while(m<=n){
    while(data[m]<data[mid])m++;
    while(data[n]>data[mid])n--;
    if(m<=n){
      swap(data[m],data[n]);
      m++;
      n--;
    }
  }
  if(m<r) qsort(m,r);
  if(l<n) qsort(l,n);
}

int main()
{
  int i;
  for(i=0;i<MAX;i++)
    data[i]=MAX-i;
  qsort(0,MAX-1);
  for(i=0;i<MAX;i++)
    if(i+1!=data[i])
      printf("%d,",data[i]);
  printf("Finish Sort\n");
  return 0;
}

int partition(int l, int r)
{
  int i,j;
  int key = data[r-1];
  i = l-1;
  for(j=l;j<r-1;j++){
    if(data[j]<key){
      i++;
      swap(data[i],data[j]);
    }
  }
  swap(data[i+1],data[r-1]);
  return i+1;
}

void qpsort(int l, int r)
{
  int i;
  if(l<r){
    i = partition(l,r);
    qpsort(l,i);
    qpsort(i+1,r);
  }
}

void random_qsort(int l,int r)
{
  int i;
  if(l<r){
    i = rand()%(r-l)+l;
    swap(data[i],data[r-1]);
    i = partition(l,r);
    qpsort(l,i);
    qpsort(i+1,r);
  }
}

{% endhighlight %}


#####线性查找#####
{% highlight c %}
int select(int index, int l, int r)
{
  int i;
  if(l==r-1)
    return data[l];
  i = random_partition(l,r);
  if(index<i)
    return select(index,l,i);
  else if(index==i)
    return data[i];
  else return select(index,i+1,r);
}

int select(int index)
{
  return select(index, 0, MAX);
}
{% endhighlight %}
