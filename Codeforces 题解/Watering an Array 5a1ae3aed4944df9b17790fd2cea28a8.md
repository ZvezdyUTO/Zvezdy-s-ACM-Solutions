# Watering an Array

所有者: Zvezdy
标签: 暴力枚举
创建时间: 2024年4月24日 14:58

考虑n的范围，直接暴力完了。

如果我们直接抹平然后每得一个新数就把1号位拿来换分，那么我们可以得d/2分。

那我们就可以直接暴力判断前2n次，因为把这2n次拿来换分和累加求换分的结果都一样。时间复杂度大约为:2n*(n+1),也就是O(n^2).

可以开一个数组，存储前2n次每次累加后的消除分数，之后再遍历贪心求最值就行，注意天数既不能超过2n也不能达到d，因为要留最后一天拿分。

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
#define int long long
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
ll a[2001],v[200001];
ll cnt[4001];
void solve(){
    cint(n);cint(k);cint(d);
    ll ans=0;
    cnt[0]=0;
    FOR(i,1,n){
        r(a[i]);
        cnt[0]+=(a[i]==i);
    }
    FOR(i,1,k) r(v[i]);
    FOR(i,1,2*n){
        cnt[i]=0;
        int it=i%k; if(it==0) it=k;
        FOR(j,1,v[it]) ++a[j];
        FOR(j,1,n) cnt[i]+=(a[j]==j);
    }
    for(ll i=0;i<=2*n && i<d;++i)
        ans=max(cnt[i]+(d-i-1)/2,ans);
    s(ans); endll;
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