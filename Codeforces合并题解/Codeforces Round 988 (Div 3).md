# Codeforces Round 988 (Div. 3)

所有者: Zvezdy
标签: 二分答案, 互动题, 优先队列, 容斥原理, 扫描线, 数论, 构造, 离散化, 组合数学, 莫比乌斯函数, 贪心
创建时间: 2024年11月18日 15:47

# [Twice](https://codeforces.com/contest/2037/problem/A)

每个数出现两次就加一分，拿std::map做桶统计词频然后for auto遍历累加答案。

```cpp
const int N = 20;
int n;

void Main_work() {
    std::cin >> n;
    std::map<int, int> freq;
    for (int i = 1, num; i <= n; ++i) {
        std::cin >> num;
        ++freq[num];
    }

    int ans = 0;
    for (auto [_, i] : freq) {
        ans += i / 2;
    }
    std::cout << ans << '\n';
}
```

# [Intercepted Inputs](https://codeforces.com/contest/2037/problem/B)

k-2就是矩阵元素的个数，打词频表后暴力分解因数看里面有没有两个元素a和b能满足a*b=k-2这个条件，找到了就直接输出。

```cpp
const int N = 2e5 + 5;
int n;

std::array<int, N> arr;

void Main_work() {
    std::cin >> n;
    std::map<int, int> mp;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
        ++mp[arr[i]];
    }
    int size = n - 2;
    for (int i = 1; i * i <= size; ++i) {
        if (size % i == 0) {
            if (mp[size / i] && mp[i]) {
                std::cout << i << ' ' << size / i << '\n';
                return;
            }
        }
    }
}
```

# [Superultra's Favorite Permutation](https://codeforces.com/contest/2037/problem/C)

神秘构造，因为奇数+奇数 和 偶数+偶数一定为偶数，并且偶数除了2以外都是合数，那么我们找到第一个奇数偶数之和为合数的数对就可以开始疯狂构造了，这个数对就是4, 5。搞出一个{1, 3, 5, 4, 2}之后拿std::deque简单完成这个过程。

```cpp
const int N = 2e5 + 5;
int n;

void Main_work() {
    std::cin >> n;
    if (n < 5) {
        std::cout << -1 << '\n';
        return;
    }
    std::deque<int> ans = {1, 3, 5, 4, 2};
    for (int i = 6, it = 0; i <= n; ++i, it ^= 1) {
        if (!it) {
            ans.push_back(i);
        } else {
            ans.push_front(i);
        }
    }
    while (ans.size()) {
        std::cout << ans.front() << ' ';
        ans.pop_front();
    }
    std::cout << '\n';
}
```

# [Sharky Surfing](https://codeforces.com/contest/2037/problem/D)

注意道具的作用是增强，并且区间跳跃的条件也比较苛刻：如果l~r是障碍物，那么我们就得从l-1跳到r+1，与此同时还要特判l==r的情况。转换思路，我们可以捡所有道具，但只统计使用的次数。贪心策略很简单，遇到障碍物的时候就优先用手头上数值大的道具，直到用完道具或者能够跳过去，使用优先队列贪心完成操作。然后地图离散化就用std::map中嵌套std::vector模拟。

```cpp
const int N = 2e5 + 5;
int n, m, l;

std::map<int, std::vector<int>> map;

inline int calculate() {
    int ans = 0;

    std::priority_queue<int> pq;
    int jumap = 1, last = -1;

    for (auto [loca, it] : map) {
        // 道具
        if (it[0] != -1) {
            for (auto i : it) {
                pq.push(i);
            }
        } else {
            // 障碍物
            if (last == -1 && it.size() != 2) {
                last = loca;
            } else {
                int dist = (last == -1 ? 2 : loca - last + 2);
                last = -1;

                // 开始使用道具
                while (pq.size() && jumap < dist) {
                    jumap += pq.top();
                    pq.pop();
                    ++ans;
                }

                if (jumap < dist) {
                    return -1;
                }
            }
        }
    }
    return ans;
}

void Main_work() {
    std::cin >> n >> m >> l;
    map.clear();
    for (int i = 1, l, r; i <= n; ++i) {
        std::cin >> l >> r;
        map[l].push_back(-1);
        map[r].push_back(-1);
    }
    for (int i = 1, loca, up; i <= m; ++i) {
        std::cin >> loca >> up;
        map[loca].push_back(up);
    }

    std::cout << calculate() << '\n';
}
```

# [Kachina's Favorite Binary String](https://codeforces.com/contest/2037/problem/E)

经典dp题爆改互动题，我们从末端两个元素开始问起，也就是从base case开始考虑。如果问出来是0，那么就会有几种情况：11  10  00，然后我们拓展可能性，问n-2  n，得到的结果如果为0的话，那就是111 110 100 000，一直反复问，直到回答不为0，那么我们就直到一定是我们新纳入的元素是一个0，而回答就是后续1的个数，按照之前给出可能性合集来判断，就是0111000这种状态。

现在继续拓展这种可能性，我们每次都往前拓展一个元素，当我们拓展到0的时候，我们问出的值就是：上一次问到0的时候所有的答案值+后半部分所有1的个数之和。我们稍微进行公式加工，就可以获得我们新拓展部分的1的个数之和，据此可以构造出我们的串。注意如果我们从头到尾都没问到过任何非0的答案，那一定是IMPOSSIBLE。

