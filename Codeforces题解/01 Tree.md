# 01 Tree

所有者: Zvezdy
标签: 思维, 链表
创建时间: 2024年10月5日 21:34

一个逆向思维的小题，考虑一下我们这棵树是怎么被建出来的，发现是一个数字在自己旁边塞了一个比自己大1的数字，那我们就可以考虑弄个逆向工程，把这个数组一点一点删回去，最后就会只留一个为0的根。可以发现删完两个子节点以后可以等价为在数组中把两个点里较大的那个删除，删除这件事可以用手写链表完成。每次删完以后及时判断一下被删这个数左右两边能不能构成一个新被删除的子节点，因为可能会出现两个一样大的元素相邻的情况。删到不能删为止就可以开始判断了。

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
    vector<int> a(n + 2, -2);
    vector<PII> lst(n + 2, {0, 0});
    for (int i = 1; i <= n; ++i) {
        cin >> a[i];
        lst[i] = make_pair(i - 1, i + 1);
    }

    vector<int> del(n + 2, false);
    priority_queue<PII> pq;
    for (int i = 1; i <= n; ++i) {
        if (a[lst[i].fi] == a[i] - 1 || a[lst[i].se] == a[i] - 1) {
            pq.push(make_pair(a[i], i));
            del[i] = true;
        }
    }
    while (pq.size()) {
        auto [_, i] = pq.top();
        pq.pop();
        lst[lst[i].fi].se = lst[i].se;
        lst[lst[i].se].fi = lst[i].fi;

        int left = lst[i].fi;
        int right = lst[i].se;
        if (!del[left] && (a[lst[left].fi] == a[left] - 1 || a[lst[left].se] == a[left] - 1)) {
            pq.push(make_pair(a[left], left));
            del[left] = true;
        }
        if (!del[right] && (a[lst[right].fi] == a[right] - 1 || a[lst[right].se] == a[right] - 1)) {
            pq.push(make_pair(a[right], right));
            del[right] = true;
        }
    }
    int minn = n, bad = 0;
    for (int i = 1; i <= n; ++i) {
        bad += !del[i];
        minn = min(a[i], minn);
    }
    if (bad == 1 && minn == 0) {
        cout << "YES" << endl;
    } else {
        cout << "NO" << endl;
    }
}

void init() {}

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