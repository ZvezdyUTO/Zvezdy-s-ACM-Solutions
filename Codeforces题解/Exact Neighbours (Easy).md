# Exact Neighbours (Easy)

所有者: Zvezdy
标签: 思维, 构造
创建时间: 2024年6月12日 11:06

小tips，正方形对角线上的点之间的距离都是2的倍数，按照以往的经验来看，涉及到曼哈顿距离的，对角线都挺关键，感觉有什么特殊性质在里面啊。

而且读假题了，，，说的是离某一巫师房子远多少米就好，而不是严格的上一个巫师。

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
int a[200001],ans[200001]{0,1};
void solve(){
    int n; cin>>n;
    for(int i=1;i<=n;++i)
        cin>>a[i];
    cout<<"Yes"<<endl;
    for(int i=1;i<=n;++i)
        cout<<i<<" "<<i<<endl;
    for(int i=1;i<=n;++i){
        if(i<=n/2) cout<<i+a[i]/2<<" ";
        else cout<<i-a[i]/2<<" ";
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    int TTT = 1;
    // cin>>TTT;
    while (TTT--){
        // cout<<TTT<<" ";
        solve();
    }
    return 0;
}

```