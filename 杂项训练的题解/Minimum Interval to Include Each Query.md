# Minimum Interval to Include Each Query

所有者: Zvezdy
标签: 扫描线
创建时间: 2024年8月2日 10:50

一个离线处理以及离线查询的典例，将答案一个个打出来以后使用桶排把它们录入答案数组中。同时也是一维扫描线的一道典题。我们可以先尝试把这题的所有区间花在一张纸上，然后想象我们有一根线逐个扫描过去，每到一个查询点就可以打一个标记，看此时此刻我们符合条件的区间最短是哪个。为了让这个过程得以实现，需要对询问数组以及区间数组进行排序，以便扫描。

扫描的时候为了取出我们所需的最佳答案，我们需要使用优先队列，让区间长度小的浮在上面，与此同时我们判断此时堆顶元素是否过期，过期就踢出队列，我们只需要不停判断堆顶元素是否过期就好，沉在底下的不需要判断，因为要么有朝一日我们会踢中它，要么就是永远有比它优的区间，永远用不到它。

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
    vector<vector<int>> intervals;
    vector<int> queries;
    // 测试用例:
    intervals = {{17, 23}, {10, 30}, {15, 80}, {5, 80}, {50, 60}, {22, 25}, {6, 15}};
    queries = {24, 18, 78, 4, 93, 7, 52, 40};
    // 主程序：—————————————————————————————————————————————————————————————
    auto SolveProblem = [&]() {
        int n = intervals.size();
        int m = queries.size();
        vector<pair<int, int>> que(m);
        for (int i = 0; i < m; ++i) {
            que[i].first = queries[i];
            que[i].second = i;
        }
        sort(intervals.begin(), intervals.end());
        sort(que.begin(), que.end());

        vector<int> ans(m, -1);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> sl;
        for (int i = 0, j = 0; i < m; ++i) {
            while (j < n && intervals[j][0] <= que[i].first) {
                sl.push(make_pair(intervals[j][1] - intervals[j][0] + 1, intervals[j][1]));
                ++j;
            }
            while (sl.size() && sl.top().second < que[i].first) {
                sl.pop();
            }
            if (sl.size()) {
                ans[que[i].second] = sl.top().first;
            }
        }
        for (auto i : ans) cout << i << ' ';
        return ans;
    };
    // 执行指令：———————————————————————————————————————————————————————————
    SolveProblem();
    return 0;
}

```