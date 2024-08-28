# Torn Lucky Ticket

所有者: Zvezdy
标签: 配对, 预处理
创建时间: 2024年1月8日 02:57

第一次打CF被TLE的c题

一般来说，解决这种求对数，但是n^2必超时的情况，这些不同的数据会有一些共同点，可以拿他们的共同点代替来计算贡献，因为共同点可以预处理。

在稍微观察之后，我们可以发现，我们把一个彩票一点一点割掉，就可以得到它右边或者左边需要凑几个单位的数，需要和位多少的彩票，而这类一一映射问题，就需要map出场。

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
map<dot,int>l;
map<dot,int>r;
//fi是值，se是长度
string s[200001];
void solve(){
    cint(n);
    ll ans=0;
    FOR(i,1,n) r(s[i]);
    sort(s+1,s+n+1,[](string x,string y){
        return x.size()<y.size();
    });
    FOR(i,1,n){
        string now=s[i];
        string mod=now;
        int num=0;
        for(auto i:now)
            num+=(i-'0');
        int ts=num,add=0;
        ++l[{num,now.size()}];
        ++r[{num,now.size()}];
        ans+=l[{num,now.size()}];
        ans+=r[{num,now.size()}];
        --ans;

        if(now.size()>1)
        FOR(i,0,now.size()-2){
            int len=now.size()-i-1;
            ts-=(int)(now[i]-'0');
            add+=(int)(now[i]-'0');
            ans+=l[{ts-add,len-i-1}];
        }

        ts=num; add=0;
        int a=0;
        ROF(i,now.size()-1,1){
            int len=i;
            ts-=(int)(now[i]-'0');
            add+=(int)(now[i]-'0');
            ++a;
            ans+=r[{ts-add,len-a}];
        }

    }
    s(ans);
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
//    int TTT; cin>>TTT;
    int TTT=1;
    while(TTT--){solve();}
    return 0;
}
//1 1 1 1 1 
//
```