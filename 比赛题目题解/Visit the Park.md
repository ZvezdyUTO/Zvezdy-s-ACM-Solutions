# Visit the Park

所有者: Zvezdy

如果不像题目那样一位一位叠起来的话，算出来的结果应该是所有数字的数学期望之和。再观察一下这个式子可以发现其实际上只改变了累加部分的结果，又因为路线固定，所以可以看做是累加部分每处理一步就x10。那么分步计算数学期望就行，使用map<pair<int,int>,vector<int>>存储两点之间边的信息比较方便。最后需要用拓展欧几里得求逆元，打个板子就行。

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
#define debug(x) cout<<#x<<"="<<x<<endl
#define ddbug(x) cout<<x<<" "
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(int word=begin;word<=endd;++word)
#define                                                                                                                ROF(word,begin,endd) for(int word=begin;word>=endd;--word)
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
const int MODE=998244853;
ll exgcd(ll l,ll r , ll &x,ll &y){//两个参数，两个解
    if(r==0){x=1;y=0;return l;}
    else{
        ll d=exgcd(r,l%r,y,x);
        y-=l/r*x;
        return d;
    }
}
ll NI(ll num,ll mode){
    ll x,y;
    if(exgcd(num,mode,x,y)==1)//ax+my=1
        return (x%mode+mode)%mode;
    return -1;//不存在
}
map<dot,vector<int>>dis;
vector<int>mp[300005];
void solve(){
    cint(n); cint(m); cint(k);
    FOR(i,1,m){
        cint(a);cint(b);cint(len);
        dis[make_pair(a,b)].push_back(len);
        dis[make_pair(b,a)].push_back((len));
    }
    cint(last); int ans=0;
    FOR(i,2,k){
        cint(now);
        ans*=10ll;
        auto it=dis[{last,now}];
        if(it.size()==0){
            s("Stupid Msacywy!");
            return;
        }
        int sum=0;
        for(auto j:it) sum+=j;
        // debug(sum);
        ans+=(sum*NI(it.size(),MODE))%MODE;
        ans%=MODE;
        last=now;
    }
    s(ans);
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    int TTT=1; 
    // cin>>TTT;
    while(TTT--){solve();}
    return 0;
}

```
