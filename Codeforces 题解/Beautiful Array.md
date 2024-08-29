# Beautiful Array

所有者: Zvezdy
标签: 数学, 模拟
创建时间: 2024年6月24日 10:16

有两个很关键的点：

1. 一个数加上x个k能变为另一个数，意味着这两个数的差值为k的倍数，这两个数也就同余。
2. 一个奇数个元素的数组在排序后，要想决定删除哪个数使得这个数组的二元组差值之和最小，那么最优解肯定是删除奇数位置的数，也就是说，差值永远从相邻的两个数之间取。

那么这题的模拟情况就很清晰明了了，我们把同余的元素分组，然后单独对它们每一组来求答案值，把每组的答案值累加，最后判断能否实现题意即可。使用map<int,vector<int>>来打数组分组，最后遍历的时候使用 `for(auto&[键，值] : map)` 来遍历数组。

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
int MODE = 998244353;
const int INF = 1e18;
int a[100005];
void solve(){
    int n,k; cin>>n>>k;
    for(int i=1;i<=n;++i) cin>>a[i];
    sort(a+1,a+n+1);
    map<int,vector<int>>mp;
    for(int i=1;i<=n;++i){ //按照余数分类值
        mp[a[i]%k].push_back(a[i]);
    }
    int ans=0,tag=0;
    for(auto&[null,arr]:mp){ //同余的按一组来算
        if(arr.size() & 1){ //不能完全配对，需要删除一个
            ++tag;
            vector<int>tmp(arr.size()+1,0);
            for(int i=0;i<arr.size()-1;i+=2){
                tmp[i+2]=tmp[i]+(arr[i+1]-arr[i])/k;
            }
            tmp[arr.size()]=0;
            for(int i=arr.size()-1;i>0;i-=2){
                tmp[i-1]=tmp[i+1]+(arr[i]-arr[i-1])/k;
            }
            int res=INF;
            for(int i=0;i<tmp.size()/2;++i){
                res=min(res,tmp[i*2]+tmp[i*2+1]);
            }
            ans+=res;
        }
        else{
            int res=0;
            for(int i=1;i<arr.size();i+=2)
                res+=(arr[i]-arr[i-1])/k;
            ans+=res;
        }
    }
    if(tag>1) cout<<-1<<endl;
    else cout<<ans<<endl;
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
