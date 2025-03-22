# Centroids

所有者: Zvezdy
标签: 换根DP
创建时间: 2024年9月20日 00:07

关于换根DP的分析题。我们想要看这个点能不能被修改为重心，就看它最大子树中的最大的、不大于n/2的子树被删除以后，剩余部分是否小于n/2，为此我们需要记录每个小子树中，最优的可被删除并拼接的子树。接着就是换根操作了，换根比较重要的地方就是我们是选择一条路来走，也就是选择了一个点，那么我们的图就会被分为两部分：一部分是我们选择的子树部分，另一部分是我们走过来那个点另一边的所有部分，这两个部分通过这个点连接在一起。所以我们需要找：当前根中，最大的子树是哪棵？我们能修改的部分是哪个？

分两部分来看：我们划分的子树部分在我们跑第一次DFS的时候就已经把所有答案全部记录好，此时就是我们走过来的另一部分了，记为other。我们想更新other，一是看它自己是否小于等于n/2，如果是这样那么它自己就可以作为被删除的部分了；而另一种情况就是，如果other>n/2，那么我们就需要在此处找到一棵子树作为下一步other的值，这里有两种情况：一是我们选择的那个值可能刚好为我们下一步需要走向的点，另一个就是我们下一步走的点不是我们目前选择删除子树的根。为了避免第一种情况，我们需要在第一次DFS中处理出最优和次优答案，以便于在最优答案失效的时候可以使用次优来填补other。

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

const int N = 4e5;

struct Edge {
    int to, next;
};
int cnt = 0;
array<int, N + 1> head;
array<Edge, 2 * N + 1> edge;
void Add_edge(int from, int to) {
    edge[++cnt].to = to;
    edge[cnt].next = head[from];
    head[from] = cnt;
}

void solve() {
    int n;
    cin >> n;
    for (int i = 1, u, v; i < n; ++i) {
        cin >> u >> v;
        Add_edge(u, v);
        Add_edge(v, u);
    }

    struct Info {
        int del1, del2, other, subsize;
        int bestway;
    };
    vector<Info> info(n + 1, {0, 0, 0, 1});
    auto get_info = [&](auto& self, int now, int par) -> void {
        for (int i = head[now]; i; i = edge[i].next) {
            int to = edge[i].to;
            if (to != par) {
                self(self, to, now);

                // 收集子节点信息
                info[now].subsize += info[to].subsize;
                int del = info[to].del1;
                if (info[to].subsize <= n / 2) {  // 如果符合要求可以直接拿整棵子树
                    del = info[to].subsize;
                }
                if (del > info[now].del1) {
                    info[now].bestway = to;
                    info[now].del2 = info[now].del1;
                    info[now].del1 = del;
                } else if (del >= info[now].del2) {
                    info[now].del2 = del;
                }
            }
        }
    };
    get_info(get_info, 1, -1);

    // 换根DP开始
    vector<bool> ans(n + 1, 0);
    info[0] = info[1];
    auto f = [&](auto& self, int now, int par) -> void {
        int maxsize = 0;
        for (int i = head[now]; i; i = edge[i].next) {
            int to = edge[i].to;
            if (to != par) {
                maxsize = max(maxsize, info[to].subsize);
                if (n - info[to].subsize <= n / 2) {
                    info[to].other = n - info[to].subsize;
                } else if (info[now].bestway != to) {
                    info[to].other = max(info[now].other, info[now].del1);
                } else {
                    info[to].other = max(info[now].other, info[now].del2);
                }
                self(self, to, now);
            }
        }
        if (maxsize > n / 2) {
            ans[now] = (maxsize - info[now].del1 <= n / 2);
        } else if (n - info[now].subsize > n / 2) {
            ans[now] = (n - info[now].subsize - info[now].other <= n / 2);
        } else {
            ans[now] = true;
        }
    };
    f(f, 1, 0);

    for (int i = 1; i <= n; ++i) {
        cout << ans[i] << " ";
    }
}

void init() {
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    init();
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```