# Novice's Mistake

所有者: Zvezdy
标签: 字符串, 暴力枚举
创建时间: 2024年7月12日 10:29

看题目给出的条件，a最多只有10000，且n也最多只有100，在一个三元方程中已知其中两个元素可以求出剩下的元素，所以考虑枚举a来判断b是否存在。由题知，a*n-b≤a，所以最终构造出的(a-b)个n的位数不超过6位，直接计算b不好算，所以枚举目前保留了 i 位数字，然后判断此时计算出来的b合不合理就好，时间复杂度约为O(60000n)。注意n≥10的时候倍增的情况。

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
const int INF = 1e18;
const int N=1e6;

void solve(){
    int n; cin>>n;
    vector<PII>ans;
    for(int a=1;a<=10000;++a){
        for(int i=1;i<=min(6ll,a+(n>=10)*a);++i){
            string s=to_string(n);
            while(s.size()<i) s+=s;
            while(s.size()>i) s.pop_back();
            int goal=stoll(s);
            int b=a+(n>=10)*a-i;
            if(a*n-b==goal && b){
                ans.push_back({a,b});
            }
        }
    }
    cout<<ans.size()<<endl;
    for(auto i:ans){
        cout<<i.fi<<" "<<i.se<<endl;
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    // freopen("test.out","w",stdout);
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```
