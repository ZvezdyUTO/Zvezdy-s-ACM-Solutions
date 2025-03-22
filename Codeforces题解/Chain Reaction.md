# Chain Reaction

所有者: Zvezdy
标签: 思维
创建时间: 2024年10月5日 10:45

这题有几个很关键的重要分析点。第一个就是我们无论按什么顺序放电，最后的结果都一样，第二个就是，实际上我们还是在对所有怪造成同等量的攻击，只不过因为有死掉的怪来拦截，所以我们造成全局伤害所需要的攻击次数并不一样，第三个就是我们攻击的累计值，也就是对怪的削血值，是统一的。

既然我们对所有怪物造成的伤害一样，那么我们就可以设立一个指标x，代表在我们对所有怪物造成总伤害为x的时候，我们对所有怪都造成一次攻击最少要放多少道闪电。那就是统计场上还有多少条连续的怪。这里有一个奇妙的办法，我们如果知道之前伤害为x-1的时候场上还有多少怪物存活，那我们就可以遍历血量为x的怪物，因为这时候它们刚好会死，然后我们就看它们死的时候能不能把一条完整的线段切割开。或者它们死的时候，会不会让一条完整的线段消失。这么统计出一个frequency数组之后，我们就可以拿这个来跑答案了。

这题最重要的还是通过某个指标来判断当前场上的状态，以及根据以前的状态来推断现在是何种情况，到底还是一个逐步推导的过程，所以某个中间量无法求解的时候，可以考虑能不能从0堆叠出它来。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include <bits/stdc++.h>
using namespace std;
#define debug(x) cout << #x << " = " << x << endl
#define int long long
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int INF = 1e18;

void solve() {
    int n;
    cin >> n;
    vector<int> arr(n + 1);
    for (int i = 1; i <= n; ++i) {
        cin >> arr[i];
    }

    // 可以发现，我们造成的伤害一定是全局的，因为从左到右扫一遍
    // 但是每次造成全局伤害所需要的次数不一样，具体看目前有多少个联通块
    // 所以考虑能不能求出当我们累计伤害为?的时候，我们造成全局伤害要多少次攻击
    int maxn = *max_element(arr.begin(), arr.end());
    vector<vector<int>> num(maxn + 2);
    vector<bool> alive(n + 2, false);
    for (int i = 1; i <= n; ++i) {
        num[arr[i] + 1].push_back(i);
        alive[i] = true;
    }

    // 具体是当伤害变为x的时候，遍历所有位置的x
    vector<int> frequency(maxn + 2, 0);
    for (int atk = 1; atk <= maxn; ++atk) {
        frequency[atk] = frequency[atk - 1];
        for (auto loca : num[atk]) {
            frequency[atk] += (alive[loca - 1] & alive[loca + 1]) - (!(alive[loca - 1] | alive[loca + 1]));
            alive[loca] = false;
        }
    }

    for (int i = 1; i <= maxn; ++i) {
        int ans = 0;
        for (int j = 1; j <= maxn; j += i) {
            ans += frequency[j] + 1;
        }
        cout << ans << " ";
    }
}

void init() {}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    init();
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```