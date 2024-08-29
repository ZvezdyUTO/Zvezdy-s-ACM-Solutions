# Chat Screenshots

所有者: Zvezdy
标签: 拓补排序, 数据结构
创建时间: 2024年5月7日 16:59

其实根据要求，除了第一位以外后面的所有人全部都是按顺序排好的，符合来去关系，考虑图论，可以使用邻接表存储，如果出现矛盾那肯定会生成环，最后使用拓补排序判环即可。

生成邻接表为了防止重复数据过多把空间爆掉，可以用vector嵌套set来存储邻接表~

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
void solve(){
    cint(n); cint(k);
    vector<set<int>>a(n+1);
    vector<set<int>>rd(n+1);
    while(k--){
        int last=0;
        FOR(i,1,n){
            cint(now);
            if(i>2){
                a[last].insert(now);
                rd[now].insert(last);
            }
            last=now;
        }
    }
    queue<int>topsort;
    FOR(i,1,n) if(rd[i].empty()) topsort.push(i);
    while(topsort.size()){
        int now=topsort.front();
        topsort.pop();
        for(auto i:a[now]){//遍历邻接表
            rd[i].erase(now);
            if(rd[i].empty())
                topsort.push(i);
        }
    }
    for(auto i:rd) if(i.size()){
        s("NO"<<endl);
        FOR(i,0,n) a[i].clear();
        FOR(i,0,n) rd[i].clear();
        return;
    }
    s("YES");endll;
    FOR(i,0,n) a[i].clear();
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
