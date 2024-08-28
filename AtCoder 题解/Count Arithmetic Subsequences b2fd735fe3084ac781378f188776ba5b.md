# Count Arithmetic Subsequences

所有者: Zvezdy
标签: 动态规划, 组合数学

dp求组合数的题目，80这个小数据量适合乱搞暴力。由题目知，我们需要设置的第一重状态是序列长度，考虑从左往右遍历，所以第二重状态就是数组下标。接下来考虑第三种状态，等差数列中最重要的首项我们可以用当前这个“尾项”做代替，而另一个公差就比较麻烦，因为题目给出的范围是1~1e9，但是看数据量n≤80可知公差总数不会大，所以考虑map离散化处理。已知等差数列只要公差确定就可以进行拼接，所以我们用dp表记录以当前位置为末项，所组成的长度为sz、公差为dif的等差数列数量，至于怎么转移，就往前面跑统计同公差，长度为sz-1的数列来接就好了。时间复杂度O(n*n*n*log(n))，log(n)是map.

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include <bits/stdc++.h>
using namespace std;
#define int long long
#define debug(x) cout<<#x<<" = "<<x<<endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int,int>
const int MODE = 998244353;
const int INF = 1e18;
const int N=1e6;
int a[81];
vector<vector<map<int, int>>> dp(81, vector<map<int, int>>(81));
int ans[81];
void solve(){
    int n; cin>>n;
    for(int i=1;i<=n;++i){
        cin>>a[i];
    }
    ans[1]=n;
    for(int sz=2; sz<=n; ++sz){
        auto& res=ans[sz];
        for(int i=sz; i<=n; ++i){
            for(int j=i-1; j>=1; --j){
                int dif=a[i]-a[j];
                if(sz==2){
                    ++res;
                    res%=MODE;
                    ++dp[sz][i][dif];
                    continue;
                }
                dp[sz][i][dif]+=dp[sz-1][j][dif];
                dp[sz][i][dif]%=MODE;
                res+=dp[sz-1][j][dif];
                res%=MODE;
            }
        }
    }
    for(int i=1;i<=n;++i){
        cout<<ans[i]<<" ";
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    // freopen("test.out","w",stdout);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```