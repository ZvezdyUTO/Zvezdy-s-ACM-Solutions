# Balanced

所有者: Zvezdy
标签: 数学, 构造
创建时间: 2024年11月22日 13:28

超级数学构造题，光手玩不知道能不能玩出规律，但是通过设未知数设计方程并化简可以找到关系。我们假设原数组为arr，操作量数组为ans，那么变化后的arr[i]为arr[i]+2*ans[i]+ans[i-1]+ans[i+1]。光看这么一个找不出什么规律，我们可以继续找等量关系，因为最后会变为平衡数组，所以arr[i+1]最终等于arr[i]，也就是说arr[i]+2*ans[i]+ans[i+1]+ans[i-1]=arr[i+1]+2*ans[i+1]+ans[i]+ans[i+2]，分离变量化简后最终获得：arr[i+1]-arr[i]=ans[i-1]+ans[i]+ans[i+1]+ans[i+2]。

我们需要把这个式子进一步化为递推式，从而构造出我们的ans数组，arr[i]=ans[i-1]+ans[i]+ans[i+1]+ans[i+2]-arr[i-1]，记ans[i]+ans[i+1]=b[i]，那么arr[i]=b[i-1]+b[i+1]-arr[i-1]，利用平移，敏锐发现我们构造b[i]需要b[i-2]、arr[i-1]、arr[i-2]，并且构造b[2]的时候我们需要用到b[n]，所以采用1 3 5 7 2 4 6 8的构造顺序，刚好能满足条件，至于位置1可以设置它初始值为0。

接下来就是利用b数组来构造ans数组，b[i]=c[i]+ans[i+1]，易发现我们对b求和之后刚好为ans数组之和的两倍，特判一下为奇数的情况。通过公式加工我们饿可以求出ans[1]的值，接下来利用ans[1]的值不断递推构造，直到构造出整个ans数组为止。

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

const int N = 2e5 + 5;
int n;

std::array<ll, N> arr;

ll sum;
std::array<ll, N> b;

void Get_b() {
    b[1] = b[2] = 0;
    for (int i = 3, j = 1; i != 1; j = i, i = (i + 2 > n ? i + 2 - n : i + 2)) {
        b[i] = b[j] + arr[j % n + 1] - arr[i];  // b[i+1]=b[i-1]+1arr[i]-arr[i-1]
    }
}

std::array<ll, N> ans;

void Get_ans() {
    // 按照公式来说，sum应该等于2*ans，所以需/2
    ans[1] = 0;
    for (int i = 1; i <= n; ++i) {
        ans[1] += b[i];
    }
    if (ans[1] % 2) {
        ans[1] += n;
        for (int i = 1; i <= n; ++i) {
            ++b[i];
        }
    }
    ans[1] /= 2;
    // 减去后只剩ans[1]
    for (int i = 2; i <= n; i += 2) {
        ans[1] -= b[i];
    }

    // 后续继续按照公式递推出元素
    for (int i = 2; i <= n; ++i) {
        ans[i] = b[i - 1] - ans[i - 1];
    }

    // 防止负数出现
    ll min = *std::min_element(ans.begin() + 1, ans.begin() + n + 1);
    for (int i = 1; i <= n; ++i) {
        ans[i] -= min;
    }
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    if (n == 1) {
        std::cout << "0\n";
        return;
    }
    Get_b();
    Get_ans();
    for (int i = 1; i <= n; ++i) {
        std::cout << ans[i] << ' ';
    }
    std::cout << '\n';
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