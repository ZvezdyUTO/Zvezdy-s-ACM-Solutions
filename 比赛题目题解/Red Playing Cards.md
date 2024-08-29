# Red Playing Cards

所有者: Zvezdy

容易发现可设状态为 l,r 这个区间所能提供的最大价值，此时我们还需要考虑大区间包含小区间的情况，如果考虑小区间的话只要让大区间的区间长度减少一定值就可以。但一个大区间中不一定只有一个小区间，那些小区间要么相互包含要么相交，考虑相交情况如何抉择的时候可以参考洛谷牛吃草那道题，从左往右扫描过去，发现一个小区间终点的时候再考虑是否选择该小区间，然后从小区间左端点状态转移过来。

为了能够实现这样的状态转移，我们需要将目前的大区间按照数组下标切割开来，顺便还要保证大区间里面的小区间所能提供的最大价值已经被预先处理过。为了保证求解大区间的时候里面的小区间都被处理过，我们按照区间长度从小到大来处理区间最值，每一个数字所能提供的最大答案都存储在一个dp数组中。在求解某个数字提供答案的时候，我们用一个独立的数组存储其从 l 到 k 的最大价值，当发现此地是一个被包含在该区间的一个小区间的时候我们就拿数值来pk并进行状态转移，否则就加上该区间的默认值。最后有个小trick就是，在总数组的左端点和右端点补上0，那么dp[0]的值就是我们所需要的答案。

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
const int N = 300005;
const int INF = 1e18;

void solve() {
    int n; cin>>n;
    struct info{
        int l,r,id;
        bool operator< (const info& other)const{
            return r-l < other.r-other.l;
        };
    };
    unordered_map<int,info>mp;
    vector<info>inf(n+1,{0,0});
    inf[0]=mp[0]={0,2*n+1,0};
    vector<int>arr(2*n+2,0);
    for(int i=1;i<=2*n;++i){
        cin>>arr[i];
        if(!mp[arr[i]].l){
            mp[arr[i]].l=i;
        }
        else{
            mp[arr[i]].r=i;
            mp[arr[i]].id=arr[i];
            inf[arr[i]]=mp[arr[i]];
        }
    }
    sort(inf.begin(),inf.end());

    vector<int>dp(n+1,0);
    iota(dp.begin(),dp.end(),0);
    for(auto& cnt : inf){
        int id=cnt.id;
        int l=cnt.l;
        int r=cnt.r;
        int res=0;
        unordered_map<int,int>tmp;
        for(int i=l;i<=r;++i){
            auto& it=mp[arr[i]];
            if(it.r==i && it.l>l){
                res=max(res+id,tmp[it.l-1]+dp[arr[i]]);
            }
            else{
                res+=id;
            }
            tmp[i]=res;
        }
        dp[id]=res;
    }
    cout<<dp[0];
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
