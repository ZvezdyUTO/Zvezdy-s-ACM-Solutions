# Alice's Adventures in Addition

所有者: Zvezdy
标签: 位运算, 动态规划
创建时间: 2024年11月19日 08:48

各种卡，疯狂卡，在这类包含加法运算并判断是否能到达某个点的题目中使用std::bitset进行状态转移应该是一个经典trick了。仔细分析这题的各种不同可能性，可以找到正确的转移方式。

首先我们一定是一格一格统计，我们走完第i格的时候能拼凑出什么状态。设上一个位置能到达的结果为一个bool集，称为cur，当前位置能到达的bool集称为next。如果只有加法，那就是用std::bitset左移?位或上去→next|=cur<<x。不过我们还有乘法，考虑一下乘法会给我们的运算带来什么影响，因为运算的优先级，我们把一连串相乘的数看作一个连通块，然后这些联通块被我们用加号拼起来，那么在一种可能性中，我们的算式应该是____+___+__+_+__+______… 这么观察下来，其实我们使用的还是std::bitset模拟加法运算进行转移，因为乘法部分我们可以把它们看作一个完整的数字。此时我们需要讨论上一个加号在什么位置，然后把上一个加号后面的数全部乘起来进行加法转移，这么看我们的时间复杂度可能是n^2  *m，但是根据乘法运算的增长速度，易发现在log次以内我们累计的乘数就会爆掉上限，所以我们只需要前面的log个状态。

拿std::bitset进行状态存储和转移，用std::deque<std::pair<int, std::bitset<>>>作滚动数组，严格保持在log的大小，就能卡掉这题的空间限制，注意std::deque是可以使用for auto按顺序访问的。

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

constexpr int N = 2e5 + 5;
constexpr int M = 1e4 + 5;
constexpr int LOG = std::__lg(M);
int n, m;

std::bitset<M> cur, prefix, zero;
std::bitset<M> next;
std::deque<std::pair<int, std::bitset<M>>> save;

inline bool dp() {
    cur = 1;  // f[0][0]=1
    prefix = 1;
    zero = 0;
    save.clear();

    for (int i = 1, x; i <= n; ++i) {
        std::cin >> x;
        next = zero;
        if (x == 0) {
            next |= prefix;
            zero |= next;
            save.push_front({0, cur});
        } else if (x == 1) {
            next |= cur | (cur << 1);
        } else {
            int now = 1;
            save.push_front(std::make_pair(x, cur));
            for (auto [value, state] : save) {
                now *= value;
                if (now > m) {
                    break;
                }
                next |= state << now;
            }
        }
        prefix |= next;
        cur = next;
        if (save.size() > LOG) {
            save.pop_back();
        }
    }
    return cur[m];
}

void Main_work() {
    std::cin >> n >> m;
    std::cout << (dp() ? "YES\n" : "NO\n");
}

void init() {}

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    init();
    int Zvezdy = 1;
    std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```