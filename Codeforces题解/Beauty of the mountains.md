# Beauty of the mountains

所有者: Zvezdy
标签: 二维前缀和, 思维, 数学
创建时间: 2024年6月26日 13:37

赛时太慌张了，实际上这一题的本质就是，我们的两个数值有差，然后我们需要通过一些操作修改数值以便让差值为0。让我们选择一个单独的区域来看，我们能让这个区域里的数字增加 / 减少相同的数，那么最终这个区间就能修改 (1的个数-0的个数)*？的数值。把所有区间中1和0的差值求出来，我们的任务就变成了判断能不能用这些数做因数合成出我们目前山峰高度的差值。把这些数全部求GCD后再拿差值模GCD看为不为0就行。记得特判set为空以及差值为0不要插入set。

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
#define ll long long
#define debug(x) cout<<#x<<" = "<<x<<endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int,int>
int MODE = 1e9+7;
const int INF = 1e18;
int h[501][501];
int presum0[501][501],presum1[501][501];
void solve(){
    int n,m,k; cin>>n>>m>>k;
    for(int i=1;i<=n;++i)
        for(int j=1;j<=m;++j)
            cin>>h[i][j];
    int you=0,wu=0;
    for(int i=1;i<=n;++i){
        string now; cin>>now;
        for(int j=0;j<m;++j){
            if(now[j]=='1'){
                you+=h[i][j+1];
                presum1[i][j+1]=1;
                presum0[i][j+1]=0;
            }
            else{
                wu+=h[i][j+1];
                presum1[i][j+1]=0;
                presum0[i][j+1]=1;
            }
            presum0[i][j+1]+=presum0[i][j]+presum0[i-1][j+1]-presum0[i-1][j];
            presum1[i][j+1]+=presum1[i][j]+presum1[i-1][j+1]-presum1[i-1][j];
        }
    }
    int cha=you-wu;
    if(cha==0){
        cout<<"YES"<<endl;
        return;
    }
    set<int>nums;
    for(int i=k;i<=n;++i){
        for(int j=k;j<=m;++j){
            int v0=presum0[i][j]-presum0[i-k][j]-presum0[i][j-k]+presum0[i-k][j-k];
            int v1=presum1[i][j]-presum1[i-k][j]-presum1[i][j-k]+presum1[i-k][j-k];
            if(v1-v0) nums.insert(v1-v0);
        }
    }
    if(!nums.size()){
        cout<<"NO"<<endl;
        return;
    }
    int beg=*nums.begin();
    for(auto i:nums){
        beg=gcd(i,beg);
    }
    cout<<((cha%beg)?"NO":"YES")<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```