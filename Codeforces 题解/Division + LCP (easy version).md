# Division + LCP (easy version)

所有者: Zvezdy
标签: 二分答案, 字符串
创建时间: 2024年5月4日 00:10

K数组板子题。。再来个经典二分，没什么好说的

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
int z[MAXN];
string s;
void getz(){
    int l=0;
    memset(z,0,sizeof(z));
    for(int i=1;i<s.size();++i){
        if(l+z[l]>i) z[i]=min(z[i-l],l+z[l]-i);
        while(i+z[i]<s.size()&&s[z[i]]==s[i+z[i]]) z[i]++;
        if(i+z[i]>l+z[l]) l=i;
    }
//    for(int i=0;i<s.size();++i) cout<<z[i]<<" ";cout<<'\n';
}
int check(int num){
    int k=1;
    FOR(i,num,s.size()-1){
        if(z[i]>=num){
            ++k;
            i+=num-1;
        }
    }
//    debug(num);debug(k);endll;
    return k;
}
void solve(){
    cint(n); cint(m);r(m);
    r(s);
    getz();
    int l=0,r=s.size();
    while(l<r){
        int mid=(l+r+1)/2;
        int k=check(mid);
        if(k<m) r=mid-1;
        else l=mid;
    }
    s(l);endll;
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
