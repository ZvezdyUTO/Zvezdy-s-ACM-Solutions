# Codeforces Round 987 (Div. 2)

所有者: Zvezdy
标签: 二叉树, 互动题, 位运算, 图论, 思维, 总比赛, 数论, 构造, 树状数组, 贪心
创建时间: 2024年11月16日 20:28

# [Penchick and Modern Monument](https://codeforces.com/contest/2031/problem/A)

降序数组中删元素变升序，那最好就只能留某种元素了，留的自然是数量最多的元素。

```cpp
const int N = 50 + 5;
int n;

std::array<int, N> arr;
std::array<int, N> freq;

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    std::fill(freq.begin() + 1, freq.begin() + n + 1, 0);
    for (int i = 1; i <= n; ++i) {
        ++freq[arr[i]];
    }
    std::cout << n - *std::max_element(freq.begin() + 1, freq.begin() + n + 1) << '\n';
}
```

# [Penchick and Satay Sticks](https://codeforces.com/contest/2031/problem/B)

发现·规则可逆，于是逆向思维一下，一个正序排列，按它的规则能怎么变换？当然是只能交换相邻元素，然后就不能交换第二次了。简单开个ord数组判断一下，它原位置和新位置的差值，看看是否符合要求。

```cpp
const int N = 2e5 + 5;
int n;

std::array<int, N> arr;

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    for (int i = 1; i <= n; ++i) {
        if (abs(arr[i] - i) > 1) {
            std::cout << "NO\n";
            return;
        }
    }
    std::cout << "YES\n";
}
```

# [Penchick and BBQ Buns](https://codeforces.com/contest/2031/problem/C)

偶数情况下应该秒解吧，就是1 1 2 2 3 3 4 4…这样能保证所有差值为1^2，但是如果是奇数的话就有些麻烦，注意到奇数情况下如果我们按规则放三个相同元素，那么剩下的就有可能变回偶数情况。放的三个元素位置为a, b, c，关系必须满足：(b-a)^2+(c-b)^2是完全平方数，易发现这是勾股定理，最小的勾股数自然是3 4 5。但是只使用这个我们构造出的数组长度为26，不是奇数，并且右半部分空位的数为奇数个，此时我们只要在23和27的位置放两个相同元素，就能最优地填补出符合要求的初始框架，任何大于等于27的奇数大小数组，都可以依赖此框架，在空白部分像偶数长度数组那样填充。

```cpp
const int N = 2e5 + 5;
int n;

void Main_work() {
    std::cin >> n;
    if (n % 2) {
        if (n < 27) {
            std::cout << -1 << '\n';
            return;
        }

        std::vector<int> ans(n + 1, -1);
        ans[1] = 1;
        ans[10] = 1;
        ans[26] = 1;
        ans[23] = 2;
        ans[27] = 2;

        for (int i = 1, get = 0, cur = 3; i <= n; ++i) {
            if (ans[i] != -1) {
                continue;
            }

            ans[i] = cur;
            ++get;
            if (get == 2) {
                ++cur;
                get = 0;
            }
        }

        for (int i = 1; i <= n; ++i) {
            std::cout << ans[i] << ' ';
        }
        std::cout << '\n';
        return;
    }

    for (int i = 1, cur = 1; i <= n; i += 2, ++cur) {
        std::cout << cur << " " << cur << " ";
    }
    std::cout << '\n';
}
```

# [Penchick and Desert Rabbit](https://codeforces.com/contest/2031/problem/D)

题意是往右只能跳更低的，往左能跳更高的，首先敏锐地发现它们的单调性：假如不能往右跳，那么能让一个数变大的可能性就是它往左跳到一个更高的，而且因为它的跳跃路径是一个从左到右严格递减的子序列，那么能够保证，越往右一定就是越优的。因为如果它本身的值很大，那么它就是优的，如果它的值很小，那么它就会尽可能地享有左边所有的大值。

分这些不同的情况讨论出来以后，我们可以发现它们背后的一致性。那如果我们让所有数都能跳到最右处，再从最右处往左跳一定是优的，这里有第二个单调性：一个数越大，它往右跳的距离一定越远。而一个数的变大过程只能有两种可能，一是它不往右跳，只往左跳收货最大值，二是它现往左跳了一个最大值，然后借助这个最大值往右跳最远，以此蹦到最大值，一个数往左能跳到的最高处我们是可以从左到右扫描一遍得出的。

