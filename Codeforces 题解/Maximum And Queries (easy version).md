# Maximum And Queries (easy version)

所有者: Zvezdy
标签: 位运算
创建时间: 2024年5月10日 19:05

位运算操作的好题。首先明确，在二进制这个特殊的进制中，一个高位能够顶掉所有的低位。因此首要目标就是补全高位。

判断一个数某个位上是否为1的方法：将其往右移动某位再按位与上1。之前把补足某位看的太乱了，实际上最好的办法就是目标数-原有的数。沟槽的题目。。。

这题其实很简单，只是看错题目+想错方向了：

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
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
const int MAXN = 1e5 + 5;
int a[MAXN], b[MAXN], c[MAXN];
void solve(){
    cint(n); cint(q);
    FOR(i,1,n) r(a[i]);
    while (q--){
        cint(x); int ans=0;
        FOR(i,1,n) b[i]=a[i];//创造一个替身数组
        ROF(i,60,0){
            int p=1ll<<i,cnt=0;//构造一个数
            FOR(j,1,n) c[j] = b[j];
            FOR(j,1,n){
            if(!((b[j]>>i)&1)){//直接退i位看某一位是不是1
                int p = ((b[j] >> i) + 1) << i;
                cnt += p - b[j];//快速算出补到这一位至少要多少
                b[j] = p;//直接让后面清零
            }
            if (cnt > x) break;
        }
        if (cnt <= x) x-=cnt;
        else FOR(j,1,n) b[j]=c[j];
    }
    ans = b[1];
    FOR(i,1,n) ans &= b[i];
    cout << ans << '\n';
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT=1; 
    // cin>>TTT;
    while(TTT--){solve();}
    return 0;
}
//可以遍历看，每一位一共缺多少
//假如计算出，所有数字补全某一位要多少个呢？
//老规矩，能补高位就补高位
//每一位行不行？
//疯狂往前面遍历，直到结束为止
```
