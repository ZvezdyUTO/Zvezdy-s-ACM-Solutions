# Equal XOR Segments

所有者: Zvezdy
标签: 位运算, 前缀和&差分
创建时间: 2024年5月6日 14:57

看到区间操作，很容易想到前缀处理。异或运算和前缀异或结合起来以后就能有很多奇怪的操作，在前缀异或数组中，我们的元素不再是单调变大，但我们可以通过寻找相同元素来进行数组分割，以寻找区间异或值相同的区间。

我们取两个有部分相交的连续区间进行区间异或，那么中间那个区间就会被异或两次。假如两个区间的区间异或值都为零，那么中间就那个区间的异或值就会被提纯出来。假如我们有一个区间异或值为0的区间，那我们无论在哪将区间分割为两半，都能保证左边的异或值等于右边的异或值。在此基础上就可以得知，按照上面重叠的方式所分割出来的左中右三个区间的区间异或值都相等。

那我们只要求出这种样子的两个相交区间就行，请注意，最左边的那个区间其实是可有可无的，如果没有最左边的那个区间，就代表我们找到了一个可以被切割为两半就能达成条件的区间。

但由于这题奇怪的数据范围，所以我们最好使用map来存储一些动态数组，动态数组用于存储相同数字的所在位置，以便于我们后期通过二分查找搜索元素位置。使用引用来作为某个地址的别名，再使用lower_bound函数可以查找其位置，只要我们找到后使用prev()将其退1，便可以找到第一个小于某元素的位置。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
#pragma GCC optimize(2)
#pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define int long long
#define ld double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x; endll
#define ddbug(x) cout<<x<<" "
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(int word=begin;word<=endd;++word)
#define ROF(word,begin,endd) for(int word=begin;word>=endd;--word)
#define cmp(what_type) function<bool(what_type,what_type)>
#define r(x) cin>>x
#define s(x) cout<<x
#define cint(x) int x;cin>>x
#define cchar(x) char x;cin>>x
#define cstring(x) string x;cin>>x
#define cll(x) ll x; cin>>x
#define cld(x) ld x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
const int MAXN=200001;
const int mode=1e9+7;
int a[MAXN];
void solve(){
    cint(n); cint(q);
    map<int,vector<int>>mp;
    mp[0].push_back(0);
    FOR(i,1,n){
        r(a[i]),a[i]^=a[i-1];
        mp[a[i]].push_back(i);
    }
    while(q--){
        cint(l); cint(r);
        //a[l]代表某个数  a[r]代表某个数
        //已知x出现的位置可以等于l，但y的位置一定不能等于r
        //不过说实话，当R=L-1的时候也无所谓
        if(a[r]==a[l-1]){
            s("YES"<<endl);
            continue;
        }
        auto &v1=mp[a[l-1]],&v2=mp[a[r]];//采用引用优化书写
        auto it1=lower_bound(v1.begin(),v1.end(),r);//第一个大于等于r
        auto it2=lower_bound(v2.begin(),v2.end(),l);//第一个大于等于l
        if(it1!=v2.end() && it2!=v1.begin() && *it2<*prev(it1))
        //prev()指的是上一个迭代器，而next()指的是下一个迭代器
        //只要返还第一个大于等于r的位置，再左移一位就是最后一个小于r的位置
            s("YES");
        else s("NO");
        endll;
    }
    endll;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT=1; 
    cin>>TTT;
    while(TTT--){solve();}
    return 0;
}

```
