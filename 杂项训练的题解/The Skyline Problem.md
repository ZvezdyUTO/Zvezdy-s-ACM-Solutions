# The Skyline Problem

所有者: Zvezdy
标签: 扫描线
创建时间: 2024年8月2日 20:53

扫描线实际上是一种思想，在将坐标离散化以后通过逐个遍历一个维度的信息来求解我们的答案，而其中最重要的自然是根据我们所遍历的内容提取答案，在这步操作中一般使用排序结构来查找我们所需的答案。在这一题中我们需要拿map打离散化后使用multiset记录高度，这里有一个trick，一个矩形右端的高度h，我们可以打一个-h来记录它，这样当我们遍历到一个-h的时候就可以在multiset中删除+h。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
#include <bits/stdc++.h>
using namespace std;
#define debug(x) cout << #x << " = " << x << endl

int main() {
    // 包信息：—————————————————————————————————————————————————————————————
    vector<vector<int>> buildings;
    // 测试用例:
    buildings = {{2, 9, 10}, {3, 7, 15}, {5, 12, 12}, {15, 20, 10}, {19, 24, 8}};
    // 主程序：—————————————————————————————————————————————————————————————
    auto SolveProblem = [&]() {
        int n = buildings.size();
        map<int, vector<pair<int, int>>> mp;
        for (int i = 0; i < n; ++i) {
            mp[buildings[i][0]].emplace_back(buildings[i][2], buildings[i][1]);
            mp[buildings[i][1]].emplace_back(-buildings[i][2], buildings[i][0]);
        }

        vector<vector<int>> ans;
        multiset<int> heights = {0};
        int last = 0;
        priority_queue<pair<int, int>> sl;
        for (auto& [i, ranges] : mp) {
            for (auto& [h, _] : ranges) {
                if (h > 0) {
                    heights.insert(h);
                } else {
                    heights.extract(-h);
                }
            }

            int max_height = *heights.rbegin();
            if (max_height != last) {
                ans.push_back({i, max_height});
                last = max_height;
            }
        }

        return ans;
    };
    // 执行指令：———————————————————————————————————————————————————————————
    SolveProblem();
    return 0;
}

```