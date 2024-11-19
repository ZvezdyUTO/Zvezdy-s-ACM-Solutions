# Codeforces Round 986 (Div. 2)

所有者: Zvezdy
标签: 二分答案, 位运算, 动态规划, 图论, 数学, 暴力枚举, 树形DP, 概率论, 贪心, 预处理
创建时间: 2024年11月19日 16:19

# [Alice's Adventures in ''Chess''](https://codeforces.com/contest/2028/problem/A)

注意到题目数据量非常非常小，地图总大小都不超过10，我们直接暴力模拟它跑100遍，肯定能把格子踩满，此时踩不到也是找不到了。

```cpp
int n, a, b;
std::string s;

std::array<int, 2> loca;

bool check() {
    return (loca[0] == a && loca[1] == b);
}

void move(char op) {
    if (op == 'N') {
        ++loca[1];
    } else if (op == 'E') {
        ++loca[0];
    } else if (op == 'S') {
        --loca[1];
    } else {
        --loca[0];
    }
}

void Main_work() {
    std::cin >> n >> a >> b;
    std::cin >> s;
    loca = {0, 0};
    for (int i = 0; i <= 100; ++i) {
        for (auto ch : s) {
            if (check()) {
                std::cout << "YES\n";
                return;
            }
            move(ch);
        }
    }
    std::cout << "NO\n";
}
```

# [Alice's Adventures in Permuting](https://codeforces.com/contest/2028/problem/B)

很疯狂的公式推导还有可能性讨论。在初步手玩以后发现，只要b不为0，一定是可以构造出来的，但是b为0也不一定完全构造不出来，要看c和n的大小，如果c大于等于n，那么每个都可以变化完以后进行填充，代价为k，c=n-2是极限情况，此时构造出来以后会有一个不用变化，如果再多一个就会永远被卡住不能构造。

在b不为0的时候我们需要计算我们能够省略的变化次数，如果c很大，大于等于n，那么就和之前那种情况一样，要变化n次，当c不大于n的时候，我们肯定会在某一时刻需要用到c，此时会省略一次变化。对于后面的情况，直观来看就是我们每个数之间只要能用后面b-1个数填上，我们就能省略一次变化，经过公式化简，这个次数就是(n-c-1)/b次，分类讨论过后模拟出来即可。

```cpp
ll n, b, c;

void Main_work() {
    std::cin >> n >> b >> c;
    if (b == 0) {
        if (c >= n) {
            std::cout << n << '\n';
        } else if (c >= n - 2) {
            std::cout << n - 1 << '\n';
        } else {
            std::cout << -1 << '\n';
        }
    } else {
        if (c >= n) {
            std::cout << n << '\n';
        } else {
            std::cout << n - 1 - (n - c - 1) / b << '\n';
        }
    }
}
```

# [Alice's Adventures in Cutting Cake](https://codeforces.com/contest/2028/problem/C)

题目蛋糕是连续的，我们可以考虑枚举讨论从哪里开始切到哪里作为爱丽丝的获得部分，但是这样讨论的代价是n^2，已知 l+len=r，所以我们可以考虑讨论l和len，因为len具有单调性，可以使用二分答案求。

预处理出从1~i最多能切多少块给矮人的蛋糕，以及从j~n最多能切多少块给矮人的蛋糕，对每次查询，从左到右遍历数组枚举起点，使用std::upper_bound查找终点，并判断能否分这么长的蛋糕给爱丽丝。

```cpp
const int N = 2e5 + 5;
int n, m, v;

std::array<ll, N> arr;

std::array<ll, N> prefix;
std::array<int, N> L, R;

inline bool prework() {
    for (int i = 1; i <= n; ++i) {
        prefix[i] = arr[i] + prefix[i - 1];
    }

    for (ll i = 1, tmp = 0; i <= n; ++i) {
        L[i] = L[i - 1];
        tmp += arr[i];
        if (tmp >= v) {
            tmp = 0;
            ++L[i];
        }
    }
    R[n + 1] = 0;
    for (ll i = n, tmp = 0; i >= 1; --i) {
        R[i] = R[i + 1];
        tmp += arr[i];
        if (tmp >= v) {
            tmp = 0;
            ++R[i];
        }
    }

    return (L[n] >= m || R[1] >= m);
}

bool check(ll size) {
    bool res = false;
    for (int i = 1; i <= n && !res; ++i) {
        if (prefix[i] >= size) {
            auto find = std::upper_bound(prefix.begin() + 1, prefix.begin() + i + 1, prefix[i] - size) - prefix.begin();
            if (find != i + 1) {
                res = (L[find - 1] + R[i + 1] >= m);
            }
        }
    }
    return res;
}

inline ll binary_answer() {
    ll l = 0, r = prefix[n];
    while (l < r) {
        ll mid = l + (r - l + 1) / 2;
        if (check(mid)) {
            l = mid;
        } else {
            r = mid - 1;
        }
    }
    return l;
}

void Main_work() {
    std::cin >> n >> m >> v;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    if (!prework()) {
        std::cout << -1 << '\n';
        return;
    }
    std::cout << binary_answer() << '\n';
}
```

