# Neutral Tonality

所有者: Zvezdy
标签: 构造, 贪心
创建时间: 2024年5月13日 18:23

既然说了是最长上升子序列，并且是插入新元素，那么无论如何插入都不能让最终答案低于初始答案，所以考虑贪心让每一次插入元素都使得贡献尽可能的小。贪心的让数组尽可能倒序，那么小的肯定在后面，大的肯定在前面，因为序列的性质为有序，可以选择在靠后的地方“反常”地插入元素，保证后效性最小。最后把b从小到大排序，后插入并倒序输出就好了

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
const int mode=1e9+7;
int aa[2*200001],a[200001],b[200001];
void solve(){
    cint(n); cint(m);
    FOR(i,1,n)r(aa[i];) FOR(i,1,m)r(b[i]);
    FOR(i,1,n) a[i]=aa[n-i+1];
    sort(b+1,b+m+1);
    int cnta=1,cntb=1;
    FOR(i,1,n+m){
        if(cnta<=n && cntb<=m && a[cnta]>=b[cntb]){
            aa[i]=b[cntb];
            ++cntb;
            continue;
        }
        if(cnta<=n && cntb<=m && a[cnta]<b[cntb]){
            aa[i]=a[cnta];
            ++cnta;
            continue;
        }
        if(cnta<=n){
            aa[i]=a[cnta];
            ++cnta;
        }
        if(cntb<=m){
            aa[i]=b[cntb];
            ++cntb;
        }
    }
    ROF(i,m+n,1) s(aa[i]<<" ");
    endll;
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
//当插入b的时候，尽量选择在后方插入
//元素维持倒序，也就是找到第一个比该元素大的a数组元素
//已知b数组元素插入与顺序无关，可以考虑贪心插入
//将b从小到大排序，将a数组倒序
```