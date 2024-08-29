# Card Game

所有者: Zvezdy
标签: 思维, 贪心
创建时间: 2024年4月26日 20:31

伪操控数组问题，比如删除或者插入。对于这种单个删除的，先考虑它究竟会实质上影响到哪些元素的下标，一般而言删除都是影响后续元素的下标。这题的删除是单个删除，单删有个很重要的特性就是相邻的后一个元素会来到自己现在所处的位置上。

再来看到底是如何删除？这题说是奇数位删除后累加，偶数位直接删除，统一条件后会发现实际上我们可以删除任何一个位置的元素。但累加就只能累加奇数位置上的元素，那我们可以想一下，是不是可以通过操控数组，让任何有利于我们的元素都来到奇数位上让我们累加。

因为无后效性，所以我们从后往前推导，如果最后一个正数在奇数位上，我们可以直接将它累加并且删除，如果在偶数位上，我们可以暂时先不用管它，直到前面的偶数位上有一个负数或者奇数位上有个正数，我们就可以把它加入答案中。

因为一旦有任何的负数在偶数位上或者有任何正数在奇数位上，我们都可以放心收割后面所有正数，因为奇数位正数都被拿走了，所以后面肯定是只剩偶数位正数的。

所以现在来考虑一个最极端的情况，任何情况最后如果不能很好处理肯定会变成这个最极端的情况：整个数组上只有偶数位上有正数，其它都是负数，那想拿到所有的正数肯定得付出代价，

至于这种情况嘛。。要么删除位置2上的数字，要么在1或者3上吃一个负数。任选一种都可以吃到后面所有的正数。可以证明任何一种选择都能吃完后面所有的正数，假如1号位和3号位上负数都大过2号位正数，只要牺牲2号位就能获取后面所有正数；如果2号位很有实力，那么肯定是拿2号位抵押1号位的数字然后把后续所有数全吃了。

因此可知，下标大于等于3的所有正数都可以随便吃，1号位和2号位特判一下就好了，如果2号位小于1号位就删除2号位，大于1号位则拿它们的差累加到答案中

很明显这题原来卡住的就是代价的问题，要么抛弃一个正数要么吞并一个负数，其实也就两种可能，如果下次能清楚列出来可能就不会卡这么久了。

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
    if(n>=3) FOR(i,3,n) if(a[i]>0) ans+=a[i];
    if(n>=2){
        if(a[1]>0 && a[2]>0) ans+=(a[1]+a[2]);
        else if(a[1]>0 && a[2]<0) ans+=a[1];
        else if(a[1]+a[2]>0) ans+=(a[1]+a[2]);
    }
    if(n==1 && a[1]>0) ans=a[1];
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
