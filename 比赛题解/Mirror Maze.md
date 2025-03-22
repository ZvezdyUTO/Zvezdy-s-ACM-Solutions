# Mirror Maze

所有者: Zvezdy

根据光路唯一且可逆的特性，我们可以判断出两种情况：一是一条光最终消失在外界，二是一条光最终在迷宫内变为光环，光线不可能从一种情况中进入到另外一种情况，所以对于这两种情况我们发可以分开讨论。最后我们需要使用递归打出一张每个位置向不同方向发射光线的表，在询问时可以直接查询。

先来看光线的情况，对于消失在边界的光线，我们可以让它从边界射入迷宫，使用动态容器记录它的轨迹并且统计每处位置的答案。这条光最终会有两种情况，一是从另外一个边界射出，二是碰到镜子后反射回原点。我们先用dfs统计出完整的光路，接着再遍历这条光路，这里有一个小细节就是我们需要从光路的末端进行模拟。如果一条光路被折返，那么一定只有一处折返点，我们在到达那条折返点之前给我们同位置的反方向处打上时间戳，方便我们以后折返后判断这里以前有没有跑过。

除了光线，剩下的就都是光环了。光环内部的所有节点值一定都一样，所以对于光环来说，我们只需要在同一个时间戳内标记完整路径的所有不含方向的坐标，最后再统计并且打上答案就可以。

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
// #define int long long
#define debug(x) cout << #x << " = " << x << endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>

const int MODE = 998244353;
// const int INF = 1e18;
const int maxn = 30;
//              D U R L
const int dx[]{1, -1, 0, 0};
const int dy[]{0, 0, 1, -1};

const int c0[]{1, 0, 2, 3};
const int c1[]{0, 1, 3, 2};
const int c2[]{3, 2, 1, 0};
const int c3[]{2, 3, 0, 1};

int conv(int d, char c) {  // 用函数预处理转向
    if (c == '-') return c0[d];
    if (c == '|') return c1[d];
    if (c == '/') return c2[d];
    if (c == '\\') return c3[d];
    return -1;
}
unordered_map<char, int> choose;
void solve() {
    int n, m;
    cin >> n >> m;
    vector<string> mp;
    mp.resize(n);
    for (int i = 0; i < n; ++i) {
        cin >> mp[i];
    }

    vector<vector<array<int, 4>>> ans, visd;
    ans.resize(n, vector<array<int, 4>>(m, {0, 0, 0, 0}));
    visd.resize(n, vector<array<int, 4>>(m, {0, 0, 0, 0}));
    vector<vector<int>> vis;
    vis.resize(n, vector<int>(m, 0));
    int timestamp = 0;

    // 记录光链
    function<void(int, int, int)> stastic_line = [&](int X, int Y, int start) {
        vector<tuple<int, int, int>> buf;  // 记录光路
        function<void(int, int, int)> dfs_line = [&](int x, int y, int dir) {
            buf.push_back({x, y, dir});
            if (x < 0 || x >= n || y < 0 || y >= m) return;
            int nd = conv(dir, mp[x][y]);
            dfs_line(x + dx[nd], y + dy[nd], nd);
        };
        dfs_line(X, Y, start);
        reverse(buf.begin(), buf.end());

        int res = 0;
        ++timestamp;
        for (int i = 0; i < buf.size() - 1; ++i) {  // 开头不记录
            auto [x, y, d] = buf[i];
            if (i && !((mp[x][y] == '-' && (d & 2) || (mp[x][y] == '|' && !(d & 2))))) {
                // 不是终点，并且被反射
                if (vis[x][y] != timestamp) {
                    ++res;
                }
                vis[x][y] = timestamp;
            }
            visd[x + dx[d ^ 1]][y + dy[d ^ 1]][d] = timestamp;  // 记录被访问的时间
            ans[x + dx[d ^ 1]][y + dy[d ^ 1]][d] = res;         // 记录答案
        }
    };
    for (int i = 0; i < n; ++i) {
        stastic_line(i, 0, 2);
        stastic_line(i, m - 1, 3);
    }
    for (int i = 0; i < m; ++i) {
        stastic_line(0, i, 0);
        stastic_line(n - 1, i, 1);
    }

    // 记录光环
    function<void(int, int, int)> stastic_loop = [&](int X, int Y, int start) {
        int cnt = 0;
        ++timestamp;
        function<void(int, int, int)> dfs_loop = [&](int x, int y, int dir) {
            visd[x][y][dir] = timestamp;
            x += dx[dir];
            y += dy[dir];
            int nd = conv(dir, mp[x][y]);
            if (nd != dir) {                   // 发生转向
                if (vis[x][y] != timestamp) {  // 继续统计
                    ++cnt;
                }
                vis[x][y] = timestamp;
            }
            if (visd[x][y][nd] != timestamp) {  // 没回到开头
                dfs_loop(x, y, nd);
            }
        };
        dfs_loop(X, Y, start);

        ++timestamp;
        function<void(int, int, int)> mark_loop = [&](int x, int y, int dir) {
            ans[x][y][dir] = cnt;
            visd[x][y][dir] = timestamp;
            x += dx[dir];
            y += dy[dir];
            int nd = conv(dir, mp[x][y]);
            if (visd[x][y][nd] != timestamp) {
                mark_loop(x, y, nd);
            }
        };
        mark_loop(X, Y, start);
    };
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            for (int d = 0; d < 4; ++d) {
                if (!visd[i][j][d]) {
                    stastic_loop(i, j, d);
                }
            }
        }
    }

    // 处理查询
    int q;
    cin >> q;
    while (q--) {
        int x, y;
        cin >> x >> y;
        string s;
        cin >> s;
        cout << ans[x - 1][y - 1][choose[s[0]]] << endl;
    }
}
signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    cout.tie(0);
    choose['b'] = 0;
    choose['a'] = 1;
    choose['r'] = 2;
    choose['l'] = 3;
    // freopen("test.out","w",stdout);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```