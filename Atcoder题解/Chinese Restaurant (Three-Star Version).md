# Chinese Restaurant (Three-Star Version)

所有者: Zvezdy
标签: 扫描线, 数学

函数题，使用数形结合进行分析是最适合的。这题在一开始就告诉我们整个区域是一个环，贡献产生于环上的最短距离，环上距离和顺时针距离以及逆时针距离完全挂钩，在计算这两个距离的时候我们可以将它们看作是一条非环直线，求得距离后再进行取模。

因为桌子和人是相对移动的，所以无论是看成桌子移动还是人移动都可以被接受。在移动的时候，每个人会有两种情况：如果人是朝目标移动，那么他的不满值减小，斜率为-1，否则就是不满值增大，斜率为1。在环上分析完成后，可以发现每个人的函数变化是一个分段函数，斜率为1和-1。对于此类多个一次函数求最值，我们需要考虑它们斜率变化位置的情况就行，另外，将它们的贡献使用代数式相加后，我们可以发现此类一次函数的值应等于 总斜率之和*坐标，坐标固定，只要我们能够求出当前总斜率，就可以轻松求出每一段函数值的变化情况。换言之，将多个一次函数复合后，从它们斜率变化的地方下手，每次都可以在o1内求出斜率变化和函数值变化，并且它们的函数的最值肯定从这些地方产生。用扫描线维护即可。

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

const int N = 2e5 + 5;
int n;

int p[N];

// 时间，斜率变化
std::map<int, int> scan;

int sum, k;

void Mask() {
    for (int i = 0; i < n; ++i) {
        int ld = (p[i] - i + n) % n;  // 向左的相对距离
        int rd = (ld + n / 2) % n;    // 向右的相对距离
        if (ld <= n - ld) {
            sum += ld;
            --k;
            scan[ld] += 2;
            if (rd) {
                if (n % 2) {
                    scan[rd] -= 1;
                    scan[rd + 1] -= 1;
                } else {
                    scan[rd] -= 2;
                }
            }
        } else {
            sum += n - ld;
            ++k;
            if (n % 2) {
                scan[rd] -= 1;
                scan[rd + 1] -= 1;
            } else {
                scan[rd] -= 2;
            }
            scan[ld] += 2;
        }
    }
}

int Calculate() {
    int pre = 0;
    int ans = sum;
    for (auto [cur, change] : scan) {
        sum += (cur - pre) * k;
        pre = cur;
        k += change;
        ans = std::min(ans, sum);
    }
    return ans;
}

void Main_work() {
    std::cin >> n;
    for (int i = 0; i < n; ++i) {
        std::cin >> p[i];
    }
    Mask();
    std::cout << Calculate() << '\n';
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