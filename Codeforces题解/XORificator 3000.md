# XORificator 3000

所有者: Zvezdy
标签: 位运算
创建时间: 2024年11月21日 10:04

纯粹的位运算性质题，题目给出了一个特殊的模数：2^i，这在位运算中其实意味着抹去后面i位，与右移i位等价。根据异或运算的特殊性质，我们想在异或的集中除去几个数，就直接异或上这个集合。所以我们需要运算：l~r的异或和 ^ l~r中无趣个数的异或和。

l~r的异或和可以通过1~l-1异或和 ^ 1~r异或和获得。经过打表摸索规律得：1~num的异或和为：num%4 ==0→num  , ==1→1 , ==2→num+1 , ==3→0。由此规律可快速求出l~r的区间异或和。

对于非有趣数个数，我们可以分为上下两个部分，因为这类数的规则是下半部分和k>>i一样，所以如果该类数个数为奇数个，那么下半部分才不为0，为k。而上半部分就是经典的下半部分相同的时候，l~r抹掉下半部分区间异或和然后左移i位。左右端点公式为(l-1-k)/2^i，(r-k)/2^i，减掉k是为了通过平移将同余k条件转换为同余0条件，也就是整除情况。将所有公式代入求解即为答案。

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

ll l, r, i, k;

ll Xor(ll num) {
    if (num == 0) {
        return 0;
    }
    if (num % 4 == 0) {
        return num;
    } else if (num % 4 == 1) {
        return 1;
    } else if (num % 4 == 2) {
        return num + 1;
    } else {
        return 0;
    }
}

ll Base() {
    return (Xor(r) ^ Xor(l));
}

ll Del() {
    ll L = (l - k) >> i;
    ll R = (r - k) >> i;
    return (((Xor(R) ^ Xor(L)) << i) + (((L ^ R) & 1) * k));
}

void Main_work() {
    std::cin >> l >> r >> i >> k;
    --l;

    std::cout << (Base() ^ Del()) << '\n';
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