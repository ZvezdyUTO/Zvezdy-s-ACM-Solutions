# Function Query

所有者: Zvezdy

找到这个数组中和我们的a异或出来的最大值和最小值，如果它们两个在用函数处理后小于等于0，就说明存在合法答案，并且一定就在这两个数中间的某个位置。（证明的话就想象一下以两个数为头往中间延伸）。既然知道左右边界了，就写个二分查找，看当前数在^a-b后的结果移动边界就好。

如何找出这两个数以及他们的位置呢？使用01Trie就可以在log时间内找到目标数与某个数组中异或的最大/最小值，只是空间开销较大罢了。

这题的重点在于发现01trie的使用、从区间关系推导出位置关系，以及二分边界的更新条件。假如选择l<r这么更新，那么 l 和 r 一定最终会重合，在此期间区间的更新就是要么是l=mid+1,r=mid，要么是l=mid,r=mid-1，具体选择哪种是看check函数的等于部分在大于还是小于身上。另外就是这种index和index+1的关系，如果有两个index条件相符，答案肯定出在它们中间。最后就是字典树的坐标部分最好开成long，这样既不影响define int long long，也不会爆空间。

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
int arr[300005];
bitset<31>bin[300005];
int pos=1;
long trie[9000005][2];
struct Info{
    int index;
    int num;
}info[9000005];
void insert(bitset<31>& bs,int wh){
    int p=0;
    for(int i=30;i>=0;--i){
        int bit=bs[i];
        if(!trie[p][bit]){
            trie[p][bit]=pos++;
        }
        p=trie[p][bit];
    }
    info[p].num=bs.to_ullong();
    if(!info[p].index) info[p].index=wh;
}
PII find_maxn(bitset<31>& bs){
    int p=0;
    for(int i=30;i>=0;--i){
        int bit=bs[i];
        int o_bit=1-bit;
        if(!trie[p][o_bit]){
            p=trie[p][bit];
        }
        else{
            p=trie[p][o_bit];
        }
    }
    int now=bs.to_ullong();
    return make_pair((now^info[p].num),info[p].index);
}
PII find_minn(bitset<31>& bs){
    int p=0;
    for(int i=30;i>=0;--i){
        int bit=bs[i];
        int o_bit=1-bit;
        if(!trie[p][bit]){
            p=trie[p][o_bit];
        }
        else{
            p=trie[p][bit];
        }
    }
    int now=bs.to_ullong();
    return make_pair((now^info[p].num),info[p].index);
}
void solve(){
    int n,m; cin>>n>>m;
    for(int i=1;i<=n;++i){
        cin>>arr[i];
        bin[i]=arr[i];
        insert(bin[i],i);
    }

    function<void()>query=[&]()->void{
        int a,b; cin>>a>>b;
        bitset<31>binn=a;
        PII maxn=find_maxn(binn);
        PII minn=find_minn(binn);
        if((maxn.fi-b)*(minn.fi-b)>0){
            cout<<-1<<endl;
            return;
        }
        if(minn.se<maxn.se){
            int l=minn.se,r=maxn.se;
            while(l<r){
                int mid=(l+r+1)/2;
                if((arr[mid]^a)-b<0) l=mid;
                else r=mid-1;
            }
            cout<<l<<endl;
        }
        else{
            int l=maxn.se,r=minn.se;
            while(l<r){
                int mid=(l+r+1)/2;
                if((arr[mid]^a)-b<0) r=mid-1;
                else l=mid;
            }
            cout<<l<<endl;
        }
    };
    for(int i=1;i<=m;i++) query();
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