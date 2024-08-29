# MST

所有者: Zvezdy

真是，爆爆又力力啊。。。。首先把所有的点存储起来，存储边的时候统一让编号小的点在前面，并记录入度。在建图的时候，把度数小的点放在前面，这样遍历的时候会快很多。接着就是按询问一个一个暴力建图然后跑克鲁苏卡尔就好。。这居然能过！！！

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
const int INF = 1e18;

struct DSU {
    vector<int> f, siz;
    DSU() {}      // 记得创建的时候为打括号，n+1
    DSU(int n) {  // 初始化项目
        init(n);
    }
    void init(int n) {
        f.resize(n);
        iota(f.begin(), f.end(), 0);
        siz.assign(n, 1);
    }
    int find(int x) {  // 找祖宗，顺带路径压缩
        while (x != f[x]) {
            x = f[x] = f[f[x]];
        }
        return x;
    }
    bool same(int x, int y) {  // 看两个元素是否属于同一集合
        return find(x) == find(y);
    }
    bool merge(int x, int y) {  // 将两个元素的集合合并
        x = find(x);
        y = find(y);
        if (x == y) {
            return false;
        }
        siz[x] += siz[y];
        f[y] = x;
        return true;
    }
    int size(int x) {  // 获取某个元素所在集合的元素个数
        return siz[find(x)];
    }
};

int cnt, head[100005];  // 链式前向星
struct Edge {
    int to, dis, next;
} edge[200005];  // 记得双向边开双倍
void Add_edge(int from, int to, int w) {
    edge[++cnt].to = to;
    edge[cnt].dis = w;
    edge[cnt].next = head[from];
    head[from] = cnt;
}

void solve() {
    int n, m, q;
    cin >> n >> m >> q;
    DSU dsu(n + 1);

    vector<int> len(n + 1);
    vector<array<int, 3>> input(m);
    for (int i = 0; i < m; ++i) {
        cin >> input[i][0] >> input[i][1] >> input[i][2];
        if (input[i][0] > input[i][1]) {
            swap(input[i][0], input[i][1]);
        }
        ++len[input[i][0]];
        ++len[input[i][1]];
    }

    for (int i = 0; i < m; ++i) {
        int u = input[i][0], v = input[i][1];
        if (len[u] > len[v]) {
            swap(u, v);
        }
        Add_edge(u, v, input[i][2]);
    }

    vector<int> cur(n + 1, 0);
    while (q--) {
        int k;
        cin >> k;
        vector<int> ver(k);
        for (int i = 0; i < k; ++i) {
            cin >> ver[i];
            cur[ver[i]] = true;

            dsu.f[ver[i]] = ver[i];
            dsu.siz[ver[i]] = 1;
        }

        vector<array<int, 3>> now;
        for (auto u : ver) {
            for (int i = head[u]; i; i = edge[i].next) {
                if (cur[edge[i].to]) {
                    now.push_back({edge[i].dis, u, edge[i].to});
                }
            }
        }
        sort(now.begin(), now.end());

        int ans = 0, num = 0;
        for (auto [w, u, v] : now) {
            if (!dsu.same(u, v)) {
                dsu.merge(u, v);
                ans += w;
                ++num;
            }
            if (num == k - 1) {
                break;
            }
        }
        cout << (num == k - 1 ? ans : -1) << endl;

        for (int i = 0; i < k; ++i) {
            cur[ver[i]] = false;
        }
    }
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    cout.tie(0);
    long Zvezdy = 1;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```
