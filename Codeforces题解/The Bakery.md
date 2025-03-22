# The Bakery

所有者: Zvezdy
标签: 动态规划, 线段树
创建时间: 2024年10月1日 22:22

看数据范围，容易猜到状态设计为O(nk)，前i个数划分了j段所能获得的最大价值，考虑如何设计转移方程。我们可以从dp[?][j-1]处转移过来，然后加上(?~i)这里所有不同数字的个数。那我们如何设计出一个查询结构能满足这个需求？重要的是这么一个问题：当我们遍历到一个数字的时候，他能对前面多远的地方造成影响？如果我们以当前这个位置作为结尾并往前选开头，那么当前这个数字到其上一次出现的地方都相当于多了一个不同的数字，所以我们的操作是把它前一次出现的地方~现在出现的地方下标-1这个区间都+1，这样线段树里存储的值就是我们状态转移方程所需的状态了，可以拿此来更新dp值。然后每更新完一层，我们就可以在下一层的时候把此时的dp值全部打入线段树中，重置整棵线段树，以便遍历下一层。

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
#define debug(x) cout << #x << " = " << x << endl
#define int long long
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int INF = 1e18;

struct Tag {
    int num = 0;
    void apply(Tag v) {
        num += v.num;
    }
};
struct Info {
    int maxn = 0;
    void apply(Tag v) {
        maxn += v.num;
    }
};
Info operator+(Info a, Info b) {
    Info c;
    c.maxn = max(a.maxn, b.maxn);
    return c;
}

struct segmentTree {
    const int n;
    vector<Info> info;
    vector<Tag> tag;
    segmentTree(int n) : n(n), info(4 << __lg(n)), tag(4 << __lg(n)) {
        fill(info.begin(), info.end(), Info());
    }

    void rebuild(vector<int>& init, int p, int l, int r) {
        if (r - l == 1) {
            info[p] = {init[l]};
            return;
        }
        int m = (l + r) / 2;
        rebuild(init, p << 1, l, m);
        rebuild(init, p << 1 | 1, m, r);
        pull(p);
        tag[p] = Tag();
    }
    void rebuild(vector<int>& init) {
        rebuild(init, 1, 0, n);
    }

    void pull(int p) {
        info[p] = info[p << 1] + info[p << 1 | 1];
    }
    void apply(int p, Tag v) {
        info[p].apply(v);
        tag[p].apply(v);
    }
    void push(int p) {
        apply(p << 1, tag[p]);
        apply(p << 1 | 1, tag[p]);
        tag[p] = Tag();
    }

    int rangeQuery(int p, int l, int r, int x, int y) {
        if (l >= y || r <= x) {
            return -INF;
        }
        if (l >= x && r <= y) {
            return info[p].maxn;
        }
        int m = l + (r - l) / 2;
        push(p);
        return max(rangeQuery(p << 1, l, m, x, y), rangeQuery(p << 1 | 1, m, r, x, y));  // 返回最大值
    }
    int rangeQuery(int l, int r) {
        return rangeQuery(1, 0, n, l, r);
    }

    void rangeApply(int p, int l, int r, int x, int y, Tag& v) {
        if (l >= y || r <= x) {
            return;
        }
        if (l >= x && r <= y) {
            apply(p, v);
            return;
        }
        int m = l + (r - l) / 2;
        push(p);
        rangeApply(p << 1, l, m, x, y, v);
        rangeApply(p << 1 | 1, m, r, x, y, v);
        pull(p);
    }
    void rangeApply(int l, int r, int v) {
        Tag change = {v};
        rangeApply(1, 0, n, l, r, change);
    }
};

// dp[t][i] = dp[t-1][?] + dif(?~i)

void solve() {
    int n, k;
    cin >> n >> k;
    vector<int> a(n + 1);
    for (int i = 1; i <= n; ++i) {
        cin >> a[i];
    }
    segmentTree ds(n + 1);

    vector<int> lst(n + 1, 0);
    vector<int> dp(n + 1, 0);
    for (int t = 1; t <= k; ++t) {
        fill(lst.begin(), lst.end(), 0);
        ds.rebuild(dp);
        for (int i = 1; i <= n; ++i) {
            ds.rangeApply(lst[a[i]], i, 1ll);
            lst[a[i]] = i;
            if (t <= i) {
                dp[i] = ds.rangeQuery(0, i);
            }
        }
    }
    cout << *max_element(dp.begin(), dp.end());
}

void init() {}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    init();
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```