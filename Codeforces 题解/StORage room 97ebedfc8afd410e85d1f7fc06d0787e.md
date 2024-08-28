# StORage room

所有者: Zvezdy
标签: 位运算, 构造
创建时间: 2024年4月25日 21:54

两个数进行按位与运算的结果，每一位上的1一定是原来两个数共有的。

两个数进行按位或运算的结果，每一位上的0一定是原来两个数共有的。

对于这一题，把二维组拆解后发现，它的结果是：

1| 2 3 4 5

2| 1 3 4 5

3| 1 2 4 5

…

我们已知了两个数按位或的结果，现在只需要挖空就好。

每次挖空，都要保证留最多的1，那就一排一排按位与这样挖过去。

挖完以后再验证是否有效就好。

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
#define cd(x) double x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
ll a[1001][1001];
int b[1001];
void solve(){
    cint(n);
    FOR(i,1,n) b[i]=(1<<30)-1;
    FOR(i,1,n) FOR(j,1,n){
        r(a[i][j]);
        if(i==j) continue;
        b[i]&=a[i][j];
        b[j]&=a[i][j];
    }
    FOR(i,1,n) FOR(j,1,n){
        if(i==j) continue;
        if((b[i]|b[j])!=a[i][j]){
            s("NO");
            endll;
            return;
        }
    }
    s("YES");endll;
    FOR(i,1,n){s(b[i]);__;}
    endll;
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
```