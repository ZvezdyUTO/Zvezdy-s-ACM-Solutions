# Promising String (hard version)

所有者: Zvezdy
标签: 树状数组
创建时间: 2024年6月21日 16:37

依旧是相邻值。在最近几次题目中可以总结出：对于相邻值采用赋值+1和-1最后累加起来求区间和有奇效。我们把减号处值设为-1，加号处值设为+1，求前缀和。两个减号变为加号，就是把两个-1变为1，实际上就是权值+3了，再来是只能把减号变为加号，所以区间值一定得小于或者等于0，最终效果是区间值小于等于0并且可以被3整除。

整除这里弄同余就行，问题是为了保证区间值≤0，前面的值必须大于后面的值，那就是要我们求逆序对了，很容易想到使用树状数组。构建3个树状数组来把同余元素分组储存求逆序对就好。分组树状数组这里还是挺妙的。

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
int n,m;
int fenwickTree[3][2*200005+1];
int lowbit(int num){return num&(-num);}
void add(int Group,int x,int y){ //把和自己有关的全部更新
    while(x<=m){ //在边界内
        fenwickTree[Group][x]+=y; //更新
        x+=lowbit(x); //每次都往上lowbit位
    }
}
int que(int Group,int x){ //查询
    int res=0;
    while(x){
        res+=fenwickTree[Group][x]; //把沿途的加起来
        x-=lowbit(x); //从最高位开始一直削减自己的lowbit
    }
    return res;
}
int info[200005];
void solve(){
    cin>>n; m=n*2+1;
    for(int i=0;i<3;++i)
        for(int j=0;j<=m;++j)
            fenwickTree[i][j]=0;
    for(int i=1;i<=n;++i){
        char now; cin>>now;
        if(now=='+') info[i]=1;
        else info[i]=-1;
        info[i]+=info[i-1];
    }
    function<int(int)>M=[&](int num)->int{return (num%3+3)%3;};
    int ans=0;
    for(int i=n;i>=0;--i){
        ans+=que(M(info[i]),info[i]+n+1);
        add(M(info[i]),info[i]+n+1,1);
    }
    cout<<ans<<endl;
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
