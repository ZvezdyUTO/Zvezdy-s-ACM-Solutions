# Selection Sort

所有者: Zvezdy
标签: 思维
创建时间: 2025年3月22日 11:00

纯粹的分讨题，其实是对于不同情况讨论能力的考验。对于这类情况讨论的题，可以从不同的角度进行状况讨论，避免状况遗漏。首先是只能排序两次，就是选头尾两段区间进行排序，一开始看的时候只想到了选两个不相交区间，但是如果单纯从选择区间来看，应该有几种情况：相交、不相交、相切，仔细验证以后可以发现这几种情况都是有可能成立的，接下来就是对我们的分类讨论进行验证并筛选出最优情况。

这里有另外一个思维上的技巧：无论我们的中间过程怎么样，我们的结果一定是唯一的：一个非递减数组。那我们完全可以创造一个结果，然后在构造中途不停与结果比较，其次注意堆的用法，堆自带排序，还可以把元素pop出去，如此一来当前堆的大小也可以作为一个参考信息。

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

int pow(int num) { return num * num; }

void Main_work() {
    int n;
    std::cin >> n;
    std::vector<int> arr(n);
    for (int i = 0; i < n; ++i) std::cin >> arr[i];
    std::vector<int> fin = arr;
    std::sort(fin.begin(), fin.end());

    int ans = n * n;

    std::priority_queue<int> pq;
    for (int i = 0, cur = 0, lst = 0; i < n; ++i) {
        pq.push(-arr[i]);
        while (pq.size() && -pq.top() == fin[cur]) pq.pop(), ++cur;
        if (pq.size()) {
            ans = std::min(ans, pow(i + 1) + pow(n - i - 1 + pq.size()));
            lst = i + 2;
        } else {
            ans = std::min(ans, pow(lst) + pow(n - i - 1));
        }
    }

    pq = std::priority_queue<int>{};
    for (int i = n - 1, cur = n - 1, lst = n; i >= 0; --i) {
        pq.push(arr[i]);
        while (pq.size() && pq.top() == fin[cur]) pq.pop(), --cur;
        if (pq.size()) {
            ans = std::min(ans, pow(n - i) + pow(i + pq.size()));
            lst = i - 1;
        } else {
            ans = std::min(ans, pow(n - lst) + pow(i + 1));
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
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```