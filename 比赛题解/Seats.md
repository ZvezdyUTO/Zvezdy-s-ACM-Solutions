# Seats

所有者: Zvezdy
标签: 拓扑排序

某个数从一个位置跳到另外一个位置，经典的图论模型，我们把每个人按照原始位置→期望位置连起来以后，就会得到一张图，已知所有人的期望位置只有一个，意味着该图所有点出度为1，那就是典型的伪森林，因为这题中的出度要么为1要么为0，所以所有路一定要么终结于环上，要么终结于链上，并且环一定是出现在末尾。

环上的元素一定是可以相互用抵消坐满的，那么就是链上的问题了，如果是单链，那么也可以完全满足，剩余连接到环上的链，是取不到的，因为只有环上是合法的

这里有一个实现的技巧，已知使用拓扑排序，我们不会遍历环上的点，同时注意到我们链条的结束位置永远在大于n的后半部分，对于树状部分，我们考虑使用dp收集最长路，环的部分我们只取环。正难则反，考虑设一开始答案为2*n，然后把所有入度为0的点都拿去跑拓扑排序，跑一个点我们删一个点的贡献，直到它保证自己是一棵树，再把它路上最大贡献累加起来，这样子做我们也不用判环了，因为环不会被我们遍历到，所以它上面的贡献是不会被拿掉的。

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

const int N = 1e5 + 5;
int n;

std::array<int, 2 * N> to;
std::array<int, 2 * N> into;

std::queue<int> queue;
std::array<int, 2 * N> dist;

inline int calculate() {
    int res = 2 * n;
    for (int i = 1; i <= 2 * n; ++i) {
        if (into[i] == 0) {
            queue.push(i);
        }
    }
    while (queue.size()) {
        int now = queue.front();
        queue.pop();
        --res;
        if (now > n) {
            res += dist[now];
        } else {
            dist[to[now]] = std::max(dist[to[now]], dist[now] + 1);
            if (--into[to[now]] == 0) {
                queue.push(to[now]);
            }
        }
    }
    return res;
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> to[i];
        ++into[to[i]];
    }
    std::cout << calculate();
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