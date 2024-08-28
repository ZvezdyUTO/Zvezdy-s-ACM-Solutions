# Colored Balls

所有者: Zvezdy
标签: 动态规划, 组合数学
创建时间: 2024年5月8日 15:58

某个数学结论，假如我们有k种不同的颜色的球，每个颜色分别有a1,a2,a3…ak个球，两个不同颜色的球可以相消，那么我们将这里所有的球消完至少需要$max((sum of ai)/2向上取整 , max ai)$次。

在这题的动态规划中有两个比较重要的知识点：一个是排列组合，一个是01背包求方案数：

已知当我们确定最大的a[i]的时候，由排列组合的加法原理，我们需要从这个状态来将以前所有的结果所贡献的值全部累加入答案。假如我们当前除了a[i]还有 j 个物品，那么我们的总物品数就是a[i]+j，套入我们之前的公式，因为要向上取整所以+1。因为可能有不止一种的方式组合出 j 个物品，所以我们需要乘上f[j]，这个数组代表前 i 种物品中组合出 j 个物品有多少种方案，为0就是不可能组合出 j 个物品。在此基础上，对于每个a[i]都遍历由0到上次物品个数的总和并累加入答案中。

然后再把本次的a[i]累加入物品个数总量中，以此更新方案数。而这个就是01背包求方案数，以 j 为下标从当前的sum开始倒序遍历到a[i]，拿当前凑出 j 个物品的方案数加上凑出(j-a[i])个物品的方案数，这就是考虑当前物品后凑出 j 个物品所具有的方案数。

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
int a[200001],f[200001]{1};
const int MODE=998244353;
void solve(){
    cint(n); FOR(i,1,n) r(a[i]);
    sort(a+1,a+n+1);
    int sum=0,ans=0;
    FOR(i,1,n){//考虑前i个物品
        debug(sum);//前sum个球
        FOR(j,0,sum){
            ans+=f[j]*max((j+a[i]+1)/2,a[i])%MODE;
            //对于当前a[i]，考虑前面运算出的每个情况
        }
        sum+=a[i];
        ROF(j,sum,a[i]) f[j]=(f[j]+f[j-a[i]])%MODE;
        //a[i]之前的已经确定了
        //因为背包是从上层更新，所以滚动数组是从后往前滚动
    }
    s(ans%MODE);
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
```