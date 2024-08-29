# Divide and Divide

所有者: Zvezdy
标签: 记忆化搜索

最简单的方法，就是搁那函数递归调用

如果用这种dfs式的方法，那难免会做重复计算，我们可以用map存储

```cpp
#include<bits/stdc++.h>
using namespace std;
#define ll long long
#define ld double
ll n;
map<ll,ll>mem;
ll func(ll num){
    if(num<2) return 0;
    if(mem[num]) return num+mem[num];
    ll now=(func(num/2)+func(num/2+(bool)(num%2)));
    mem[num]=now;
    return num+now;
}
void solve(){
    cin>>n;
    cout<<func(n);
}
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(0);cout.tie(0);
    int T=1;    
//    cin>>T;
    while(T--) solve();
    return 0;
}

```
