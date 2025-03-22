# Irrigation

所有者: Zvezdy
标签: 二分查找, 思维
创建时间: 2024年7月10日 00:23

我们假设主办方从一开始就举办活动，那么所有城市都会按照1 2 3 4 5 6… m 1 2 3 4 5 6..的顺序举办。但是题目告诉我们有一些城市不按规则提前举办了，那我们可以计算出它们原本应该是在哪一年被举办的，并进一步计算出它们一共”提前“了多久被举办。然后进行排序，排序后的数组下标就代表被跳过的年份数量。

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
const int MODE = 1e9+7;
const int INF = 1e18;
int a[500001];
int hist[500001];
void solve() {
    int n,m,q; cin>>n>>m>>q;
    for(int i=1;i<=n;++i){
        int x; cin>>x;
        a[i]=m*(hist[x]++)+x;
    }
    sort(a+1,a+n+1);
    for(int i=1;i<=n;++i){
        a[i]-=i;
    }
    while(q--){
        int k; cin>>k;
        k-=n;
        k+=lower_bound(a+1,a+n+1,k)-a-1;
        cout<<(k-1)%m+1<<endl;
    }
}
signed main() {
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