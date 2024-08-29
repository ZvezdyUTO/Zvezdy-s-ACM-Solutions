# Set To Max (Hard Version)

所有者: Zvezdy
标签: 线段树
创建时间: 2024年5月10日 13:32

和普通一样的思路，我们如果要修改某个数，就找离它最近的那个数来转移，转移需要符合两个条件：1、我们的目标数在这个区间上的原数组中一定要是最大的，否则无法发生转移。2、我们的目标数在这个区间上的目标数组中一定要是最小的，不然转移会破坏已完成的数。打一个map记录目标数上一次在原数组中出现的位置，从左到右从右到左各跑一遍就好了，判断就使用线段树，只需要维护区间最值即可。

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

template<class Info, class Tag>
struct LazySegmentTree {
    const int n;
    vector<Info> info;
    vector<Tag> tag;
    LazySegmentTree(int n) : n(n), info(4 << __lg(n)), tag(4 << __lg(n)) {}
    LazySegmentTree(vector<Info> init) : LazySegmentTree(init.size()) {
        function<void(int, int, int)> build = [&](int p, int l, int r) {
            if (r - l == 1) {
                info[p] = init[l];
                return;
            }
            int m = (l + r) / 2;
            build(2 * p, l, m);
            build(2 * p + 1, m, r);
            pull(p);
        };
        build(1, 0, n);
    }
    void pull(int p) {
        info[p] = info[2 * p] + info[2 * p + 1];
    }
    void apply(int p, const Tag &v) {
        info[p].apply(v);
        tag[p].apply(v);
    }
    Info rangeQuery(int p, int l, int r, int x, int y) {
        if (l >= y || r <= x) {
            return Info();
        }
        if (l >= x && r <= y) {
            return info[p];
        }
        int m = (l + r) / 2;
        return rangeQuery(2 * p, l, m, x, y) + rangeQuery(2 * p + 1, m, r, x, y);
    }
    Info rangeQuery(int l, int r) {
        return rangeQuery(1, 0, n, l, r);
    }
};

constexpr int inf = 1000000000000000000;//1e18

struct Tag {
    int add = 0;

    void apply(Tag t) {
        add += t.add;
    }
};

struct Info {
    int minn = inf; //下方
    int maxn = -inf; //上方

    void apply(Tag t) {
        minn += t.add;
        maxn += t.add;
    }
};

Info operator+(Info a, Info b) {
    Info c;
    c.minn = min(a.minn, b.minn);
    c.maxn = max(a.maxn, b.maxn);
    return c;
}
map<int,int>ocu;
void solve(){
    int n; cin>>n;
    vector<Info>init(n);
    for(int i=1;i<=n;++i) cin>>init[i-1].maxn;
    for(int i=1;i<=n;++i) cin>>init[i-1].minn;
    LazySegmentTree<Info,Tag>segmentTree(init);
    bitset<200001>ac;
    for(int i=1;i<=n;++i){
        int a=init[i-1].maxn;
        int b=init[i-1].minn;
        if(a!=b && !ac[i]){
            int index=ocu[b];
            if(!index) continue;
            Info check=segmentTree.rangeQuery(index-1,i);
            if(check.maxn==b && check.minn==b) ac[i]=true;
        }
        else{
            ac[i]=true;
        }
        ocu[a]=i;
    }
    ocu.clear();
    for(int i=n;i>=1;--i){
        int a=init[i-1].maxn;
        int b=init[i-1].minn;
        if(a!=b && !ac[i]){
            int index=ocu[b];
            // debug(ocu[b]);
            if(!index) continue;
            Info check=segmentTree.rangeQuery(i-1,index);
            // debug(check.maxn);
            // debug(check.minn);
            if(check.maxn==b && check.minn==b) ac[i]=true;
        }
        else{
            ac[i]=true;
        }
        ocu[a]=i;
    }
    ocu.clear();
    bool flag=true;
    for(int i=1;i<=n;++i){
        flag&=ac[i];
        // if(!ac[i]) debug(i);
    }
    cout<<(flag ? "Yes":"No")<<endl;
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
