# sakiko的排列构造

所有者: Zvezdy
标签: DFS, 构造
创建时间: 2024年2月26日 16:05

如果一题拿不准，可以试着手写一些样例出来找到它们的规律

比如 6，那么就有 6 5 4 3 2 1 这种构造，因为加出来全是7

那么我们就可以想，是否存在一种构造，使一批数据被处理成同个素数，毕竟如果我们能在一个范围内放入倒过来的数，就可以弄出同个结果。

假如 n=7 那么1 2 3 4 5 6 7 。最大的数是7，而比7大的最小素数是11，那么我们就可以把7放在4号位，接着 7 6 5 4 填满，此时 1 2 3号位没数填。

而比3大的最小素数是5，那么我们就把3放在2号位，2放在3号位。

而1就放1号位吧。

于是我们就可以得出如此构造方式，先把大的构造了，再继续缩圈。直到结束。

```cpp
#include<bits/stdc++.h>
using namespace std;
int prime[10000006];
bool vis[10000006],flag=false;
int E_sieve(int n) { // 埃氏筛法，计算[2,n]以内的素数
    
    int k = 0;   // 统计素数个数 
    for (int i = 0; i <= n; i++) vis[i] = false; // 初始化 
    for (int i = 2; i <= n; i++) { // 从第1个素数2开始 
        if (!vis[i]) {
            prime[k++] = i;  // i是素数，存储到prime[]中 
       for (int j = 2 * i; j <= n; j += i) // i的倍数，都不是素数 
           vis[j] = true;                // 标记为非素数，筛掉 
    }
    }
    return k; // 返回素数个数 
}
void dfs(int n){
    if(n==0)    return;
    if(n==1)    {cout<<"1 "; return;}
    if(n==2)    {cout<<"2 1 "; return;}
    for(int i=1;i<=n;++i){
        if(!vis[n+i]){
            flag=true;
            dfs(i-1);
            for(int j=n;j>=i;--j)
                printf("%d ",j);
            return;
        }
    }
}
int n;
int main(){
    cin>>n;
    int k=E_sieve(2*n);
    dfs(n);
    if(!flag)    cout<<"-1";
    return 0;
}
```

运用dfs，我们可以分别求出断点，然后从最开始的断点开始输出，保证数组的顺序。