最后就是如何求它们从左往右能跳到的最远处，我们这里依赖两个指标：1.它只能往比自己低的地方跳，2.它只能往右边跳，如果它不只能往右边跳，这种动态维护区间最值然后单点插入我们可以使用BIT实现。

```cpp
const int N = 5e5 + 5;
int n;

std::array<int, N> arr;

std::array<int, N> ans;
std::array<int, N> BIT;
void add(int i, int rank) {
    while (i <= n) {
        BIT[i] = std::max(BIT[i], rank);
        i += i & -i;
    }
}
int get_max(int i) {
    int res = -1;
    while (i > 0) {
        res = std::max(res, BIT[i]);
        i -= i & -i;
    }
    return res;
}

inline void scan() {
    for (int i = 1, max = arr[1]; i <= n; ++i) {
        max = std::max(max, arr[i]);
        ans[i] = max;
    }
    std::fill(BIT.begin(), BIT.begin() + n + 1, 0);
    for (int i = n, far = n, min = arr[n]; i >= 1; --i) {
        add(arr[i], i);
        int cur = get_max(ans[i] - 1);
        ans[i] = std::max(ans[i], ans[cur]);
    }
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    scan();
    for (int i = 1; i <= n; ++i) {
        std::cout << ans[i] << ' ';
    }
    std::cout << '\n';
}
```

# [Penchick and Chloe's Trees](https://codeforces.com/contest/2031/problem/E)

首先运用了一个性质，一棵完全二叉树，我们是能通过它的深度推导出它的叶子数量的，数量为2^(deep-1)，与此同时，我们是可以通过逆向思维，从叶子数量推断出完全二叉树深度的，尤其是当我们可以删叶子的时候，我们是可推导出最小深度。所以我们从叶子开始往上面递推，对于每个节点，收集它子树的所有深度，然后把深度转换为该深度所需叶子数，再拿这些叶子数之和转换为当前节点所需满二叉树深度。

这里有一个实现的trick，因为我们要枚举的是2的次幂，所以绝对会爆精度，得拿高精度来实现，而正好我们枚举的是2的次幂，因此可以直接高精度模拟2进制运算，每个位置就是2^?好了。一路加上去，然后拿这个数组计算我们所需的二叉树深度。注意我们的二进制运算数组其实是可以复用的，不用每次都清零。

```cpp
const int N = 1e6 + 5;
int n;

std::array<std::vector<int>, N> edge;

std::array<int, N> calculate;

int dp(int now) {
    int max_deep = 0;

    std::vector<int> list;

    // 记录深度，寻找最大深度
    for (auto to : edge[now]) {
        int sub_deep = dp(to);
        list.push_back(sub_deep - 1);
        max_deep = std::max(sub_deep, max_deep);
    }

    // 用二进制模拟大整数加法，注意数组是复用的
    for (auto pow : list) {
        while (calculate[pow] == now) {
            calculate[pow++] = 0;
        }
        calculate[pow] = now;
        max_deep = std::max(max_deep, pow);
    }

    // 如果最高位被使用，并且前面还有未分配的低位，考虑进位
    // 因为这说明至少需要更多叶子才能装下该树
    if (calculate[max_deep] == now) {
        for (int i = 0; i < max_deep; ++i) {
            if (calculate[i] == now) {
                ++max_deep;
                break;
            }
        }
    }
    return max_deep + 1;
}

void Main_work() {
    std::cin >> n;

    for (int i = 0; i <= n; ++i) {
        edge[i].clear();
        calculate[i] = 0;
    }

    for (int v = 2, u; v <= n; ++v) {
        std::cin >> u;
        edge[u].push_back(v);
    }

    std::cout << dp(1) - 1 << '\n';
}
```

# [Penchick and Even Medians](https://codeforces.com/contest/2031/problem/F)

