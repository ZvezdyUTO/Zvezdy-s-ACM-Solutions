# Valuable Cards

所有者: Zvezdy
标签: 动态规划, 数学, 贪心
创建时间: 2024年7月12日 12:30

贪心的策略很好想，从左到右遍历分割，每一组元素越多越好。接下来就是判断目前这一组是否合法的问题了。这种组内元素组合达成某种条件的都可以使用动态规划来求解。且考虑到1e5以内数字因子个数最多为128个，可以采用映射+暴力枚举的方式完成状态转移。在映射部分打两个数组，一个是键映射值一个是值映射键，因为寻找的时候要双向，筛因子的时候就不需要根号优化了，键值对应上会更麻烦。

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
#define debug(x) cout << #x << " = " << x << endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int MODE = 998244353;
const int INF = 1e18;
const int N = 1e6;
void solve() {
    int n,x; cin>>n>>x;
    int a[n+1];
    for(int i=1;i<=n;++i){
        cin>>a[i];
    }
    vector<int>fec;
    vector<int>has(x+1,-1);
    for(int i=1;i<=x;++i){
        if(x%i==0){
            has[i]=fec.size();
            fec.push_back(i);
        }
    }
    int m=fec.size();
    int ans=1;
    vector<bool>dp(m,false);
    dp[0]=true;
    for(int i=1;i<=n;++i){
        if(x%a[i]) continue;
        if(dp[has[x/a[i]]]){
            ++ans;
            dp.assign(m,false);
            dp[0]=true;
            dp[has[a[i]]]=true;
            continue;
        }
        for(int j=m-1;j>=0;--j){
            if(fec[j]%a[i]==0 && dp[has[fec[j]/a[i]]]){
                dp[j]=true;
            }
        }
    }
    cout<<ans<<endl;
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    cout.tie(0);
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```
