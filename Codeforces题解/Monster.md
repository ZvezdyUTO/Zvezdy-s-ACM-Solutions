# Monster

所有者: Zvezdy
标签: 数学, 暴力枚举
创建时间: 2024年11月27日 15:29

对于数学题目，设置未知数后设出方程是非常有效的做法。因为所有值都小于1e8，所以我们可以尝试枚举。根据强化和攻击的关系，一定有一个把攻击强化到某个上限后不停攻击的最优方案，我们设这个方案为升级a次、攻击b次，那么花费为a*x+b*y。问题是如何求出这个值。之前说了我们可以枚举，因为我们单次升级不超过k，所以前面一定是升k级打一次，我们设这样子一共进行了s轮，伤害为：k*s(s+1)/2。此时剩余的血量hp=z-k*s*(s+1)/2。

这时如果我们不继续强化攻击，那么现在的攻击力就定格在s*k，所需攻击次数就是(hp+s*k-1)/(s*k)。我们的强化一定是让我们的攻击次数减少，不然白强化，所以我们可以计算让我们攻击次数严格减少1需要此时提升多少攻击力：cur_atk=(hp+(times-1)-1)/(times-1)，如果发现计算出来的新攻击力超过了k，就是不合法，需要pass掉，不然就继续计算。

关于复杂度部分，我们前半轮所消耗的血量是平方增长的，所以需要枚举根号的复杂度，后半部分的复杂度并不是线性变化的，当我们的基础攻击很小的时候，需要的额外攻击频率很大，但是当我们以攻击频率-1为基准，向上取整地增加基础攻击的时候，攻击频率的衰减是非常大的。这种跳跃优化的复杂度在最坏情况下是log级的复杂度，所以整个枚举的代价为根号*对数级。

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

ll x, y, z, k;

ll get_cost(ll up, ll times) {
    return up * x + times * y;
}

inline ll Try() {
    ll ans = 1e18;

    for (ll s = 0;; ++s) {  //(s*(s+1)/2)*k>=z，复杂度为根号级别
        ll hp = z - k * s * (s + 1) / 2;
        ll cost = get_cost(k * s, s);

        if (hp <= 0) {
            ans = std::min(ans, cost);
            break;
        }

        ll atk = s * k;

        // k以内的时候进行枚举
        for (ll cur_atk = std::max(1ll, atk); cur_atk <= atk + k;) {
            ll up = cur_atk - atk;
            ll need = (hp + cur_atk - 1) / cur_atk;

            if (up > k) {
                break;
            }

            ans = std::min(ans, cost + get_cost(up, need));

            if (need == 1) {
                break;
            }

            // 每次提升最直观的收益就是所需攻击次数-1，不然没用
            // 而且因为向上取整cur_atk和need都是非线性变化的，所以不会跑满
            cur_atk = (hp + need - 1 - 1) / (need - 1);
        }
    }

    return ans;
}

void Main_work() {
    std::cin >> x >> y >> z >> k;
    std::cout << Try() << '\n';
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