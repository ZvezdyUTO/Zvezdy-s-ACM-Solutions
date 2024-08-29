# Two Divisors

所有者: Zvezdy
标签: 数学
创建时间: 2024年3月3日 12:40

考虑两种情况嘛

①：假如 $b$ 能被 $a$ 整除

    那么 $x=b*(b÷a)$ 

②：假如 $b$ 不能被 $a$ 整除

    $x=b*p=b*(a÷GCD(a,b))$

```cpp
#include<bits/stdc++.h>
using namespace std;
int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL); cout.tie(NULL);
    int t; cin>>t;
    while(t--){
        long long a,b; cin>>a>>b;
        if(!(b%a))  cout<<b*(b/a)<<endl;
        else    cout<<b*(a/gcd(a,b))<<endl;
    }
    return 0;
}

```

如果 $b$ 能乘一个最小的数成为 $x$ 那么那个数就是我们需要找出来的数。

$a÷GCD(a,b)$ 既能满足最小，又能合成满足条件的 $x$
