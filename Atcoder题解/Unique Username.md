# Unique Username

所有者: Zvezdy
标签: dfs, 字符串

一眼过去这题就是一个字符串匹配，关于字符串匹配，最先关注的应该就是这题中字符串的数据大小。在这题中，题目明确给出了所有字符串的长度不超过16，非常短，那么我们完全可以用std::map或者std::set等容器进行处理，时间复杂度最多为len*log(n)。其中这题还提到，我们所需要拼接的字符串数量不超过8，再加上总长不超过16，完全可以使用爆搜把所有字符串的匹配情况拼凑出来并进行验证。

其次搜索的基础就是循环，把所有的可能性先循环一遍，用递归函数将循环进行嵌套，如果有额外的限制条件再分别进行判断并且剪枝。最后发现字符串的加法好像是非常好用的，在字符串很短的时候可以考虑直接加起来按值传递给下一个函数。

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
#define int ll
#define debug(x) std::cout << #x << " = " << x << '\n'

const int N = 8;
int n, m;

int sum = 0;

std::array<std::string, N> str;
std::map<std::string, bool> map;
bool vis[N];

void dfs(int idx, std::string cur, int sum_) {
    if (sum + sum_ > 16) {
        return;
    }
    if (idx == n && sum + sum_ >= 3 && !map.count(cur)) {
        std::cout << cur << '\n';
        exit(0);
    }
    for (int i = 0; i < n; ++i) {
        std::string cur_ = "";
        if (vis[i]) continue;
        vis[i] = true;
        if (idx != n - 1) {
            for (int j = 1; j <= 16; ++j) {
                cur_ += '_';
                if (sum_ + sum + n - idx - 2 <= 16) {
                    dfs(idx + 1, cur + str[i] + cur_, sum_ + j);
                } else {
                    break;
                }
            }
        } else {
            dfs(idx + 1, cur + str[i], sum_);
        }
        vis[i] = false;
    }
}

void Main_work() {
    std::cin >> n >> m;
    for (int i = 0; i < n; ++i) {
        std::cin >> str[i];
        sum += str[i].size();
    }
    for (int i = 1; i <= m; ++i) {
        std::string s;
        std::cin >> s;
        map[s] = true;
    }
    dfs(0, "", 0);
    std::cout << -1 << '\n';
}

void init() {
}

signed main() {
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