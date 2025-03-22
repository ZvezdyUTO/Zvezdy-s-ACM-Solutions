# Longest Max Min Subsequence

所有者: Zvezdy
标签: 数据结构
创建时间: 2024年9月27日 08:44

码力题，同时也非常考验分析能力。对于构造字典序最大、最小，一定是靠前面的元素越优越好，这题有奇数位取负数的情况，但不影响每位最优即可的策略。可以考虑使用一个栈来构造，如果发现后面的元素比前面的更优，就把前面的弹出，替换以后面的元素，不过这题有一个特殊的条件就是每个元素至少出现一次，所以我们弹出的时候需要判断两个条件：1是弹出这个元素是不是会让我们的答案变得更优，2是被弹出的这个元素在后面还会不会出现？如果我们不管奇数位取负数的情况，这种构造方法一定是优的，因为我们构造的数组在合法范围内一定是越靠前越优，而考虑奇数位取负数的时候就需要多考虑一个情况：如果新的数替换上一位不优，但替换上上位优，那么我们就选择替换上上位。考虑常数时间优化，使用手写栈。

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
#define int long long
#define debug(x) cout << #x << " = " << x << endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int INF = 1e18;

void solve() {
    int n;
    cin >> n;
    vector<int> a(n), lst(n + 1);
    for (int i = 0; i < n; ++i) {
        cin >> a[i];
        lst[a[i]] = i;  // 只关心最后一个出现的位置，也就是有没有
    }

    int top = -1;
    vector<int> stk(n);
    vector<bool> vis(n + 1, false);
    for (int i = 0; i < n; ++i) {
		    // 后面被填入的元素一定保证比前面的元素更优，所以已被判过的元素不用重判
        if (vis[a[i]]) continue;

        // 当前位置比前一个位置更优
        while (top >= 0 &&
               (top % 2 ? a[stk[top]] > a[i] : a[stk[top]] < a[i]) &&
               lst[a[stk[top]]] > i) {
            vis[a[stk[top--]]] = false;
        }

        // 当前位置比前二个位置更优
        while (top >= 1 &&
               (top % 2 ? a[stk[top - 1]] < a[i] : a[stk[top - 1]] > a[i]) &&
               lst[a[stk[top - 1]]] > i && lst[a[stk[top]]] > i) {
            vis[a[stk[top--]]] = false;
            vis[a[stk[top--]]] = false;
        }
        stk[++top] = i;
        vis[a[stk[top]]] = true;
    }

    cout << top + 1 << endl;
    for (int i = 0; i <= top; ++i) {
        cout << a[stk[i]] << " ";
    }
    cout << endl;
}

void init() {
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    init();
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```