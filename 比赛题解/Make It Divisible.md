# Make It Divisible

所有者: Zvezdy
标签: ST表, 单调栈, 数学

题目给出了几个关键信息：1. 题目要让这个数组每个数都加上一个x 。2. 数组在完成操作后需要满足每个子数组都有一个数是该数组所有数的因数。

每个子数组都有一个数是该数组所有数字的因数，意味着出现一个数能够将该数组中的所有数整除，这个数肯定是最小的，如此一来，就可以知道该数组的公因数等于该数组的最小数。于是我们只要满足：每个子数组的公因数都等于该子数组的最小值即可。

利用同余原理，我们可以证明出gcd(a, b)=gcd(min(a, b),  |a-b|)，进而推广出整个数组的gcd=gcd(gcd(数组之间差值), 最小值)。题目给出的操作不会让数组之间元素大小发生改变，所以gcd(数组之间的差值)是固定值，为了符合要求，我们必须要让数组的最小值在经过处理后等于这个数的因数，按照这个规则，我们可以找到验证的方式。

为了验证每一个子数组都合法，我们需要找到一个拆分数组的方式，可以发现我们每次拆分都是为了分离出最小值不同的数组，易想到利用笛卡尔树的小根堆性质进行拆分。但是拆分后以后发现如果每个子节点都如此进行验证，需要的复杂度过高，考虑进行优化。

已知我们的x是具有全局性的，那我们其实可以考虑从某个节点里面弄出一堆待选的x值，然后再拿它们一个一个进行验证，最后通过验证的就累加进答案。行动如下：从根节点也就是全局数组找出数组差值的gcd，求它的因子，这些因子就是我们的候选集合。接下来需要验证它们，使用单调栈分解数组，求出以第i个元素作为子数组最小值的时候的子数组区间，区间gcd是rmq问题可以拿st表进行快速求解。

trick：如果我们是从区间答案里面求交集出一个全局答案，可以选出最小区间的答案，然后用它们在全局进行验证，可能会减少复杂度。求全局子数组不一定真求全局，这些子数组很可能都有一些特性，同过这些特性可以找到一种树形的方式进行分解，比如挖数组最值就使用笛卡尔树，最后其实不一定需要真正建树，只要在逻辑处理阶段打出了结构，就能找到解法，比如这题到后面就是使用单调栈处理每个元素第一个小于它的左右边界。

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

const int N = 5e4 + 5;
int n, k;
int arr[N], dif[N];
int st_gcd[N][17], l[N], r[N];

void Build_bounds() {
    std::stack<int> stk;
    for (int i = 1; i <= n; ++i) {
        while (stk.size() && arr[i] <= arr[stk.top()]) stk.pop();
        l[i] = stk.empty() ? 1 : stk.top() + 1;
        stk.push(i);
    }
    stk = std::stack<int>();
    for (int i = n; i >= 1; --i) {
        while (stk.size() && arr[i] <= arr[stk.top()]) stk.pop();
        r[i] = stk.empty() ? n : stk.top() - 1;
        stk.push(i);
    }
}

void Build_ST() {
    for (int i = 2; i <= n; ++i) dif[i] = std::abs(arr[i] - arr[i - 1]);
    for (int i = 2; i <= n; ++i) st_gcd[i][0] = dif[i];
    for (int p = 1; (1 << p) <= n; ++p) {
        for (int i = 2; i + (1 << p) - 1 <= n; ++i) {
            st_gcd[i][p] = std::gcd(st_gcd[i][p - 1], st_gcd[i + (1 << (p - 1))][p - 1]);
        }
    }
}

int query(int L, int R) {
    if (L == R) return 0;
    ++L;
    int p = std::__lg(R - L + 1);
    return std::gcd(st_gcd[L][p], st_gcd[R - (1 << p) + 1][p]);
}

void Main_work() {
    std::cin >> n >> k;
    for (int i = 1; i <= n; ++i) std::cin >> arr[i];

    Build_bounds();
    Build_ST();

    int g_gcd = 0, min = *std::min_element(arr + 1, arr + n + 1);
    for (int i = 2; i <= n; ++i) g_gcd = std::gcd(g_gcd, dif[i]);

    if (g_gcd == 0) {
        std::cout << k << ' ' << (1 + k) * k / 2ll << '\n';
        return;
    }

    int cnt = 0, sum = 0;

    auto check = [&](int num) {
        int x = num - min;
        if (x < 1 || x > k) return;
        for (int i = 1; i <= n; ++i) {
            if (query(l[i], r[i]) % (arr[i] + x)) {
                return;
            }
        }
        ++cnt;
        sum += x;
    };

    for (int d = 1; d * d <= g_gcd; ++d) {
        if (g_gcd % d) continue;
        check(d);
        if (d != g_gcd / d) check(g_gcd / d);
    }

    std::cout << cnt << ' ' << sum << '\n';
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
    std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```