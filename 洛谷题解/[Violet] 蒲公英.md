# [Violet] 蒲公英

所有者: Zvezdy
标签: 分块

暴力分块题，利用分块的根号性质，除了可以在时间上进行优化以外，也可以在空间上开出更多信息，最高可支持到n^3/2大小。例如这题，我们就可以预处理出任意两个块之间的众数，还有前i个块中每个数的数量，复杂度都是n^3/2大小。有了这些辅助数据，我们就可以轻松求出我们的答案。注意词频表的计算方法，采取按块统计的方式可以有效避免出错。

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
#define debug(x) std::cout << #x << " = " << x << std::endl

const int N = 4e4 + 5;
const int M = 5e4 + 5;
const int BLOCK = 2e2 + 5;
int n, q;

std::array<int, N> arr;

int nn;
std::array<int, N> rank;

inline void discretization() {
    for (int i = 1; i <= n; ++i) {
        rank[i] = arr[i];
    }
    std::sort(rank.begin() + 1, rank.begin() + n + 1);
    nn = std::unique(rank.begin() + 1, rank.begin() + n + 1) - rank.begin() - 1;
    for (int i = 1; i <= n; ++i) {
        arr[i] = std::lower_bound(rank.begin() + 1, rank.begin() + nn + 1, arr[i]) - rank.begin();
    }
}

int block;
std::array<int, N> lnk;
std::array<int, BLOCK> L, R;

std::array<std::array<int, BLOCK>, BLOCK> res;
std::array<std::array<int, N>, BLOCK> sum;
std::unordered_map<int, int> freq;

inline void get_num() {
    for (int i = 1; i <= lnk[n]; ++i) {
        for (int j = 1; j <= n; ++j) {
            sum[i][arr[j]] = sum[i - 1][arr[j]];
        }
        for (int j = L[i]; j <= R[i]; ++j) {
            ++sum[i][arr[j]];
        }
    }
}

inline void get_res() {
    for (int l = 1; l <= lnk[n]; ++l) {
        freq.clear();
        int max_count = 0, id = 0x7fffffff;
        for (int r = l; r <= lnk[n]; ++r) {
            for (int i = L[r]; i <= R[r]; ++i) {
                ++freq[arr[i]];
                if (freq[arr[i]] > max_count) {
                    id = arr[i];
                    max_count = freq[arr[i]];
                } else if (freq[arr[i]] == max_count) {
                    id = std::min(id, arr[i]);
                }
            }
            res[l][r] = id;
        }
    }
}

inline void prepare_work() {
    block = std::sqrt(n);
    for (int i = 1; i <= n; ++i) {
        lnk[i] = (i - 1) / block + 1;
    }
    for (int i = 1; i <= lnk[n]; ++i) {
        L[i] = (i - 1) * block + 1;
        R[i] = i * block;
    }
    R[lnk[n]] = n;
    get_num();
    get_res();
}

int query(int l, int r) {
    freq.clear();
    if (lnk[r] - lnk[l] <= 1) {
        int max_count = 0, id = 0x7fffffff;
        for (int i = l; i <= r; ++i) {
            ++freq[arr[i]];
            if (freq[arr[i]] > max_count || (freq[arr[i]] == max_count && arr[i] < id)) {
                id = arr[i];
                max_count = freq[arr[i]];
            }
        }
        return id;
    }

    int mid_id = res[lnk[l] + 1][lnk[r] - 1];
    int max_count = sum[lnk[r] - 1][mid_id] - sum[lnk[l]][mid_id];
    int best_value = mid_id;

    for (int i = l; i <= R[lnk[l]]; ++i) {
        ++freq[arr[i]];
    }

    for (int i = L[lnk[r]]; i <= r; ++i) {
        ++freq[arr[i]];
    }

    for (const auto &[value, count] : freq) {
        int total_count = count + sum[lnk[r] - 1][value] - sum[lnk[l]][value];
        if (total_count > max_count) {
            max_count    = total_count;
            best_value = value;
        } else if (total_count == max_count) {
            best_value = std::min(value, best_value);
        }
    }

    return best_value;
}

void Main_work() {
    std::cin >> n >> q;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    discretization();
    prepare_work();
    for (int i = 1, l, r, last_ans = 0; i <= q; ++i) {
        std::cin >> l >> r;
        l = (l + last_ans - 1) % n + 1;
        r = (r + last_ans - 1) % n + 1;
        if (l > r) {
            std::swap(l, r);
        }
        last_ans = rank[query(l, r)];
        std::cout << last_ans << '\n';
    }
}

void init() {}

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    init();
    int Zvezdy = 1;
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```