# Linguistics

所有者: Zvezdy
标签: 贪心
创建时间: 2025年3月4日 19:14

稍微观察以后发现，根本不能使用动态规划，超高的四维状态肯定会爆掉。观察一下题目的操作，看看能不能有什么别的方法。首先可知，该题要求的是验证，验证给出的小字符串能不能拼凑成大字符串，首先观察题目给出四种字符串的性质：A和B是非常通用，然后AB和BA适合特定的情形，也就是AB交叉的情形，先就着AB交叉的不同情况展开进行讨论。首先是长度问题，是奇数还是偶数，另外就是该子串是以A开头还是以B开头。经过讨论以后可以发现，如果是偶数字符串，那么A开头的偶数串就是可以用AB填满或者一个单A和单B剩余BA填满，B开头偶数串反之。而奇数串可以用len/2个任意双串填满，然后额外加上边缘字母一个。有了这些条件，我们就可以分割出所有的交替串一个一个进行讨论。这里还有一个关键条件，因为长串去掉两个头尾字母后更加灵活，所以处理偶数串的时候需要从短串往长串处理，奇数串的使用可以先记录然后后期分配。

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

void Main_work() {
    int aa, bb, cc, dd;
    std::cin >> aa >> bb >> cc >> dd;
    int a = aa, b = bb, c = cc, d = dd;
    std::string s;
    std::cin >> s;
    int n = s.size();

    // 基础计数：全字符串由A和B组成
    // 我们可以利用的A和B共有a+c+d和b+c+d个，不满足直接否
    // 观察字符串匹配方式：AB和BA都需要特定串比如ABABAB...
    // 这类交叉串有什么特点吗？
    // 例举出各种存在的形式，如
    // ABAB BABA ABA BAB...
    // 单元化它们：尽量例举出最基本的情况，以便于后面拼凑
    // 对于ABAB和BABA这种，可以拿AB拼也可以拿BA拼，但最后都是消耗单体
    // 能优先消耗CD字符串的就优先消耗，所以最好是拿AB和BA
    // 遇到ABA和BAB的，可以看作是ABAB或者BABA多一个单字符拼凑
    // ABABABA->优先AB尽可能拼？ ->?*AB+A   A+?*AB
    // BABABAB->优先BA尽可能拼？ ->?*BA+B   B+?*AB
    // 可以发现奇数交替组是完全无所谓的
    // 偶数交替组除了用它们匹配的进行匹配，另外就是A+B+另一个
    // 和我们剩余的A或者B有关吗

    // obb_A, obb_B, even_A, even_B;
    // 如何统计？
    // 可不可以一边统计一边记录，如果结束了就直接开始消除？
    // 观察两种处理方式吗？
    // 因为奇数部分处理起来比较通用，所以是可以存在通用计数里
    // 偶数部分处理有最优解，只有在无奈情况才使用非最优解
    // 所以偶数部分可以直接使用，而奇数部分选择是记录在案
    // 优先处理短的

    bool comb = false;
    int need = 0, l, r;

    auto solve = [&](int l, int r) {
        int len = r - l + 1;
        if (len % 2) {
            need += len / 2;
        } else {
            if (s[l] == 'A') {
                int min = std::min(c, len / 2);
                c -= min, len -= min * 2;
                if (len) {
                    int ano = (len - 2) / 2;
                    min = std::min(d, ano);
                    d -= min, ano -= 2 * min;
                }
            } else {
                int min = std::min(d, len / 2);
                d -= min, len -= min * 2;
                if (len) {
                    int ano = (len - 2) / 2;
                    min = std::min(c, ano);
                    c -= min, ano -= 2 * min;
                }
            }
        }
    };

    std::array<std::vector<std::array<int, 2>>, 2> chk;

    auto save = [&]() {
        int len = r - l + 1;
        if (len % 2) {
            solve(l, r);
        } else {
            chk[s[l] != 'A'].push_back({l, r});
        }
    };

    for (int i = 1; i < n; ++i) {
        if (s[i] != s[i - 1]) {
            if (!comb) {
                comb = true;
                l = i - 1, r = i;
            } else {
                ++r;
            }
        } else {
            if (comb) {
                comb = false;
                save();
            }
        }
    }
    if (comb) save();

    auto cmp = [&](std::array<int, 2> a, std::array<int, 2> b) {
        return a[1] - a[0] < b[1] - b[0];
    };

    std::sort(chk[0].begin(), chk[0].end(), cmp);
    std::sort(chk[1].begin(), chk[1].end(), cmp);
    for (auto [l, r] : chk[0]) solve(l, r);
    for (auto [l, r] : chk[1]) solve(l, r);

    int min = std::min(c, need);
    c -= min, need -= min;
    min = std::min(d, need);
    d -= min, need -= min;

    int used = (cc - c) + (dd - d);
    int need_a = 0, need_b = 0;
    for (auto ch : s) {
        if (ch == 'A')
            ++need_a;
        else
            ++need_b;
    }
    need_a -= used, need_b -= used;
    if (need_a <= aa && need_b <= bb) {
        std::cout << "YES\n";
    } else {
        std::cout << "NO\n";
    }
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