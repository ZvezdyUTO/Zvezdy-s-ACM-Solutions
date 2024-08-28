# Online Majority Element In Subarray

所有者: Zvezdy
标签: 二分查找, 摩尔投票, 线段树
创建时间: 2024年8月7日 13:11

如果我们想要在log级的时间内找出一个数组中某个区间内某个数字出现的个数，我们可以把这个数组打一个二元组记录其值和下标，然后把这个二元组排序，使用二分搜索精确定位左端点和右端点的位置，再直接相减就可以求出我们所需的答案。

```cpp
int Bserch(int num, int index) {
    auto cmp = [](const pair<int, int>& p, const pair<int, int>& value) {
        return p.first < value.first || (p.first == value.first && p.second <= value.second);
    };
    return upper_bound(Array.begin(), Array.end(), make_pair(num, index), cmp) - Array.begin();
}
```

根据摩尔投票的原理，假如我们有几个不相交区间的目标数以及它们的剩余词频，我们就可以通过区间合并的方式求出他们所合并区间的候选目标以及其所剩词频。利用这个特性，我们就可以使用线段树维护我们整个数组每个区间的候选目标以及其真实词频。

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
// #define int long long
#define debug(x) cout << #x << " = " << x << endl

struct Info {
    int goal = -1;
    int hp = -1;
};

Info operator+(Info a, Info b) {
    Info c;
    if (a.goal == -1) {
        c.goal = b.goal;
        c.hp = b.hp;
    } else if (b.goal == -1) {
        c.goal = a.goal;
        c.hp = a.hp;
    } else {
        if (a.goal == b.goal) {
            c.goal = a.goal;
            c.hp = a.hp + b.hp;
        } else {
            if (a.hp > b.hp) {
                c.goal = a.goal;
                c.hp = a.hp - b.hp;
            } else if (a.hp < b.hp) {
                c.goal = b.goal;
                c.hp = b.hp - a.hp;
            } else {
                c.goal = -1;
                c.hp = 0;
            }
        }
    }
    return c;
}

template <class Info>
struct SegmentTree {
    int n;
    vector<Info> info;
    vector<pair<int, int>> Array;

    SegmentTree(int n) : n(n), info(4 << __lg(n)), Array(n) {}

    SegmentTree(vector<Info> init) : SegmentTree(init.size()) {
        auto build = [&](auto& self, int p, int l, int r) -> void {
            if (r - l == 1) {
                info[p] = init[l];
                return;
            }
            int m = l + (r - l) / 2;
            self(self, 2 * p, l, m);
            self(self, 2 * p + 1, m, r);
            pull(p);
        };
        build(build, 1, 0, n);

        for (int i = 0; i < n; ++i) {
            auto& [v, index] = Array[i];
            v = init[i].goal;
            index = i;
        }
        sort(Array.begin(), Array.end());
    }

    void pull(int p) {
        info[p] = info[2 * p] + info[2 * p + 1];
    }

    Info rangeQuery(int p, int l, int r, int x, int y) {
        if (l >= y || r <= x) {
            return Info();
        }
        if (l >= x && r <= y) {
            return info[p];
        }
        int m = l + (r - l) / 2;
        return rangeQuery(2 * p, l, m, x, y) + rangeQuery(2 * p + 1, m, r, x, y);
    }

    Info rangeQuery(int l, int r) {
        return rangeQuery(1, 0, n, l, r);
    }

    int Bserch(int num, int index) {
        auto cmp = [](const pair<int, int>& p, const pair<int, int>& value) {
            return p.first < value.first || (p.first == value.first && p.second <= value.second);
        };
        return upper_bound(Array.begin(), Array.end(), make_pair(num, index), cmp) - Array.begin();
    }
};

class MajorityChecker {
    SegmentTree<Info> st;
    vector<int> arr;

   public:
    MajorityChecker(vector<int>& arr) : st(vector<Info>(arr.size())), arr(arr) {
        vector<Info> init(arr.size());
        for (int i = 0; i < arr.size(); ++i) {
            init[i].goal = arr[i];
            init[i].hp = 1;
        }
        st = SegmentTree<Info>(init);
    }

    int query(int left, int right, int threshold) {
        int get_goal = st.rangeQuery(left, right + 1).goal;
        if (get_goal == -1) {
            return -1;
        }
        int L = st.Bserch(get_goal, left);
        int R = st.Bserch(get_goal, right);
        if (R - L >= threshold) {
            return get_goal;
        } else {
            return -1;
        }
    }
};

/**
 * Your MajorityChecker object will be instantiated and called as such:
 * MajorityChecker* obj = new MajorityChecker(arr);
 * int param_1 = obj->query(left,right,threshold);
 */

int main() {
    vector<int> arr = {1, 1, 2, 2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 1, 2, 2, 1, 2};
    MajorityChecker mc(arr);
    cout << mc.query(8, 12, 4) << endl;

    return 0;
}

```