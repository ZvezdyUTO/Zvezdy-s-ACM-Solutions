# Flipping Game

所有者: Zvezdy
标签: 动态规划, 组合数学
创建时间: 2024年5月14日 10:03

求组合数，考虑使用动态规划递推求解，那么关键在于确定状态，易知其中一个状态是前i轮。

在确定状态的过程中，我们可以尝试观察最终结果的属性：

1.以每个位置的开关确定状态，会发现这样有2^100种状态，故不考虑。

2.以和最终状态的差距来考虑，这个比较难想，可以发现这样子虽然过程状态比较杂，但是最终状态一定只有一种。

再来看看我们每一步操作如何使状态转移，我们每次操作是选择m个不同的开关，既然我们不能通过确定每个操作的具体位置来进行状态转移，那么就需要考虑另一种可能：枚举每次有多少个操作操作在了和目标不同的开关上。实践这个想法后就可以明白我们当前操作后就能够确定我们会将我们当前的状态转移去哪或者说从哪里转移来了。假设我们当前有 l 个操作操作在了与目标不同的开关上，那么就会导致只剩 j-l + m-l 个开关和目标不同，至于dp数组中存储的值自然是到达该状态的方案数，对于每次更新都使用组合数公式计算就行，组合数可以提前使用杨辉三角预处理出来。

综上所述，遇到“有几种方案到达目标状态”这类问题，dp数组里面一般存的都是到达某种状态的方案数，事实上用DP求解组合数问题也是如此。确定状态的时候不用太过纠结确定太具象的状态，只要能保证结果状态唯一并且能在每一步中通过其它状态推导出来就行，比如这题的状态就是前 i 轮中有j 个位置和最终结果不同。

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
const int MODE=998244353;
int c[105][105];
int f[105][105];
int C(int a,int b){return c[a+1][b+1];}
void solve(){
    cint(n); cint(k); cint(m);
    memset(f,0,sizeof(f));
    cstring(s); cstring(g); int op=0;
    FOR(i,0,s.size()-1) if(s[i]!=g[i]) ++op;
    f[0][op]=1;
    FOR(i,1,k) FOR(j,0,n) FOR(l,0,min(m,j)){
        int nex=j-l + m-l;
        f[i][nex] =
          (f[i][nex] +
            f[i-1][j]*C(j,l)%MODE*C(n-j,m-l)%MODE)%MODE;
    }
    s(f[k][0]);endll;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT=1; 
    cin>>TTT;
    c[1][1]=1;
    FOR(i,2,104) FOR(j,1,i) c[i][j]=(c[i-1][j]+c[i-1][j-1])%MODE;
    while(TTT--){solve();}
    // s(lucas(4,2));
    return 0;
}
//状态：和结果不同的位置数
//每一次枚举改变m个位置，分别看：有几个让我们离结果更近一步
//因为所有灯泡的状态就只有开和关，是唯一的。
//或许可以推导出，只要是问有几种方案完成目标
//从n个元素中取出m个元素的组合个数
```
