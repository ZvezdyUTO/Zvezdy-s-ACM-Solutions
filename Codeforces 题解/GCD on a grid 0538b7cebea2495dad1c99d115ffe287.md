# GCD on a grid

所有者: Zvezdy
标签: 数学
创建时间: 2024年6月12日 15:24

GCD除了直接表示：两个数的最大公约数以外，还有一些其他性质，比如对它们分别进行质因数分解后找两个共有质因数以及最小的指数再相乘。当然这是题外话，来看一个很经典的结论，1e？以内的因数最多的那个数字的因数个数。

![Untitled](GCD%20on%20a%20grid%200538b7cebea2495dad1c99d115ffe287/Untitled.png)

所以在这题中，1e6以内因数最多的也就240个，可以考虑暴力求解。

但也不能太暴力，，，这题数据很严格，总的来说需要注意一些点：枚举出所有可能因数的时候，最好是从1~i*i≤num，然后同时check两个因数，能够缩短很多时间。另外直接遍历整个数组来判是否合格也比带vis的dfs快不少。在递归部分并不用真算gcd，而是直接取模判整除就行。最后就是用bitset代替bool组会节省很多空间，挺有用的。

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
#define dot pair<int, int>
const int MODE = 1e9+7;
const int INF = 1e15;
int a[101][101];
bitset<101>f[101];
void solve(){
    int n,m; cin>>n>>m;
    for(int i=1;i<=n;++i)
        for(int j=1;j<=m;++j)
            cin>>a[i][j];
    int num=gcd(a[1][1],a[n][m]),ans=1;
    for(int i=1;i*i<=num;++i){ //平方根复杂度枚举因子
        function<bool(int)>check=[&](int k)->bool{
            f[1][0]=1;
            for(int i=1;i<=n;++i)
            for(int j=1;j<=m;++j){
                if(a[i][j]%k) f[i][j]=0; //不算gcd直接判整除
                else f[i][j]=f[i-1][j] || f[i][j-1]; //可以进行状态转移
            }
            return f[n][m]; //返回最终结果
        };
        if(num%i==0){
            if(check(i)) ans=max(ans,i);
            if(i*i!=num && check(num/i)) ans=max(ans,num/i);
            //如此枚举因子要同时枚举两个
        }
    }
    cout<<ans<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy=1;
    cin>>Zvezdy;
    while (Zvezdy--){
        solve();
    }
    return 0;
}

```