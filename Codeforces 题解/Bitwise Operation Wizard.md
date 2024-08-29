# Bitwise Operation Wizard

所有者: Zvezdy
标签: 互动题, 位运算
创建时间: 2024年5月7日 10:19

看错题了。。其实这题在询问时的处理是按位或。已知对自己本身进行按位与和按位或运算，得出的结果和自己相等，所以我们可以通过这个性质找出最大的那个数。

最大的数可能不是每一位上都是1，也就是说存在空缺的地方，我们的第二步是找到能够填满这些空缺的数。将其他数拿出来和我们已经找到的最大数进行按位或运算，只要获得了更大的结果就先清空动态数组，然后将目前的答案填进去，如果是给出了“=”，则直接填入动态数组，在n次操作后我们又获得了几个可以完美补全最大数的数字。

但按位异或和按位或运算不同的地方在于，相同位置都为1不会影响按位或，但却会影响按位异或。我们需要的是这个数所存在的1刚好可以填满我们的最大数，因为是排列，所以这些数字里面一定有一个刚好能够满足这个·条件的数字，这个数字相比其他数字没有多余的1，所以我们只需要在我们第二阶段求出的答案中选出里面最小的那个数，搭配上我们第一阶段找出的最大数，就是答案。

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
const int MAXN=200001;
const int mode=1e9+7;
int a[MAXN];
void solve(){
    cint(n);
    int maxn=0;
    FOR(i,1,n-1){
        s("?");__;
        s(maxn);__;s(maxn);__;
        s(i);__;s(i);endll;
        cchar(now);
        if(now=='<') maxn=i;
    }
    vector<int>ans;
    int ano=maxn;
    FOR(i,0,n-1){
        s("?");__;
        s(maxn);__;s(i);__;
        s(maxn);__;s(ano);endll;
        cchar(now);
        if(now=='=') ans.push_back(i);
        if(now=='>'){
            ans.clear();
            ans.push_back(i);
            ano=i;
        }
    }
    int minn=*ans.begin();
    for(auto i:ans){
        s("?");__;
        s(i);__;s(i);__;
        s(minn);__;s(minn);endll;
        cchar(now);
        if(now=='<') minn=i;
    }
    s("!");__;s(maxn);__;s(minn);endll;
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
//4 5 5 2
//4 5 1 2 3 +1
//1 2 3 4 5 +3
```
