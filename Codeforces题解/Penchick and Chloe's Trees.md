# Penchick and Chloe's Trees

所有者: Zvezdy
标签: 位运算, 图论, 思维
创建时间: 2024年11月16日 14:39

首先运用了一个性质，一棵完全二叉树，我们是能通过它的深度推导出它的叶子数量的，数量为2^(deep-1)，与此同时，我们是可以通过逆向思维，从叶子数量推断出完全二叉树深度的，尤其是当我们可以删叶子的时候，我们是可推导出最小深度。所以我们从叶子开始往上面递推，对于每个节点，收集它子树的所有深度，然后把深度转换为该深度所需叶子数，再拿这些叶子数之和转换为当前节点所需满二叉树深度。

这里有一个实现的trick，因为我们要枚举的是2的次幂，所以绝对会爆精度，得拿高精度来实现，而正好我们枚举的是2的次幂，因此可以直接高精度模拟2进制运算，每个位置就是2^?好了。一路加上去，然后拿这个数组计算我们所需的二叉树深度。注意我们的二进制运算数组其实是可以复用的，不用每次都清零。

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
int n;

std::array<std::vector<int>, N> edge;

std::array<int, N> calculate;

int dp(int now) {
    int max_deep = 0;

    std::vector<int> list;

    // 记录深度，寻找最大深度
    for (auto to : edge[now]) {
        int sub_deep = dp(to);
        list.push_back(sub_deep - 1);
        max_deep = std::max(sub_deep, max_deep);
    }

    // 用二进制模拟大整数加法，注意数组是复用的
    for (auto pow : list) {
        while (calculate[pow] == now) {
            calculate[pow++] = 0;
        }
        calculate[pow] = now;
        max_deep = std::max(max_deep, pow);
    }

    // 如果最高位被使用，并且前面还有未分配的低位，考虑进位
    // 因为这说明至少需要更多叶子才能装下该树
    if (calculate[max_deep] == now) {
        for (int i = 0; i < max_deep; ++i) {
            if (calculate[i] == now) {
                ++max_deep;
                break;
            }
        }
    }
    return max_deep + 1;
}

void Main_work() {
    std::cin >> n;

    for (int i = 0; i <= n; ++i) {
        edge[i].clear();
        calculate[i] = 0;
    }

    for (int v = 2, u; v <= n; ++v) {
        std::cin >> u;
        edge[u].push_back(v);
    }

    std::cout << dp(1) - 1 << '\n';
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