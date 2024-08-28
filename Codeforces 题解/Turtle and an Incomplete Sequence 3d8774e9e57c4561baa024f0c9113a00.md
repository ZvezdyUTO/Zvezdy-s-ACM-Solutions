# Turtle and an Incomplete Sequence

所有者: Zvezdy
标签: 二进制, 数学, 构造
创建时间: 2024年6月10日 19:30

看一下计算机中整形除2的原理，实际上就是把二进制下的数字最低位删去。至于补回去，往后补1还是补0都是可以的，那最后就像最初想的，找到最小代价把它们转换，多余的部分就乘二除二补齐就好。那么就是找两个数在二进制状态下的最长公共前缀。

而在找最长公共前缀，也就是最小的转换步骤的时候有个技巧，已知这两个数一定会存在一个公共前缀，然后除二的操作就是抹掉它们的最后一位，这种前缀相同的那么就是谁大就抹谁的尾巴，最后一定可以把他们转为同一个串，那么中间抹尾的次数就是我们的最小步骤。

写一个双指针吧，从两端往中间缩，但是除的时候需要开一个新的变量，以便判断两个相交的时候是否相同。

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
#define endl '\n'
#define fi first
#define se second
#define dot pair<int, int>
const int MODE = 1e9 + 7;
const int INF = 0x7ffffff;
int a[200001],b[200001];
void solve(){
    int n,sum=0; cin>>n;
    for(int i=1;i<=n;++i) cin>>a[i],sum+=a[i];
    if(sum==-n){ for(int i=1,st=1;i<=n;++i,st^=1)
            cout<<st+1<<" ";
        cout<<endl; return;
    }
    int l=0,r=0,last=0;
    for(int i=1;i<=n;++i) if(a[i]!=-1){
        l=last,r=i,last=i;
        b[l]=a[l]; b[r]=a[r];
        if(l==0){
            for(int j=r-1,st=1;j>=1;--j,st^=1)
                if(st) b[j]=b[j+1]*2;
                else b[j]=b[j+1]/2;
            continue;
        }
        int ln=b[l],rn=b[r];
        while(l<=r){
            if(ln==rn) break;
            if(ln>rn){
                if(l==n){++l; break;}
                b[l+1]=ln/2;
                ln/=2;
                ++l; continue;
            }
            if(ln<rn){
                if(r==1){--r;break;}
                b[r-1]=rn/2;
                rn/=2;
                --r; continue;
            }
        }
        if(ln!=rn || (r-l)%2){cout<<-1<<endl; return;}
        for(int j=l+1,st=1;j<r;++j,st^=1)
            if(st) b[j]=b[j-1]*2;
            else b[j]=b[j-1]/2;
    }
    for(int i=last+1,st=1;i<=n;++i,st^=1)
        if(st) b[i]=b[i-1]*2;
        else b[i]=b[i-1]/2;
    for(int i=1;i<=n;++i) cout<<b[i]<<" "; cout<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0);
    cout.tie(0);
    int TTT = 1;
    cin>>TTT;
    while (TTT--){
        // cout<<TTT<<" ";
        solve();
    }
    return 0;
}
//从左右过来，但是要看最后是否交叉
```