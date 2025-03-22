# 矩形周长Picture

所有者: Zvezdy
标签: 扫描线, 离散化, 线段树

到此为止，我们就可以总结线段树的每个部分的独立修改内容了。线段树可以拆分为几个部分：建树、区间所存储信息、区间信息合并、懒标记下发、区间合并特殊判断。通过有意识地修改这些部分，我们可以让每一步操作能在不同的情况下做出不同的选择，从而更加灵活地使用线段树。

通过扫描线的策略，我们使用线段树维护这一题的特殊信息，这里值得注意的就是关于区间合并的特殊判断操作。我们通过记录每一个区间被完全覆盖的次数，能够防止线段被多算或者少算，具体实现就是如果一个区间被完全覆盖，那么我们就可以直接使用这个区间所代表的长度，否则就从它所连接的下两个区间取信息。这题的离散化以及区间边界判断有很多细节，需要仔细甄别实现，反正我是被卡疯了。。。

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
#define debug(x) cout << #x << " = " << x << endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int MODE = 998244353;
const int N = 300005;

template <class Info>
struct SegmentTree {
    vector<Info> info;
    unordered_map<int, int> rank;
    int n;

    SegmentTree(vector<int>& array) {
        sort(array.begin(), array.end());
        int m = 1;
        rank[array[0]] = 0;
        for (int i = 1; i < array.size(); ++i) {
            if (array[m - 1] != array[i]) {
                rank[array[i]] = m;
                array[m++] = array[i];
            }
        }
        array.resize(m);
        n = m;
        info.resize(8 * n);

        function<void(int, int, int)> build = [&](int p, int l, int r) {
            if (r - l > 1) {
                int m = l + (r - l) / 2;
                build(2 * p, l, m);
                build(2 * p + 1, m, r);
            }
            info[p] = Info();
            info[p].full = array[r] - array[l];
        };
        build(1, 0, m);
    }

    void pull(int p) {
        if (info[p].times > 0) {
            info[p].cover = info[p].full;
        } else {
            info[p].cover = info[2 * p].cover + info[2 * p + 1].cover;
        }
        // cout << p << " " << 2 * p << " " << 2 * p + 1 << endl;
    }

    void rangeApply(int p, int l, int r, int x, int y, int type) {
        if (l >= y || r <= x) {
            return;
        }
        if (l >= x && r <= y) {
            info[p].times += type;
            pull(p);  // Add this line
            return;
        }
        int m = l + (r - l) / 2;
        rangeApply(2 * p, l, m, x, y, type);
        rangeApply(2 * p + 1, m, r, x, y, type);
        pull(p);
    }

    void rangeApply(int l, int r, int type) {
        rangeApply(1, 0, n, rank[l], rank[r], type);
    }
};

struct Info {
    int full = 0, cover = 0, times = 0;
};

void solve() {
    int n;
    cin >> n;
    vector<tuple<int, int, int, int>> rectangle(n);
    for (int i = 0; i < n; ++i) {
        int a, b, c, d;
        cin >> a >> b >> c >> d;
        rectangle[i] = {a, b, c, d};
    }

    struct Line {
        int index, low, high, type;
        bool operator<(Line other) {
            if (index == other.index)
                return type > other.type;
            else
                return index < other.index;
        }
    };

    int ans = 0;
    auto ScanLine = [&](vector<Line>& line, vector<int>& arr) {
        SegmentTree<Info> st(arr);
        sort(line.begin(), line.end());
        for (int i = 0, pre = 0; i < 2 * n; ++i) {
            pre = st.info[1].cover;
            st.rangeApply(line[i].low, line[i].high, line[i].type);
            ans += abs(pre - st.info[1].cover);
        }
        // cout << st.n << endl;
    };

    vector<Line> X(2 * n), Y(2 * n);
    vector<int> Xdisc(2 * n), Ydisc(2 * n);
    for (int i = 0; i < n; ++i) {
        auto [x1, y1, x2, y2] = rectangle[i];
        Xdisc[i] = x1, Xdisc[i + n] = x2;
        Ydisc[i] = y1, Ydisc[i + n] = y2;
        X[i] = {y1, x1, x2, 1};
        X[i + n] = {y2, x1, x2, -1};
        Y[i] = {x1, y1, y2, 1};
        Y[i + n] = {x2, y1, y2, -1};
    }

    ScanLine(X, Xdisc);
    ScanLine(Y, Ydisc);

    cout << ans;
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    // freopen("test.out", "w", stdout);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```