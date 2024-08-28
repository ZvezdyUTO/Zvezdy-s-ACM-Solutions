# String Bags

所有者: Zvezdy
标签: 动态规划, 字符串

一道动态规划题目，不过需要一些字符串匹配操作。

主要的麻烦是如何匹配字符串，我们可以使用成员函数substr()来截取原字符串的子串，然后拿去和当前的字符串判断是否匹配。

接下来，我们就需要设置动态规划方案的存储容器。因为我们需要记录是否匹配，并且我们的数据是分组的，那么我们就可以开一个二维数组，外层代表某一组，内层代表原字符串的终点，如果能匹配那么我们在终点长度处存储我们的费用，无法到达的地方都更新为0x7fffffff代表无法实现。

```cpp
#include <bits/stdc++.h>
using namespace std;
int dp[205][205];
void solve(){
    string t; cin>>t;
    int n; cin>>n;
    for(int i=0;i<=201;i++){
        for(int j=0;j<=201;j++)
        dp[i][j]=200001;
    }
    dp[0][0]=0;
    for(int i=1;i<=n;i++){
        int a; cin>>a;
        while(a--){
            string s; cin>>s;//当前字符串为s
            for(int j=0;j<=t.size();j++){//从头到尾遍历初始字符串任何一个可能位置
                dp[i][j]=min(dp[i][j],dp[i-1][j]);
                //因为如果有了插入那么当前位置就不为0x7fffffff
                //所以如果可以从上组字符串的状态转移的话那么就从上组转移
                if(t.substr(j,s.size())==s)
                //当前位置可以匹配，运用的技术是substr截取子串
                    dp[i][j+s.size()]=min(dp[i-1][j]+1,dp[i][j+s.size()]);
                //看是否更新，如果更新那么就是该处费用+1。
                //但如果那个地方已经有匹配值了，那么就选花费较低的方案
            }
        }
    }
    if(dp[n][t.size()]==200001) cout<<-1;//无法匹配
    else cout<<dp[n][t.size()];
}
signed main()
{
    std::ios::sync_with_stdio(false);
    cin.tie(0);cout.tie(0);
    int T = 1;
    // cin >> T;
    while (T--) solve();
    return 0;
}
```