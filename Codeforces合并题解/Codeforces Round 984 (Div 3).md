# Codeforces Round 984 (Div. 3)

所有者: Zvezdy
标签: 二分查找, 互动题, 位运算, 模拟
创建时间: 2024年11月21日 15:32

警告！！！超级无敌模拟+二分场

# A. [Quintomania](https://codeforces.com/contest/2036/problem/A)

边输入边判断，用std::abs求绝对值。

```cpp
int n;

void Main_work() {
    std::cin >> n;
    int last;
    std::cin >> last;

    bool ok = true;
    for (int i = 2, now; i <= n; ++i) {
        std::cin >> now;
        if (abs(now - last) != 5 && abs(now - last) != 7) {
            ok = false;
        }
        last = now;
    }
    std::cout << (ok ? "YES\n" : "NO\n");
}
```

# B. [Startup](https://codeforces.com/contest/2036/problem/B)

瓶子数量无限，那么每种饮料的收益就是饮料数量*饮料价值，做法就是拿词频表加工完进行排序。

```cpp
ll n, k;
std::map<int, ll> mp;
std::vector<ll> save;

void Main_work() {
    std::cin >> n >> k;
    mp.clear();
    for (int i = 1, id, v; i <= k; ++i) {
        std::cin >> id >> v;
        mp[id] += v;
    }
    save,clear();
    for (auto [_, v] : mp) {
        save.push_back(v);
    }
    std::sort(save.begin(), save.end(), std::greater<ll>());

    ll ans = 0;
    for (int i = 0; i < std::min(save.size(), (size_t)n); ++i) {
        ans += save[i];
    }
    std::cout << ans << '\n';
}
```

# C. [Anya and 1100](https://codeforces.com/contest/2036/problem/C)

不可能每次询问都暴力判断一遍，注意到每次修改只会影响当前位置以及前面三个位置的状态，每次更新前时候先消除影响，更新后再累加影响就行。

```cpp
std::string s;
int n, q;
int ans = 0;

bool check(int i) {
    return s.substr(i, 4) == "1100";
}

inline void prework() {
    ans = 0;
    n = s.size();
    for (int i = 0; i < n - 3; ++i) {
        ans += check(i);
    }
}

inline void query() {
    int loca;
    char v;
    std::cin >> loca >> v;
    --loca;

    for (int i = std::max(0, loca - 3); i <= std::min(loca, n - 4); ++i) {
        ans -= check(i);
    }

    s[loca] = v;
    for (int i = std::max(0, loca - 3); i <= std::min(loca, n - 4); ++i) {
        ans += check(i);
    }

    std::cout << (ans ? "YES\n" : "NO\n");
}

void Main_work() {
    std::cin >> s >> q;
    prework();
    while (q--) {
        query();
    }
}
```

# D. [I Love 1543](https://codeforces.com/contest/2036/problem/D)

不好评价这题目。。。比较方便的方法就是用std::string来拼接出它每一次的路径，然后复制一倍模拟环的情况，暴力判断就完事了。

```cpp
const int N = 1e3;
int n, m;

std::array<std::string, N> map;

std::string s;

inline int check(int d) {
    int res = 0;
    s = "";

    for (int i = d; i < m - 1 - d; ++i) {
        s += map[d][i];
    }
    for (int i = d; i < n - 1 - d; ++i) {
        s += map[i][m - 1 - d];
    }
    for (int i = m - 1 - d; i > d; --i) {
        s += map[n - 1 - d][i];
    }
    for (int i = n - 1 - d; i > d; --i) {
        s += map[i][d];
    }

    s += s;
    for (int i = 0; i < s.size() / 2; ++i) {
        res += (s.substr(i, 4) == "1543");
    }
    return res;
}

void Main_work() {
    std::cin >> n >> m;
    for (int i = 0; i < n; ++i) {
        std::cin >> map[i];
    }

    int ans = 0;
    for (int step = 0; step < std::min(n, m) / 2; ++step) {
        ans += check(step);
    }
    std::cout << ans << '\n';
}
```

# F. [XORificator 3000](https://codeforces.com/contest/2036/problem/F)

    纯粹的位运算性质题，题目给出了一个特殊的模数：2^i，这在位运算中其实意味着抹去后面i位，与右移i位等价。根据异或运算的特殊性质，我们想在异或的集中除去几个数，就直接异或上这个集合。所以我们需要运算：l~r的异或和 ^ l~r中无趣个数的异或和。

    l~r的异或和可以通过1~l-1异或和 ^ 1~r异或和获得。经过打表摸索规律得：1~num的异或和为：num%4 ==0→num  , ==1→1 , ==2→num+1 , ==3→0。由此规律可快速求出l~r的区间异或和。

    对于非有趣数个数，我们可以分为上下两个部分，因为这类数的规则是下半部分和k>>i一样，所以如果该类数个数为奇数个，那么下半部分才不为0，为k。而上半部分就是经典的下半部分相同的时候，l~r抹掉下半部分区间异或和然后左移i位。左右端点公式为(l-1-k)/2^i，(r-k)/2^i，减掉k是为了通过平移将同余k条件转换为同余0条件，也就是整除情况。将所有公式代入求解即为答案。

```cpp
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
```

# G. [Library of Magic](https://codeforces.com/contest/2036/problem/G)

    经典异或性质，x^x=0，所以按理来说只需要二分找到这三个数在哪里，初步想法是先弄到三个数异或之值，然后二分找最大的数c和最小的数a，最后通过三个数的异或值处理出中间的数b。

    但是有a^b^c==0的特殊情况，需要特殊讨论。注意到我们只有三个数a b c，这说明我们组合出的三个数里面，每一位要么三个都不是1，要么有两个数在这一位是1，所以我们把询问的范围从1~n不断缩短，每次除去最高一位，当询问不为0的时候，就说明我们除掉了b和c，此时询问值为a，接下来在a+1~n中求得c就可以拿到答案。

```cpp
ll n;

ll Query(ll l, ll r) {
    std::cout << "xor " << l << ' ' << r << std::endl;
    ll get;
    std::cin >> get;
    return get;
}

ll Find_low(ll x, ll y) {
    ll l = x, r = y;
    ll res = y;
    while (l <= r) {
        ll mid = l + (r - l) / 2;
        if (Query(l, mid)) {
            res = mid;
            r = mid - 1;
        } else {
            l = mid + 1;
        }
    }
    return res;
}

ll Find_high(ll x, ll y) {
    ll l = x, r = y, res = l;
    while (l <= r) {
        ll mid = l + (r - l) / 2;
        if (Query(mid, r)) {
            res = mid;
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }
    return res;
}

void Main_work() {
    std::cin >> n;
    ll all = Query(1, n);
    if (all) {
        ll a = Find_low(1, n), c = Find_high(1, n);
        std::cout << "ans " << a << ' ' << (all ^ a ^ c) << ' ' << c << std::endl;
    } else {
        for (ll i = 63; i >= 0; --i) {
            if ((1ll << i) - 1 > n) continue;
            ll a = Query(1, (1ll << i) - 1);
            if (a) {
                ll c = Find_high(a + 1, n);
                std::cout << "ans " << a << ' ' << (all ^ a ^ c) << ' ' << c << std::endl;
                return;
            }
        }
    }
}
```