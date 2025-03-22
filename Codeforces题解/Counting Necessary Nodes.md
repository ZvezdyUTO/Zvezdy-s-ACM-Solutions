# Counting Necessary Nodes

所有者: Zvezdy
标签: 位运算
创建时间: 2025年3月18日 21:36

题目真的难读，但是这种和2的某次方有关系的都可以直接拆二进制位处理。填补操作是填方块把这个空位填满，如果拆成单个维度来看，完全可以看作是线段缩进，不过这题还受限制于必须使用方形填补，所以还得考虑这么填补的时候能不能把另一维填上，2^(k+?)一定能整除2^k，因此只需要找上下左右边界中二进制最低位来填补就一定能满足条件，同时又能单次贡献最大填补量。反复填补直到结束即可。

```cpp
/*
 *  ██╗   ██╗████████╗ ██████╗ ███╗   ██╗██╗   ██╗████████╗
 *  ██║   ██║╚══██╔══╝██╔═══██╗████╗  ██║██║   ██║╚══██╔══╝
 *  ██║   ██║   ██║   ██║   ██║██╔██╗ ██║██║   ██║   ██║
 *  ██║   ██║   ██║   ██║   ██║██║╚██╗██║██║   ██║   ██║
 *  ╚██████╔╝   ██║   ╚██████╔╝██║ ╚████║╚██████╔╝   ██║
 *   ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝    ╚═╝
 *
 *  ███████╗██╗   ██╗███████╗███████╗██████╗ ██╗   ██╗
 *  ╚══███╔╝██║   ██║██╔════╝╚══███╔╝██╔══██╗╚██╗ ██╔╝
 *    ███╔╝ ██║   ██║█████╗    ███╔╝ ██║  ██║ ╚████╔╝
 *   ███╔╝  ╚██╗ ██╔╝██╔══╝   ███╔╝  ██║  ██║  ╚██╔╝
 *  ███████╗ ╚████╔╝ ███████╗███████╗██████╔╝   ██║
 *  ╚══════╝  ╚═══╝  ╚══════╝╚══════╝╚═════╝    ╚═╝
 */
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include <bits/stdc++.h>
using ll = long long;
#define int ll
#define debug(x) std::cout << #x << " = " << x << '\n'

void Main_work() {
    int l1, r1, l2, r2;
    std::cin >> l1 >> r1 >> l2 >> r2;

    auto lowbit = [&](int num) {
        if (num == 0) return (int)1e17;
        return num & -num;
    };

    int ans = 0;
    while (true) {
        if (l1 == r1 || l2 == r2) break;
        int low_l1 = lowbit(l1);
        int low_r1 = lowbit(r1);
        int low_l2 = lowbit(l2);
        int low_r2 = lowbit(r2);
        int min = std::min({low_l1, low_l2, low_r1, low_r2});

        if (low_l1 == min) {
            ans += (r2 - l2) / min;
            l1 += min;
        } else if (low_l2 == min) {
            ans += (r1 - l1) / min;
            l2 += min;
        } else if (low_r1 == min) {
            ans += (r2 - l2) / min;
            r1 -= min;
        } else if (low_r2 == min) {
            ans += (r1 - l1) / min;
            r2 -= min;
        }
    }
    std::cout << ans << '\n';
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