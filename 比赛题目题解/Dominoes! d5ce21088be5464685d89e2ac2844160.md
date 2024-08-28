# Dominoes!

所有者: Zvezdy

小思维，大模拟题，怎么放牌比较难想。两面不同的牌比较容易放，但是两面相同的牌不是很好放，所以我们先考虑怎么处理它们。很容易想到交叉放牌，为了让我们的牌尽可能的被消耗掉，我们可以贪心的选择使用最多的牌先来放置，这个打一个优先队列就可以完成。此时最多只剩一种类型的牌，对于这些牌，我们可以用两两不相同的牌来插在他们中间，判断能不能放得下就是看这段了。最后把剩余的牌全部放好输出就行。

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
    int n;
    cin >> n;
    vector<PII> Dominor;
    unordered_map<int, int> freq_map;

    for (int i = 1; i <= n; ++i) {
        int a, b;
        cin >> a >> b;
        if (a == b) {
            ++freq_map[a];
        } else {
            Dominor.emplace_back(make_pair(a, b));
        }
    }

    priority_queue<PII> freq_pq;
    for (auto& [v, num] : freq_map) {
        freq_pq.push({num, v});
    }

    int lastNum = -1;
    vector<PII> ans;
    while (!freq_pq.empty()) {
        auto findNextDominor = [&](int ban) {
            if (freq_pq.empty()) {
                return -1ll;
            }

            auto [num, v] = freq_pq.top();
            freq_pq.pop();

            if (v != ban) {
                if (num > 1) {
                    freq_pq.push({num - 1, v});
                }
                return v;
            }

            if (freq_pq.empty()) {
                freq_pq.push({num, v});
                return -1ll;
            }

            auto [num2, v2] = freq_pq.top();
            freq_pq.pop();
            freq_pq.push({num, v});

            if (num2 > 1) {
                freq_pq.push({num2 - 1, v2});
            }
            return v2;
        };

        int cur = findNextDominor(lastNum);
        if (cur == -1) {
            break;
        }
        ans.push_back({cur, cur});
        lastNum = cur;
    }

    if (!freq_pq.empty()) {
        auto [num, v] = freq_pq.top();
        freq_pq.pop();
        vector<PII> tmp;

        for (auto& now : Dominor) {
            if (num > 0 && now.fi != now.se && now.fi != v && now.se != v) {
                ans.push_back(now);
                ans.push_back({v, v});
                --num;
            } else {
                tmp.push_back(now);
            }
        }

        if (num > 0) {
            cout << "No" << endl;
            return;
        }
        Dominor = tmp;
    }

    for (auto& now : Dominor) {
        if (now.fi == lastNum) {
            ans.push_back({now.se, now.fi});
        } else {
            ans.push_back(now);
            lastNum = now.se;
        }
    }

    cout << "Yes" << endl;
    for (auto& [a, b] : ans) {
        cout << a << ' ' << b << endl;
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