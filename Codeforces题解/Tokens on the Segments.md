# Tokens on the Segments

所有者: Zvezdy
标签: 思维, 贪心
创建时间: 2024年5月14日 10:47

可以考虑通过贪心使我们的标记尽可能多，正常来看，几乎每个线段的左端点都可以标记，除非有两根线段左端点相同。那么我们就可以选择标记其中一条线段的左端点，然后另一根线段去标记其从左往右第二个端点。我们可以把这样的操作看作是将某条线段的左端砍掉一截后继续标记其新的左端点。为了保证能有更多端点被标记到，肯定是线段越长砍的越多。那么便可以确定排序规则：如果左端点不同，让它们从小到大排序，左端点相同的时候让右端点升序排序，因为越后面的被截的越多。考虑到线段会被更新，可以使用优先队列来维护我们的数据：

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
struct Seg {int l, r;};
void solve(){
    pque<Seg,vector<Seg>,cmp(Seg)> pq(
        [](Seg x,Seg y){
            if(x.l!=y.l) return x.l>y.l;
            return x.r>y.r;});
    cint(n);
    FOR(i,1,n){
        Seg seg;
        r(seg.l); r(seg.r);
        pq.push(seg);
    }
    int h=0,ans=0;
    while(pq.size()) {
        Seg now=pq.top();
        pq.pop();
        if (now.l>h) {
            h=now.l;
            ++ans;
        }else if(now.l<now.r){
            ++now.l;
            pq.push(now);
        }
    }
    s(ans);endll;
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