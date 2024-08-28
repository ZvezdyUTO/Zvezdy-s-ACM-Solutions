# Alphabet Tiles

所有者: Zvezdy
标签: 动态规划, 组合数学

算是比较经典的方式拿背包求组合数，这次求组合数主要用到的是插空法，如果我们本来就有一个长度为n的序列，然后我们要往里面插入k个相同元素，那么最好的方法就是发现这里一共有n+k个空位，先Cnk求出插空的方法数，再在原来的基础上把以前的元素填进去，那么乘法原理就是Cnk*已有方案数。

这么看来我们需要三个状态：前i个字母，现在序列的长度，插入多少个当前字母。那么转移就是从目前长度-插入长度、上一个字母处转移，最外层循环代表字母，第二层循环代表长度，因为先枚举插入字符会导致出现重复。在main函数中预处理出杨辉三角组合数就行。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \____|  \__  |★*/
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
#define dot pair<int,int>
const int MODE = 998244353;
const int INF = 1e15;
int num[27],dp[27][1001];
int c[1001][1001];
void solve(){
    int n; cin>>n;
    for(char i=1;i<=26;++i)
        cin>>num[i];
    dp[0][0]=1;
    for(int i=1;i<=26;++i){//第几个字母
        for(int j=0;j<=n;++j){//长度如何
            for(int k=0;k<=min(num[i],j);++k){
                //选择了几个字母，同时保证枚举字母的长度不超过序列长度
                
                dp[i][j]+=dp[i-1][j-k]*c[j][k];
                //背包求组合数，从之前的状态转移过来
            
                dp[i][j]%=MODE;
            }
        }
    }
    int ans=0;
    for(int i=1;i<=n;++i){//每个可能的长度，以及考虑所有的字母
        ans+=dp[26][i];
        ans%=MODE;
    }
    cout<<ans;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy=1;
    // cin>>Zvezdy;

    //杨辉三角预处理组合数
    c[0][0]=1;
    for(int i=1;i<=1000;++i){
        c[i][0]=1;
        for(int j=1;j<=1000;++j){
            c[i][j]=c[i-1][j-1]+c[i-1][j];
            c[i][j]%=MODE;
        }
    }

    while (Zvezdy--){
        solve();
    }
    return 0;
}

```
