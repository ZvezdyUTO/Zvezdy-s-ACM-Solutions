# Milena and Admirer

所有者: Zvezdy
标签: 数学, 贪心
创建时间: 2024年4月25日 15:05

在适当观察分解要求后，发现其实这个分解就是单纯把数字拆成几部分。为了符合题目要求，我们需要保证拆出来的数中最大不超过后面那个数，拆出来最小那个数要最大，同时也是为了使拆的数尽可能少。

我们选择从后往前遍历，因为前面的数只会变小，也不知道变多小刚好合适，而后面的数是越大越好，越大前面的数就可能越不用拆，所以倒序遍历方便我们做贪心。

答案个数就是(a[i]-1)/a[i+1]，减一是为了防止刚好有整除的情况发生，毕竟如果整除的话，累加到答案里的数就只是拆出来的数-1

最后为了保证拆出来的数最大，就直接除我们一共把这个数拆成几部分就好了，可以直接把a[i]更新成拆出来的结果，让前面的数字能够直接利用它进行判断。

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
#define ddbug(x) cout<<x<<" "
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
ll a[200001];
void solve(){
    cint(n);
    FOR(i,1,n) r(a[i]);
    ll ans=0;
    ROF(i,n-1,1){
        if(a[i]>a[i+1]){//大于，需要更新
            ll k=((a[i]-1)/a[i+1]);
            ans+=k;
            a[i]/=(k+1);
        }
    }
    s(ans);endll;
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
