# Vlad and an Odd Ordering

所有者: Zvezdy
标签: 数学
创建时间: 2024年4月18日 15:08

再写数学我头就要闷了！！！！

又是经典找规律，但规律可不只是横向的，还有纵向的规律→

1 3 5 7 9 11 13

2 6 10

4 12

8

手动模拟还是要开更大的样例，不然不好观察。在自己推导的时候，最卡人的点就是，我们可以想到用2的倍数去模拟，但是如果模拟完一遍*2和*4后就不知道该如何处理所谓重复部分了。

其实这里面有一点数学知识，2*1,2*2,2*3,2*4，一开始看分解就有些发现了，我们每次都拿奇数来乘上偶数，但并没有偶数乘偶数的部分。每次奇数部分的重复都来自于 2*1  2*3  2*5…

这题的额外知识在于唯一·分解。如果我们需要保证某些书数相乘或者相加后能不重复，那么考虑不断乘某个质数，因为其他数都有可能在某些奇怪的时候被组合出来

如果我们不断在它们前面填上2，那就可以找到不重复的数字。于是便有了2的n次方的竖式差。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
//#pragma GCC optimize(2)
//#pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define ld long double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x; endll
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(auto word=begin;word<=endd;++word)
#define ROF(word,begin,endd) for(auto word=begin;word>=endd;--word)
#define cmp(what_type) function<bool(what_type,what_type)>
#define r(x) cin>>x
#define s(x) cout<<x
#define cint(x) int x;cin>>x
#define cchar(x) char x;cin>>x
#define cstring(x) string x;cin>>x
#define cll(x) ll x; cin>>x
#define cld(x) ld x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>

void solve(){
    cll(n); cll(k);
    ll j=n/2ll+(bool)(n%2ll);
    if(j>=k){
        s(2ll*k-1);
        endll;
        return;
    }
    k-=j;
    ll up=1;
    while(1){
        up*=2;
        ll num=n/up-(n/up%2==0);
        ll g=num/2+1;
        if(g>=k){
            s(up*(2ll*k-1));
            endll;
            return;
        }
        k-=g;
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT; cin>>TTT;
//    int TTT=1;
    while(TTT--){solve();}
    return 0;
}
//1 3 5 7 2 6 4
//1
//3
//5
//7
//9
//11

//先是偶数*2
//最后才是。。
//最大到last+1/2
//1 3 5 7 9 2 6 10 4 6 8
//奇数*2 偶数*2后就完事了
//<=5000000..
//1002
//50  2 4 6 8 10...
//1~25 -25
//掏掉了所有奇数*2的牌
//一个奇数*2后就变成偶数
//所以依旧是*2...
```
