# Rigged Games

所有者: Zvezdy

一道关于倍增以及ST表的好题，我们可以如此尝试：如果我们能够处理出从每个起点开始进行2^k轮游戏的结果并打出ST表，就可以轻松解决这一题。顺便也可以通过这一题来学习倍增以及ST表。

已知，ST表成立的一个重要条件是区间结构的一致性，这意味着我们不能通过跳跃来回到前面的位置，这题每次进行游戏都是往前一格，所以满足这个要求。我们设ST表的第一维为跳跃了2^i次，第二维为起点。那么我们只要计算了2^0次时各个位的跳跃结果，那么我们就可以使用动态规划计算后续结果，计算方式就是拿此处跳上2^(i-1)步后所在的位置跳上2^(i-1)步，具体写法就是：**`nxt[i][j] = nxt[i - 1][nxt[i - 1][j]];`** 

为了统计赢的次数，我们还需拿ST表来顺便求一个前缀和，具体做法就是拿我们此处2^(i-1)步所有的和再加上此处跳2^(i-1)步后再跳2^(i-1)步所有的和，具体写法为：**`res[i][j].fi = res[i - 1][j].fi + res[i - 1][nxt[i - 1][j]].fi;` 。**

打出ST表后，我们就可以挨个求解每个起点的胜负，以及更新我们的ST表了，毕竟每次比赛不同，所经过的局数也不同，跳跃到的位置自然也不同。我们从大到小遍历ST表，发现小的就往里面跳，这样我们只需nlog(n)就能求出每个起点的结果。最后只需要拿我们目前的结果去更新我们的ST表就行。跑一轮a再跑一轮b后输出答案。

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
const int INF = 1e18;
const int MODE = 998244353;

void solve() {
    int n, a, b;
    cin >> n >> a >> b;
    string s;
    cin >> s;

    vector<vector<int>> nxt(20, vector<int>(n));
    vector<vector<PII>> res(20, vector<PII>(n));
    for (int i = 0; i < n; ++i) {
        nxt[0][i] = (i + 1) % n;
        res[0][i] = (s[i] == '1' ? make_pair(0, 1) : make_pair(1, 0));
    }

    auto game = [&](int round) {
        for (int i = 1; i < 20; ++i) {
            for (int j = 0; j < n; ++j) {
                nxt[i][j] = nxt[i - 1][nxt[i - 1][j]]; //下一个位置
                res[i][j].fi = res[i - 1][j].fi + res[i - 1][nxt[i - 1][j]].fi;
                res[i][j].se = res[i - 1][j].se + res[i - 1][nxt[i - 1][j]].se;
            }
        }

        vector<int> nxt2(n, 0), res2(n, 0);
        for (int i = 0; i < n; ++i) {
            int cur = i, L = 0, R = 0;
            for (int j = 19; j >= 0; --j) {
                if (L + res[j][cur].fi < round && R + res[j][cur].se < round) {
                    L += res[j][cur].fi;
                    R += res[j][cur].se;
                    cur = nxt[j][cur];
                }
            }
            nxt2[i] = nxt[0][cur];
            res2[i] = res[0][cur].se;
        }

        for (int i = 0; i < n; ++i) {
            res[0][i] = (res2[i] ? make_pair(0, 1) : make_pair(1, 0));
            nxt[0][i] = nxt2[i];
        }
    };

    game(a);
    game(b);

    for (int i = 0; i < n; ++i) {
        cout << res[0][i].se;
    }
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    cout.tie(0);
    // freopen("test.out","w",stdout);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```