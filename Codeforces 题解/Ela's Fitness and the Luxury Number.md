# Ela's Fitness and the Luxury Number

所有者: Zvezdy
标签: 二分查找, 数学
创建时间: 2024年1月10日 16:19

**题目大意：给定两个数作为一个闭区间，要求这个闭区间上有多少个数满足→开根后取整数部分能被自己整除。**

        让我们从根号x而非x来看待问题。为什么？因为首先的，根号x的平方肯定是一个满足要求的数字，但题目也提到，开根后只要取整数部分，而这个还不够，我们需要研究更多。所以让我们聚焦于通用的例子：在 $(a^2,b^2)$ 之间有多少个数符合要求？然后我们将更进一步，研究 $(a^2,(a+1)^2)$ 中有多少个符合要求的数字。很显然， $a^2 ,(a*2)+1$ 之间有 $a,a+1,a+2$ 符合要求。于是我们断定，在两个平方的数中间，有三个数符合题意。

        最后，我们只需要求出我们目标的两个数在哪两个更小的数的平方之间，然后再拿 $a*(a+1),a*(a+2)$ 来作更细致的判断后乘以3，就可以得出在1~$a^2$之间有几个满足要求的数，再用前缀和的思路作处理即可。

```cpp
long long sqrtll(long long num){
    long long left=0,right=2000000000;
    while(right>left){
        long long mid=left+((right-left)>>1);
//注意 l+(r-l)/2 这个写法可以有效防止溢出，位运算中向右移一位就是除二。
        if(mid*mid>num) right=mid;
        else left = mid + 1;
    }
    return left-1;
}
```

这是一个用二分法开根的递归函数。有预先设置好的左顶点和右顶点，每次更新⇒先选出分割点，再判断数据落在哪里，如果在左半边则更新分割点为右顶点，如果落在右半边则更新左顶点为分割点+1，这样，假如左顶点与分割点为同一个的时候，下一步便会将右顶点设置在左顶点左边，于是我们结束循环，返回左顶点-1。在这个递归的设计中我们需要注意：①递归结束的条件 ②递归结束后我们能够得到什么。

另外，二分查找的一个基本思路是，在一个区间中先找出中点，假如中点符合我们要查找元素的条件，那么返回中点，不然就从 中点+1 到 终点 或者 将 中点-1 设为终点。

        至于二分查找，可以看作是，在一个区间里面找到符合要求的那个数，既然是**符合要求，**那么在便可以用于求解不能顺推的题目，因此，可将二分查找用于需要逆推题目中。例如蓝桥预赛的客人吃饭问题，不能直接顺着求解最多可以开多少天，但是可以拿一个数来判断这个天数能不能开够，于是便用二分查找来找到最符合要求的天数。

```cpp
#include<bits/stdc++.h>
using namespace std;
long long sqrtll(long long num){
    long long left=0,right=2000000000;
    while(right>left){
        long long mid=(left+right)/2; 
        if(mid*mid>num) right=mid;
        else left = mid + 1;
    }
    return left-1;
}
int main(){
    int t;scanf("%d",&t);
    while(t--){
        long long a,b,c=3,ans;
        scanf("%lld%lld",&a,&b);
        long long a_=sqrtll(a);
        long long b_=sqrtll(b);
        ans=c*(b_-a_);
        if(a_*a_<a)         ans--;
        if(a_*(a_+1)<a)     ans--;
        if(a_*(a_+2)<a)     ans--;
        if(b_*b_<=b)        ans++;
        if(b_*(b_+1)<=b)    ans++;
        if(b_*(b_+2)<=b)    ans++;
        printf("%lld\n",ans);
    }
    return 0;
}
```