如果我们把所有元素一起查询，会得到本排列的两个中位数，但如果我们把查询中任意两个元素挖掉，会产生不同情况：1.我们挖掉了两个中位数，那么会查出来mid-1和mid+2。2,如果我们挖掉了其中一个中位数，就看挖掉的另一个部分在哪里，假如我们挖掉的是左边的中位数，并挖掉了排列左半边的数，那么我们会查询到mid+1和mid+2，如果我们挖掉的另一个是右半边的，那么我们会查到mid-1和mid+2，类比一下右半边，我们就可以得出基本的讨论情况，刚好挖到两个中位数的话就特判一下交了，挖到一个左半边一个右半边的无关数情况我们忽略不计。

这样子从1~n中两个两个挖，就会得到这么一些数对：包含两个半边无关数和一个半边无关数一个中位数的数对们按来源分为左半边、右半边两组，我们需要从这些数对中找到包含中位数的那些对。这就变成一个经典的二分查找问题：老鼠试毒。这个问题的标准解法是利用二进制位来分组，把二进制中每一位为1的元素分为一组，每次查询看我们所需的答案是否在该位中，最后把所有符合要求的位拼起来就是我们的答案。

由这个思路我们查找到了中位数存在的2个数对，此时4次询问内暴力枚举中位数究竟在哪里就好。

```cpp
int n, k;

std::vector<int> lower, upper;
int lower_mid, upper_mid;

std::array<int, 2> take_list(std::vector<int>& list) {
    std::cout << "? " << list.size() << ' ';
    for (auto it : list) {
        std::cout << it << ' ';
    }
    std::cout << std::endl;

    int m1, m2;
    std::cin >> m1 >> m2;
    return {m1, m2};
}

std::array<int, 2> query(int x, int y) {
    std::vector<int> list;
    for (int i = 1; i <= n; ++i) {
        if (i != x && i != y) {
            list.push_back(i);
        }
    }
    return take_list(list);
}

// 第一次分类，把所有2元配对查询出来
inline bool prework() {
    lower.clear(), upper.clear();
    lower_mid = upper_mid = -1;

    for (int i = 1; i <= k; ++i) {
        auto [m1, m2] = query(2 * i - 1, 2 * i);

        if (m1 == k + 1 && m2 == k + 2) {  // 上元素
            lower.push_back(i);
        } else if (m1 == k - 1 && m2 == k) {  // 下元素
            upper.push_back(i);
        } else {  // 绝对包含目标元素
            bool has_lower = (m1 == k - 1);
            bool has_upper = (m2 == k + 2);
            if (has_lower && has_upper) {
                std::cout << "! " << 2 * i - 1 << ' ' << 2 * i << std::endl;
                return true;
            } else if (has_lower) {
                lower_mid = i;
            } else if (has_upper) {
                upper_mid = i;
            }
        }
    }
    return false;
}

// 如果没找到，那么精准查找出配对元素
inline void exact_check() {
    int lower_index = 0, upper_index = 0;
    for (int bit = 0; bit < 10; ++bit) {
        std::vector<int> list;
        for (int i = 0; i < lower.size(); ++i) {
            // 枚举二进制位下为？的子集
            // 把这些子集按照二进制位组合起来，就是答案
            if (i & (1 << bit)) continue;
            list.push_back(2 * lower[i] - 1);
            list.push_back(2 * lower[i]);
            list.push_back(2 * upper[i] - 1);
            list.push_back(2 * upper[i]);
        }
        auto [m1, m2] = take_list(list);
        if (m1 < k) lower_index |= (1 << bit); // 被删除的元素中有左元素
        if (m2 > k + 1) upper_index |= (1 << bit); //被删除的元素中有右元素
    }
    if (lower_mid == -1) lower_mid = lower[lower_index];
    if (upper_mid == -1) upper_mid = upper[upper_index];
}

// 确定两个中位数所在配对位置，暴力匹配
inline void solve() {
    for (int i = 2 * lower_mid - 1; i <= 2 * lower_mid; ++i) {
        for (int j = 2 * upper_mid - 1; j <= 2 * upper_mid; ++j) {
            auto [m1, m2] = query(i, j);
            if (m1 == k - 1 && m2 == k + 2) {
                std::cout << "! " << i << ' ' << j << std::endl;
                return;
            }
        }
    }
}

void Main_work() {
    std::cin >> n;
    k = n / 2;
    if (prework()) return;
    if (lower_mid == -1 || upper_mid == -1) exact_check();
    solve();
}
```