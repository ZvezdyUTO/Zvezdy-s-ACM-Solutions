# Generator

所有者: Zvezdy

一道概率论题目，其实数学期望是可以合成的，具体拿E(3)举例：E(3)=1 * 1/3 + 1/3*(E(2)+1) + 1/3* E(3)。已知E(2)=2，对于此类嵌套的函数，其实我们可以通过因式分解化简为：2/3*E(3)=5/3，计算出E(3)=2.5.

然后根据这个性质，我们来推导这道题，如果N=1的时候，生成1的概率为1，如果N>1的时候，使用嵌套公式计算生成1的概率为E(N)=1+N/1*(∑(N-1,K=1)E(K))，调和级数H(N)的定义为： H(N)=∑(N,K=1)1/K，可以发现我们的嵌套公式在累加的时候可以类似于调和级数。而调和级数是一个发散级数，H(N)的值随着N的增大逼近于ln(N)+γ (欧拉常数)

欧拉常数的求解方式为：∑(N,i=1) 1/i   -  log(N)，所以我们在数值较大之后直接用1+log(n)+γ来近似地作为答案，其中欧拉常数的打表值为0.57721566490153287

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

double a[1000000];
const double t = 0.57721566490153287;

void solve(){
    int n; cin >> n;
    double ans=1.0;
    if (n<=1000000) {
        for (int i=2; i<=n;i++) {
            ans+=1.0/(i-1);
        }
    }
    else {
        ans=1+log(n)+t;
    }
    cout<<fixed<<setprecision(10)<<ans<<'\n';
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```
