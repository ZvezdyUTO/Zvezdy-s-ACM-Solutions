# Bridging the Gap 2

所有者: Zvezdy

一个人来回需要消耗2体力，最后他自己过去需要消耗1体力，所以将其体力-1后/2就可以计算出他最多可以来回拉几次船，毕竟船到对岸是要有人拉回来的。考虑到一艘船如果要返航，一次最多能够把R-L个人拉到对岸。那么我们可以用(n-L-1)/(R-L)来计算出我们来回的最少次数，记该次数为s。因为一共只需要拉s次，那么我们就遍历每个处理过的体力值，计算出他们一共可以拉多少趟就好。

如果想要进一步理解，我们可以想象一个二维矩阵，横向是L，纵向是s，我们需要保证填满这个矩阵，但考虑到划船的人不会分身，我们只需要每次取那个人的值的时候保证不超过s就好，这样最后填满的时候就可以保证一定有合法方案。

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
const int INF = 1e18;
const int MODE = 998244353;

void solve(){
    int n,L,R; cin>>n>>L>>R;
    int s=max((n-L-1)/(R-L),0ll);
    vector<int>h(n);
    int sum=0;
    for(int i=0;i<n;++i){
        cin>>h[i];
        sum+=min(s,(h[i]-1)/2);
    }    
    if(sum>=s*L){
        cout<<"Yes";
    }
    else{
        cout<<"No";
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