```cpp
int n;

int query(int l, int r) {
    std::cout << "? " << l << ' ' << r << std::endl;
    int res;
    std::cin >> res;
    return res;
}

void Main_work() {
    std::cin >> n;
    std::vector<int> ans(n + 1, 0);

    int sum = 0;
    ll sums = 0;
    for (int l = n - 1; l >= 1; --l) {
        int res = query(l, n);
        if (res - sums != 0) {
            int num = res - sums - sum;
            int i = l + 1;
            for (; i <= l + num; ++i) {
                ans[i] = 1;
            }
            sum = res - sums;
            sums = res;
        } else if (res) {
            ans[l] = 1;
        }
    }

    if (!sum) {
        std::cout << "! IMPOSSIBLE" << std::endl;
    } else {
        std::cout << "! ";
        for (int i = 1; i <= n; ++i) {
            std::cout << ans[i];
        }
        std::cout << std::endl;
    }
}
```

# [Ardent Flames](https://codeforces.com/contest/2037/problem/F)

除非挨个枚举地点并对比，不然很难判断在何处能用最少次数干掉k个敌人。当求解非常困难的时候，就想想能不能转化为求证，观察发现这个所需攻击次数具有明显的单调性，于是考虑二分答案进行枚举验证。

我们对攻击次数进行枚举，对于每一个敌人，影响它所需攻击次数的是我们选择的地点，离敌人越近，所需攻击次数越少，所以我们可以使用公式加工计算出在actn次攻击内消灭每个敌人的合法范围，这些范围就是一条一条不同的线段，只要找得到k条不同线段的交汇处，就能解决这道问题。使用std::map离散化前缀和跑扫描线处理。

除了正难则反，还有不好求解就求证，这两个转换思维都挺重要的，这题的关键在于发现单调性，或者说两段性，而这就是二分答案的关键。

```cpp
const int N = 1e5 + 5;
int n, atk, k;

std::array<int, N> hp, pos;

std::map<int, int> ranges;

bool check(int actn) {
    ranges.clear();
    for (int i = 1; i <= n; ++i) {
        // atk-dist=(hp[i]+actn-1)/actn
        int dist = atk - (hp[i] + actn - 1) / actn;
        if (dist >= 0) {
            ++ranges[pos[i] - dist];
            --ranges[pos[i] + dist + 1];
        }
    }
    int cur = 0;
    for (auto &[_, it] : ranges) {
        cur += it;
        if (cur >= k) {
            return true;
        }
    }
    return false;
}

inline ll binary_answer() {
    int l = 1, r = 1e9, ans = -1;
    while (l <= r) {
        int mid = (l + r) / 2;
        if (check(mid)) {
            ans = mid;
            r = mid - 1;
        } else {
            l = mid + 1;
        }
    }
    return ans;
}

void Main_work() {
    std::cin >> n >> atk >> k;
    for (int i = 1; i <= n; ++i) {
        std::cin >> hp[i];
    }
    for (int i = 1; i <= n; ++i) {
        std::cin >> pos[i];
    }
    // 发现击败敌人次数具有单调性
    // 我们如果想在q次攻击中击败一个敌人
    // 就会产生一个距离
    std::cout << binary_answer() << '\n';
}
```

# [Natlan Exploring](https://codeforces.com/contest/2037/problem/G)

题目给出了很明确的提示：所有数不大于1e6，那么这一题就可以分解因数求解，并且是按照值来进行映射转移，当我们计算f[i]的时候，我们选择从它所有因数中所包含的路径之和进行转移，并在求出值以后更新回他所有因数中。

不过这样就会有个严重的问题：如果一个数中出现多个重复的嵌套因子，那么按照我们的这个方法就会被重复计算，据此我们需要使用唯一分解定理来进行修正，而莫比乌斯函数正好契合了容斥这个过程。莫比乌斯函数的值是(-1)^k（k是一个数中不同质因数个数），而如果一个数某个质因数的指数大于1，那么也是重复计算，需要直接剔除。

```cpp
const int N = 1e5 + 5;
const int M = 1e6 + 5;
const int MODE = 998244353;
int n;

std::array<int, N> arr;

std::array<int, M> mob;
std::array<std::vector<int>, M> divs;

inline void prework() {
    // 求莫比乌斯函数
    mob.fill(1);
    for (int i = 2; i < M; ++i) {
        for (int j = 2 * i; j < N; j += i) {
            mob[j] -= mob[i];
        }
    }

    // nlog分解因数
    for (int i = 2; i < M; ++i) {
        for (int j = i; j < N; j += i) {
            divs[j].push_back(i);
        }
    }
}

std::array<ll, M> sum;
std::array<ll, N> f;

inline ll dp() {
    for (int i = 1; i <= n; ++i) {
        if (i == 1) {
            f[i] = 1;
        } else {
            // 遍历所有因子，并使用莫比乌斯函数进行容斥
            for (auto num : divs[arr[i]]) {
                f[i] = (f[i] + mob[num] * sum[num]) % MODE;
            }
        }
        for (auto num : divs[arr[i]]) {
            sum[num] = (sum[num] + f[i]) % MODE;
        }
    }
    return f[n];
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    prework();
    std::cout << dp();
}
```