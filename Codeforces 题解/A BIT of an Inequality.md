# A BIT of an Inequality

所有者: Zvezdy
标签: 位运算, 前缀和&差分, 组合数学
创建时间: 2024年6月12日 12:35

只想到了一半。。。就是某个区间上的这些数的某一位上的1的个数总和从偶数变奇数的时候，可以实现题目的条件，但如果数字变多位数变杂的时候就很难处理。但根据异或的特殊性质，其实异或的所有“操作”都是可以被“压缩“起来的。也就是说，最方便的根本不是统计一个区间上某一位1的个数，而是就像题目一开始那样直接提前求好区间异或和再异或上中间那个数。

回到原来的条件：一段区间异或XOR区间中的某个数，会不会变大。已知区间异或是将前缀异或数组的 尾 XOR prev(头)，此时再XOR中间的某个数，中间的这个数要想对这个区间异或造成影响，那肯定必须为1，如果是正面影响的话，那么左右这两个数的某一位要么都为1要么都为0，而且这仅仅只是在这一位上造成了影响，其它位置上的影响暂且未知，这么看来我们最好选中间这个数的highbit来模拟，因为它如果能增，一定会增，如果不能增，低位的也不可能有得增。

因此，在判断二进制计数这类题目的时候，如果发现那种很复杂的情况，比如每一位上的条件又不同，就可以考虑highbit或者lowbit能不能作为最佳的情况来讨论。

最后组合数学，维护一个变量作为统计某个位上1的个数的前缀和，然后就是左半边0的个数x右半边0的个数+左半边1的个数x右半边1的个数，不过实际上要考虑的细节远比这个简单的公式多，首先其实左边界可以不选，因为是前缀异或和，所以左半边的0的个数需要多计一个。

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
int a[200001],b[200001],bitsum[200001][31];
void solve(){
    int n; cin>>n;
    for(int i=1;i<=n;++i){
        cin>>a[i];
        b[i]=a[i];
        b[i]^=b[i-1];
    }
    for(int i=1;i<=n;++i)
        for(int j=0;j<=30;++j){
            bitsum[i][j]=(bool)(b[i]&(1<<j));
            bitsum[i][j]+=bitsum[i-1][j];
        }
    int ans=0;
    for(int i=1;i<=n;++i){//枚举中间的数字
        for(int j=30;j>=0;--j) if((1<<j)&a[i]){//找到最高位
            int l1=bitsum[i-1][j] , r1=bitsum[n][j]-bitsum[i-1][j];
            int l0=(i-1)-l1+1 , r0=n-(i-1)-r1;
            ans+= l0*r0 + l1*r1;
            break;
        }
    }
    cout<<ans<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    int TTT = 1;
    cin>>TTT;
    while (TTT--){
        // cout<<TTT<<" ";
        solve();
    }
    return 0;
}

```
