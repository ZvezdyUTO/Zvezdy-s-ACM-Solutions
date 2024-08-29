# Permutation Printing

所有者: Zvezdy
标签: 数学, 构造
创建时间: 2024年2月26日 18:32

对于一个数来说，一般而言它的最小因子就是2，

那么对于一个数n来说，(n/2+1 , n)没有任何能整除n的数。

我们就可以如此构造：1,n,2,n-1 …… (n+1)/2

换句话来说，一个大一个小的数也没办法完成另外一组一个大一个小的数的整除。而就算是同样的左大右小或者左小右大，那么也能满足有个数除以另外个数的商小于2

```cpp
#include<bits/stdc++.h>
using namespace std;
int n;
int l=1,r;
int main(){
    cin>>n;
    for(int i=1;i<=n;++i){
        if(i%2==1) cout<<l++<<" ";
        else    cout<<n-r++<<" ";
    }
    return 0;
}
```