# [Alice's Adventures in Cards](https://codeforces.com/contest/2028/problem/D)

特殊限制：alice不能让自己的牌变小，凭借这一点就可以使用动态规划求解，因为没有后效性。设dp表为：第i个数可以被alic在xxx手中用?牌换到。接下来从左到右开始转移。一位一位看爱丽丝能从谁的手里面换到这张牌，一旦我们拥有这张牌，我们就可以继续进行转移，已知我们拿到喜好值更高的牌一定是最优的，所以我们依次从左到右寻找能拿到的喜好值最大牌。然后在看我们目前拥有最大的喜好牌能换到哪些牌。

把这些全部记录在dp表里面后，我们就可以用dp表进行跳跃，从n到1提取答案。这个dp转移方式就是一张图，因为该图每个点入度唯一，所以保证过程可逆。

```cpp
const int N = 2e5 + 5;
int n;

std::array<std::array<int, N>, 3> arr;

std::array<std::array<int, N>, 3> rank;
std::array<int, 3> max;
std::array<std::array<int, 2>, N> jump;

inline void prework() {
    for (int i = 0; i < 3; ++i) {
        for (int j = 1; j <= n; ++j) {
            rank[i][arr[i][j]] = j;
        }
    }
    max = {arr[0][1], arr[1][1], arr[2][1]};  // 喜好最大值
    std::fill(jump.begin() + 1, jump.begin() + n + 1, std::array<int, 2>{-1, -1});
    jump[1] = {0, 0};

    for (int j = 2; j <= n; ++j) {
        for (int i = 0; i < 3; ++i) {
            // 如果有能换的，就记录一下
            if (max[i] > arr[i][j]) {
                jump[j] = {i, rank[i][max[i]]};
            }
        }
        // 换了以后每一位就不用回退了
        if (jump[j][0] != -1) {
            for (int i = 0; i < 3; ++i) {
                max[i] = std::max(max[i], arr[i][j]);
            }
        }
    }
}

std::vector<std::array<int, 2>> ans;

inline void check() {
    if (jump[n][0] == -1) {
        std::cout << "NO\n";
        return;
    }

    ans.clear();
    for (int i = n; i > 1;) {
        auto [j, x] = jump[i];
        ans.push_back({j, i});
        i = x;
    }
    std::reverse(ans.begin(), ans.end());
    std::cout << "YES\n";
    std::cout << ans.size() << '\n';
    for (auto [x, y] : ans) {
        std::cout << "qkj"[x] << ' ' << y << '\n';
    }
}

void Main_work() {
    std::cin >> n;
    for (int i = 0; i < 3; ++i) {
        for (int j = 1; j <= n; ++j) {
            std::cin >> arr[i][j];
        }
    }
    prework();
    check();
}
```

# [Alice's Adventures in the Rabbit Hole](https://codeforces.com/contest/2028/problem/E)

从base case讨论起：假如只有一条链，那么我们设链长为d，有d+1个点，我们可以列出p(i)=1/2 (p(i+1)+p(i-1))，显然是线性递归方程组，通解为p(i)=a*i+b，代入p(1)=1和p(d+1)=0可以解得p(i)=1-(i-1)/d。

现在来看皇后和爱丽丝的策略，爱丽丝肯定是一直往根节点跑，而皇后则是把爱丽丝往目前最浅的叶子拽。对于题目中给出的树，我们可以把这棵树拆分为一条从根到最浅叶节点的树和若干子树，然后对于子树仍是这么拆分，最后我们发现无论身在何处，都有一条固定的路线，只不过在交叉处皇后不会把爱丽丝往之前那个不优的节点拽，但是大体上我们依然可以把这个过程看作是在链上进行，所以我们需要把前面我们推导出的公式改为只依赖父节点概率和目前位置离最浅叶节点距离的的递推式。设方程为k*p(fa)=p(now)，代入之前的公式解得p(now)=deep(now)/(deep(now)+1)=p(fa)，其中deep是由原来链条长度和节点位置转换为节点到叶子深度得来的。

