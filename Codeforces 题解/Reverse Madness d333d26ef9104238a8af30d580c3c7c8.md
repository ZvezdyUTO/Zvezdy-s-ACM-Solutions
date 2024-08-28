# Reverse Madness

所有者: Zvezdy
标签: 前缀和&差分, 思维, 预处理
创建时间: 2024年4月28日 18:33

仔细看前面的条件，其实就是告诉我们题目给出的字符串已经被切割成了好几个不想交的区间，我们每次修改就是修改单个区间。

再来看他是如何修改的，举几个例子可以发现，他的修改就是以某区间中心向外扩散某段距离的子区间中所有元素进行反转。

考虑到它每次的处理都是在独立区间上进行，其实这题可以写个桶排并维护前缀和来消除相同的修改，用线性时间复杂度解决问题。

来看如何快速修改：假如我们有一个大小为4的数组2 2 2 2，那么可以发现，前半段和后半段之和相同，更进一步说，和为2的倍数，也就是可以被相互抵消。

假如拓展空间为6：1 2 2 2 2 0，重复刚才的操作，可以发现这个数组其实和1 0 0 0 0 0无异，因为中间那部分是会被抵消的，但因为最外面没有被抵消，所以数组里每处地方处理后的值都不能被2整除。放到原题里面就是，这一段从头到尾都要被反转。

或许我们可以更进一步讨论这种方法的原理，我们知道，区间反转是可以嵌套的，一个大区间被翻转一次，它的子区间如果再被翻转一次，那其实可以算外层被翻转一次，内层被翻转两次，也就是抵消了，这就是为什么可以用前缀和维护。那么已知偶数次翻转可以被抵消，这可以被概括为翻转次数的平衡与否。

某个区间中的左右端点向中间逼近，不断计算当前平衡值，以此决定当前两个元素是否需要翻转，这就是这题的处理方式。

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
#define cd(x) double x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
int l[200001],r[200001];
void solve(){
    cint(n); cint(k);
    cstring(s);
    vector<int>a(n+1);
    FOR(i,1,k) r(l[i]);
    FOR(i,1,k) r(r[i]);
    cint(q);
    while(q--){
        cint(now);
        ++a[now];
    }
    FOR(i,1,n) a[i]+=a[i-1];
    FOR(i,1,k) for(int ln=l[i]-1,rn=r[i]-1;ln<rn;++ln,--rn){
        int now=a[ln+1]-a[l[i]-1]+a[r[i]]-a[rn];
        if(now%2) swap(s[ln],s[rn]);
//        debug(s);
    }
    s(s);endll;
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