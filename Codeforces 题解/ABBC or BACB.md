# ABBC or BACB

所有者: Zvezdy
标签: 思维
创建时间: 2024年4月29日 16:39

不用管那个修改什么的，实际上就是如果我们有个字符B，我们就可以用它吞掉左边或者右边的所有A，问我们最多能吞几个。

模拟一遍可以发现，如果字符串开头或者结尾为B，就可以吞掉所有的A，或者说如果中间有个”BB“，那也可以让它们兵分两路吞掉所有的A。

如果上述所有条件都不符合，只能牺牲掉一个最短的A串来获得最好的结果，比如：“AAABABAABAAA”显然是不能取最中间那个单个A了。

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
void solve(){
    cstring(s); int len=s.size()-1;
    bool all=false;
    if(s[0]=='B'||s[len]=='B') all=true;
    FOR(i,0,len-1)
        if(s[i]==s[i+1] && s[i]=='B'){
            all=true;
            break;
        }
    int ans=0,sho=maxint,now=0;
    FOR(i,0,len) if(s[i]=='A') ++ans;
    if(!all){FOR(i,0,len){
        if(s[i]=='A') ++now;
        if((s[i]=='B' || i==len) && now){
            sho=min(sho,now);
            now=0;
        }
    }ans-=sho;}
    s(ans);endll;
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