```cpp
const int N = 2e5 + 5;
const int MODE = 998244353;
int n;

inline ll inv(ll base) {
    int tmp = MODE - 2;
    ll res = 1;
    while (tmp) {
        if (tmp % 2) {
            res = (res * base) % MODE;
        }
        base = (base * base) % MODE;
        tmp /= 2;
    }
    return res;
}

std::array<std::vector<int>, N> edge;

std::array<ll, N> deep;

int prework(int now, int par) {
    int res = 0x7fffffff;
    for (auto to : edge[now]) {
        if (to != par) {
            res = std::min(res, prework(to, now));
        }
    }
    if (res > n) res = 0;
    deep[now] = res;
    return res + 1;
}

std::array<ll, N> p;

void dp(int now, int par) {
    p[now] = p[par] * deep[now] % MODE * inv(deep[now] + 1ll) % MODE;
    for (auto to : edge[now]) {
        if (to != par) {
            dp(to, now);
        }
    }
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        edge[i].clear();
    }
    for (int i = 1, u, v; i < n; ++i) {
        std::cin >> u >> v;
        edge[u].push_back(v);
        edge[v].push_back(u);
    }
    prework(1, 0);
    p[1] = 1;
    for (auto start : edge[1]) {
        dp(start, 1);
    }
    for (int i = 1; i <= n; ++i) {
        std::cout << p[i] << ' ';
    }
    std::cout << '\n';
}
```

# [Alice's Adventures in Addition](https://codeforces.com/contest/2028/problem/F)

各种卡，疯狂卡，在这类包含加法运算并判断是否能到达某个点的题目中使用std::bitset进行状态转移应该是一个经典trick了。仔细分析这题的各种不同可能性，可以找到正确的转移方式。

首先我们一定是一格一格统计，我们走完第i格的时候能拼凑出什么状态。设上一个位置能到达的结果为一个bool集，称为cur，当前位置能到达的bool集称为next。如果只有加法，那就是用std::bitset左移?位或上去→next|=cur<<x。不过我们还有乘法，考虑一下乘法会给我们的运算带来什么影响，因为运算的优先级，我们把一连串相乘的数看作一个连通块，然后这些联通块被我们用加号拼起来，那么在一种可能性中，我们的算式应该是____+___+__+_+__+______… 这么观察下来，其实我们使用的还是std::bitset模拟加法运算进行转移，因为乘法部分我们可以把它们看作一个完整的数字。此时我们需要讨论上一个加号在什么位置，然后把上一个加号后面的数全部乘起来进行加法转移，这么看我们的时间复杂度可能是n^2  *m，但是根据乘法运算的增长速度，易发现在log次以内我们累计的乘数就会爆掉上限，所以我们只需要前面的log个状态。

拿std::bitset进行状态存储和转移，用std::deque<std::pair<int, std::bitset<>>>作滚动数组，严格保持在log的大小，就能卡掉这题的空间限制，注意std::deque是可以使用for auto按顺序访问的。

```cpp
constexpr int N = 2e5 + 5;
constexpr int M = 1e4 + 5;
constexpr int LOG = std::__lg(M);
int n, m;

std::bitset<M> cur, prefix, zero;
std::bitset<M> next;
std::deque<std::pair<int, std::bitset<M>>> save;

inline bool dp() {
    cur = 1;  // f[0][0]=1
    prefix = 1;
    zero = 0;
    save.clear();

    for (int i = 1, x; i <= n; ++i) {
        std::cin >> x;
        next = zero;
        if (x == 0) {
            next |= prefix;
            zero |= next;
            save.push_front({0, cur});
        } else if (x == 1) {
            next |= cur | (cur << 1);
        } else {
            int now = 1;
            save.push_front(std::make_pair(x, cur));
            for (auto [value, state] : save) {
                now *= value;
                if (now > m) {
                    break;
                }
                next |= state << now;
            }
        }
        prefix |= next;
        cur = next;
        if (save.size() > LOG) {
            save.pop_back();
        }
    }
    return cur[m];
}

void Main_work() {
    std::cin >> n >> m;
    std::cout << (dp() ? "YES\n" : "NO\n");
}
```