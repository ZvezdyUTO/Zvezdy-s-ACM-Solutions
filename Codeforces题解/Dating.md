# Dating

所有者: Zvezdy
标签: 数据结构
创建时间: 2024年11月7日 11:44

涉及了一系列的分析以及STL的运用，先从暴力的思路开始想起，如果我要找和一个用户有没有配对的用户，那么一定是去找和他有相同爱好的所有用户，这里有一个很考验码力的技巧：我们通过遍历这个用户的所有爱好，如此就能保证我们统计的是所有用户有相同爱好的数量，如果能够保证我们所考察的爱好在我们遍历到的所有用户都拥有的话，就说明它们要么重合要么被包含，为了能够让它们严格被包含，我们选择从爱好少的用户开始遍历。对于每个对比用户，统计和当前用户相同活动的数目，检查的时候如果发现重合数目少，那么一定是有相交但是不重合的活动，此时匹配合法。

然后就是后续的优化，对于我们已经考察过的活动，后续可以不再考察，因为我们之前经过对比已经发现此活动要么所有人都有，要么就是构不成合法对。

```cpp
/* ★ _____                           _         ★ */
/* ★|__  / __   __   ___   ____   __| |  _   _ ★ */
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★ */
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★ */
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★ */
/* ★                                     |___/ ★ */
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include <bits/stdc++.h>
using ll = long long;
#define debug(x) std::cout << #x << " = " << x << '\n'

const int N = 1e6 + 5;
int n, m;

std::array<int, N> ord;
std::array<std::vector<int>, N> activities, bucket;
std::array<int, N> count;
std::array<bool, N> del_act, del_user;

void filter_activities(std::vector<int> &arr) {
    std::vector<int> filtered;
    for (auto x : arr) {
        if (!del_act[x]) {
            filtered.push_back(x);
        }
    }
    arr = std::move(filtered);
}

void filter_user(std::vector<int> &arr) {
    std::vector<int> filtered;
    for (auto x : arr) {
        if (!del_user[x]) {
            filtered.push_back(x);
        }
    }
    arr = std::move(filtered);
}

int top = 0;
std::array<int, N> stack;

void Main_work() {
    std::cin >> n >> m;
    std::iota(ord.begin() + 1, ord.begin() + n + 1, 1);
    for (int i = 1, k; i <= n; ++i) {
        std::cin >> k;
        activities[i].resize(k);
        for (int it = 0, act; it < k; ++it) {
            std::cin >> act;
            activities[i][it] = act;
            bucket[act].push_back(i);
        }
    }

    std::sort(ord.begin() + 1, ord.begin() + n + 1, [&](int i, int j) {
        return activities[i].size() < activities[j].size();
    });

    for (int i = 1; i <= n; ++i) {
        int u = ord[i];
        if (activities[u].empty()) {
            continue;
        }
        int cnt = 0;

        filter_activities(activities[u]);
        if (activities[u].size() == 1) {
            del_user[u] = true;
            continue;
        }

        for (auto act : activities[u]) {
            ++cnt;
            filter_user(bucket[act]);
            // 对于当前用户，遍历和它有相同兴趣的用户
            // 因为我们是从小到大遍历的
            // 所以遍历到的用户应该都计数相同
            for (auto user : bucket[act]) {
                if (count[user] == 0) {
                    stack[++top] = user;
                }
                ++count[user];
            }
        }

        // 处理查询
        for (int j = 1; j <= top; ++j) {
            if (count[stack[j]] < cnt) {
                std::cout << "Yes\n";
                std::cout << u << ' ' << stack[j] << '\n';
                return;
            }
            count[stack[j]] = 0;
        }
        for (auto del : activities[u]) {
            del_act[del] = true;
        }
        del_user[u] = true;
        top = 0;
    }
    std::cout << "No";
}

void init() {}

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    init();
    int Zvezdy = 1;
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```