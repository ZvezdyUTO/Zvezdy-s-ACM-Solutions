# Smilo and Monsters

所有者: Zvezdy
标签: 数学, 贪心
创建时间: 2024年4月26日 10:52

其实也在一开始看错题了。。

可以对任意数组中的非零元素进行-1操作，并且操作数x累计后可以一次性对某个元素进行-x操作，要求都是不能小于0。

这种1个1个递增的方式让我们可以凑出任何数字，并且按照这么消除的思想，其实实质就是原值/2，我们想要得出的数尽可能小，那么就必须让一次参与进来的原值越大。那么就需要把数组排序后从大到小遍历。因为可以凑出任何数字，所以我们可以一开始就算出我们在这次操作中最多可用的x值，并从大到小进行消除，遇到消不完的，就先消部分并且跳出循环，接着就是从前往后遍历求凑x所需的操作以及抹零头的代价了。

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
#define cd(x) double x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
ll a[200001];
void solve(){
    cll(n); ll x=0,ans=0;
    FOR(i,1,n){r(a[i]); x+=a[i];}
    sort(a+1,a+n+1);
    x/=2;
    ROF(i,n,1){
        if(!x) break;
        if(x>=a[i]){
            x-=a[i];
            a[i]=0;
            ++ans;
        }
        else{
            a[i]-=x;
            ++ans;
            x=0;
            break;
        }
    }
    FOR(i,1,n) ans+=a[i];
    s(ans); endll;
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