# Messenger in MAC Messenger in MAC

所有者: Zvezdy
标签: 数据结构, 暴力枚举, 贪心
创建时间: 2024年3月6日 18:47

超级无敌暴力题，不过需要一点优化。对于相加的b那部分，我们可以看作是两个两个bi之间的距离相加，那我们想要相加后的结果最小，一定是我们所选取的区间中的bmax-b_min。

看一下题目给出的n^2≤2e6，加上我们之前推导出的b，考虑枚举左右区间来完成这道题。当我们确定我们所选的左右区间以后，要尽可能让区间里的元素变多，同时还要考虑不超过界限，可以考虑贪心。

b的部分只受左边界和右边界影响，意味着中间的地方的b我们不需要管。那就尽可能让中间的a是小值就好，可以使用优先队列维护，每次都把右区间弹入，如果超出界限，就把优先队列中的最大元素弹出。最后拿size()和ans比较。

为了简化代码，可以考虑将区间中的所有元素从左到右一个个push入区间，然后再while循环判断弹出，这样可能会把区间的左边界弹出，不过其实按最后结果来看并不影响我们求出正确答案。

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
const int MAXN=20001;
const int mode=1e9+7;
struct inf{int a,b;}a[MAXN];
void solve(){
    cint(n); cint(k);
    FOR(i,1,n) r(a[i].a>>a[i].b);
    sort(a+1,a+n+1,[](inf x,inf y){
        return x.b<y.b;
    });
    int ans=0;
    FOR(l,1,n){
        pque<int>now;
        int num=0;
        FOR(r,l,n){
            now.push(a[r].a);
            num+=a[r].a;
            while(now.size() && num+a[r].b-a[l].b>k){
                num-=now.top();
                now.pop();
            }
            ans=max(ans,(int)(now.size()));
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
