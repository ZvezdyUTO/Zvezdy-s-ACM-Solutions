# P4824 [USACO15FEB] Censoring S

所有者: Zvezdy
标签: KMP

遇到这种嵌套匹配的，自然而然想到使用栈来解决，毕竟弹掉内层后可以就着之前的记录继续匹配。把整个字符串都一步步填入到栈中，包括此时的位置也包括此时匹配到next数组的位置。匹配完全就弹出，并继承上一次的匹配记录。因为每次继承是从上一回+1，所以如果nxt数组跳到了0，需要填入-1，这样下次继承才会变为0。

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
const int MODE = 1e9 + 7;

const int N = 1e6;
array<int, N + 1> nxt;

void solve() {
    string a, b;
    cin >> a >> b;

    nxt[0] = -1;
    int ch = 0, it = 1;
    while (it < b.size()) {
        if (b[ch] == b[it]) {
            nxt[++it] = ++ch;
        } else if (ch > 0) {
            ch = nxt[ch];
        } else {
            nxt[++it] = 0;
        }
    }

    stack<PII> ans;
    int x = 0, y = 0;
    while (x < a.size()) {
        if (a[x] == b[y]) {
            ans.push({x++, y++});
        } else if (y == 0) {
            ans.push({x++, -1});
        } else {
            y = nxt[y];
        }

        if (y == b.size()) {
            for (int i = 0; i < b.size(); ++i) {
                ans.pop();
            }
            if (ans.size()) {
                y = ans.top().se + 1;
            } else {
                y = 0;
            }
        }
    }

    vector<char> result(ans.size());
    int cnt = 0;
    while (!ans.empty()) {
        result[cnt++] = a[ans.top().fi];
        ans.pop();
    }
    reverse(result.begin(), result.end());
    for (char c : result) {
        cout << c;
    }
    cout << endl;
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```