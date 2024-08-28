# Binary Median

所有者: Zvezdy
标签: 二分查找, 离散化
创建时间: 2024年6月21日 11:00

第一道手搓的2100，二分+bitmask练手题，不难想到解决方案，但是细节要求很多。

包括但不限于：用位移运算来置换10进制和2进制数的时候，一定要写1ll，打离散化表的时候分清楚哪个为原数据，哪个为离散数据，以及边界问题的判断。

这题思路很简单，把所有二进制数转为十进制数打个离散表，然后二分搜索中位数。这里分为两层，一层是真实数据（最后要转为二进制输出的），一个是离散数据（删除了n个数以后的数组的中位数下标）。可以写一个函数来判断目前我们枚举的这个真实数据对应删减数组里的哪个下标，具体实现就是通过lower_bound搜索被删数数组，看下标来更新边界。

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
#define dot pair<int,int>
int MODE = 998244353;
const int INF = 1e18;

void solve(){
    int n,m; cin>>n>>m;
    int sum=(1ll<<m);
    set<int>del;
    for(int i=1;i<=n;++i){
        string now; cin>>now;
        int number=0;
        for(int j=now.size()-1,cnt=0;j>=0;--j,++cnt){
            if(now[j]=='1'){
                number+=(1ll<<cnt);
            }
        }
        del.insert(number);
    }
    int a[n]{0};
    int it=0; for(auto i:del) a[it++]=i;

    int l=0,r=sum-1;
    int goal=(sum-n +1)/2,ans; //中位数的位置
    function<int(int)>check=[&](int k)->int{ //找到次数在有效数组中的位置
        auto it=lower_bound(a,a+n,k);
        int index=it-a;
        if(*it!=k){ //可以返回精准位置
            return k-index+1;
        }
        else{ //不在有效数组中
            int first=k-index;
            int last=sum-n-first;
            if(first<last) return -INF;
            else return INF;
        }
    };
    while(l<=r){
        int mid=l+(r-l)/2;
        int wh=check(mid);
        if(wh==goal){
            ans=mid;
            break;
        }
        
        if(wh>goal) r=mid-1;
        if(wh<goal) l=mid+1;
    }
    if(check(l)==goal) ans=l;
    if(check(r)==goal) ans=r;
    for(int i=m-1;i>=0;--i){
        cout<<(((1ll<<i)&ans)?1:0);
    }
    cout<<endl;
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