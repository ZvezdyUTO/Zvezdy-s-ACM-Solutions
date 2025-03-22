# Turtle and a MEX Problem (Hard Version)

所有者: Zvezdy
标签: 动态规划, 思维
创建时间: 2024年10月5日 15:58

可以敏锐地发现一些规律，比如，我们拿现有的数去填补某个数组并求mex，那么我们可能从这个数组中得到的mex就有两个，如果我们目前手持的数是较小的mex值，那么我们就能在这个数列中跳到较大的那个mex值，如此反复可以发现，这就是一张单向图。而我们可以通过一些操作让某个值在图上”滑“向最大值，现在来优化这个过程：这个图一定是从上往下节点权从小变到大的，因为mex只能从小往大跑，那么我们就可以从大到小来填补一个查询数组，数组的作用是快速查某个点在图上最好能跑到哪，那么我们从大到小更新，刚好就是逆着图跑，每次只用继承相邻节点的值就好。到这里还没有考虑完，有的点是重的，也就是对于图外元素，可以通过跑一次这个点变为这个点上的元素，然后再通过这个点跑到最大值处，我们只需要维护我们所能拿到的最大初始mex值，还有那种出度大于1的点的跳转值就好。

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

const int N = 2e5;

struct Edge {
    int to, next;
};
int cnt = 0;
array<int, N + 1> head;
array<Edge, N + 1> edge;
void Add_edge(int from, int to) {
    edge[++cnt].to = to;
    edge[cnt].next = head[from];
    head[from] = cnt;
}

void solve() {
    int n, m;
    cin >> n >> m;
    int max_mex = -1, global_max = 0;
    vector<PII> build;
    for (int i = 1, len; i <= n; ++i) {
        cin >> len;
        set<int> arr;
        for (int j = 0, now; j < len; ++j) {
            cin >> now;
            arr.insert(now);
        }
        int u = 0;
        while (arr.count(u)) {
            ++u;
        }
        arr.insert(u);
        max_mex = max(max_mex, u);

        int v = u + 1;
        while (arr.count(v)) {
            ++v;
        }
        global_max = max(global_max, v);

        build.push_back(make_pair(u, v));
    }

    cnt = 0;
    fill(head.begin(), head.begin() + global_max + 1, 0);
    for (auto& [u, v] : build) {
        Add_edge(u, v);
    }

    vector<int> max_evo(global_max + 1);
    for (int now = global_max; now >= 0; --now) {
        max_evo[now] = now;
        int size = 0;
        for (int i = head[now]; i; i = edge[i].next, ++size) {
            int to = edge[i].to;
            max_evo[now] = max(max_evo[now], max_evo[to]);
        }

        // 说明能从其它地方绕过来
        if (size >= 2) {
            max_mex = max(max_mex, max_evo[now]);
        }
    }

    int ans = 0;
    for (int i = 0; i <= min(m, global_max); ++i) {
        ans += max(max_mex, max_evo[i]);
    }
    if (global_max < m) {
        ans += (global_max + m + 1) * (m - global_max) / 2;
    }
    cout << ans << endl;
}

void init() {}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    init();
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```