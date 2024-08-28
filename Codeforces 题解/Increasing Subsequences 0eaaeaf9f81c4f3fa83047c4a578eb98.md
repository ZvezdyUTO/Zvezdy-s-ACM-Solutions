# Increasing Subsequences

所有者: Zvezdy
标签: 数学, 构造
创建时间: 2024年5月9日 10:25

在计算选择方案数之前先来复习一下排列组合的递推求解。假如我们构造一个1 2 3 4 5这样的序列，一共有多少种严格递增的子序列？先从1看起，只有1个1的时候肯定数量是1，再加上一个2呢？那么就有几种情况：选择或者不选择2，那么我们的总情况就是2*前面的方案数+1，因为乘法原理，以及单独选择2的时候也算一种独立的方案。这就是2^n-1的由来。

既然有2^n这种东西，就感觉可以往二进制上面靠了，考虑拆位。但是这一题有限制最多构造200个元素，那我们肯定不能每次都单独构造一个全新的排列。考虑到序列的性质，我们在构造完一个排列后，其实可以在尾巴重新“续上”原来我们已经构造好的序列。比如1 2 3 4 5，我们在后面再补上一个3，那么这个3就能和前面的 1 2 又构成一个新的子序列。所以最后的结果就是，我们先构造一个最长的链，然后不停地在后面补数构造2的次方就行。

对于后面补数的部分其实有个技巧，有关于二进制的拆分，一般都会学到是每次都除2，有余数就在那一位上补1。在我们将最大的链贡献删去后，我们利用这个拆分方案来算出我们需要补上哪些数字。由于是从低到高补所以最后需要倒序输出。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
#pragma GCC optimize(2)
#pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define int long long
#define ld double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x; endll
#define ddbug(x) cout<<x<<" "
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(int word=begin;word<=endd;++word)
#define ROF(word,begin,endd) for(int word=begin;word>=endd;--word)
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
    cint(n); --n;
    int cnt=1,highbit=0;
    while(1){//寻找最高位，还是这个保险
        if(cnt*2-1>=n) break;
        else cnt*=2;
        ++highbit;
    }
    // debug(highbit);
    n-=(cnt-1);
    vector<int>ans;
    cnt=1;
    while(n){
        if(n%2) ans.push_back(cnt);
        n/=2;
        ++cnt;
    }
    s(ans.size()+highbit<<endl);
    FOR(i,1,highbit) s(i<<" ");
    if(ans.size()+highbit){
        ROF(i,ans.size()-1,0) s(ans[i]<<" ");
        endll;
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT=1; 
    cin>>TTT;
    while(TTT--){solve();}
    return 0;
}

```