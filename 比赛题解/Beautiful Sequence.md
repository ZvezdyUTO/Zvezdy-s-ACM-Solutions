# Beautiful Sequence

所有者: Zvezdy
标签: 树状数组

易发现美丽序列就是l~r中所有元素出现过一遍的序列，我们可以选择枚举美丽序列的左端点，每次都找到其最大的右端点来计数。使用树状数组维护桶，通过秩值之和来判断我们每次新插入的数是否在两个序列中持有相同的相对位置。这里也是一个判断两个数组中是否有相同子序列的有效方法，只要我们每次插入的元素在两个数组中在相同的位置，那么它们前面数的个数一定是相同的，这也是使用树状数组动态维护这个区间元素和的原因。

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

std::array<int, N> a, b;

std::array<std::array<int, N>, 2> BIT;

void add(int i, int id, int v) {
    while (i <= n) {
        BIT[id][i] += v;
        i += i & -i;
    }
}

int sum(int i, int id) {
    int res = 0;
    while (i) {
        res += BIT[id][i];
        i -= i & -i;
    }
    return res;
}

bool check(int i) {
    return sum(a[i], 0) == sum(b[i], 1);
}

void push(int pos) {
    add(a[pos], 0, 1);
    add(b[pos], 1, 1);
}

void del(int pos) {
    add(a[pos], 0, -1);
    add(b[pos], 1, -1);
}

inline ll calculate() {
    ll ans = 0;
    push(1);
    // 按大小枚举
    for (int l = 1, r = 1; l <= n; ++l) {
        while (r < n && check(r + 1)) {
            push(++r);
        }
        // 我们是固定最小值来枚举的，所以是l,r l+1,r...
        ans += r - l + 1;
        del(l);
    }
    return ans;
}

void Main_work() {
    std::cin >> n;
    for (int i = 1, num; i <= n; ++i) {
        std::cin >> num;
        a[num] = i;
    }
    for (int i = 1, num; i <= n; ++i) {
        std::cin >> num;
        b[num] = i;
    }

    // 公共序列
    // 符合要求
    // 给出的是排列;

    // 美丽序列一定是x x+1 x+2 x+3 x+4打乱顺序

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