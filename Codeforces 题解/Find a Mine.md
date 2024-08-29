# Find a Mine

所有者: Zvezdy
标签: 互动题, 数学
创建时间: 2024年3月2日 11:34

就差最后一步吧，看模拟。

![Untitled](Find%20a%20Mine%2052ac31ac95774087b43aab30bccd8d33/Untitled.png)

首先按昨晚的思路，我们选取的是矩形边界的各个顶点，于是我们得到了3个斜线，一共2个交点。

但最后一个查询点我们不选择最后一个顶点，而是选择这两个交点中的一个，因为这两个交点中一定包含一个或者两个矿井，如果是0就代表猜对了，如果不是0那肯定是另外一个。

至于对角线的坐标，可以通过设方程联立求解获得。

```cpp
#include<bits/stdc++.h>
using namespace std;
int a,b,c;
int main(){
    int t; cin>>t;
    while(t--){
        int n, m;
        cin >> n >> m;
        cout << "? 1 1\n";
        cin >> a;
        cout << "? " << n << " " << 1 << endl;
        cin >> b;
        cout << "? " << n << " " << m << endl;
        cin >> c;
 
 
        int k = 0;
 
        int x1 = (a - b + n + 1) / 2, y1 = (a + b - n + 3) / 2;
        int x2 = (2 * n + m - 1 - b - c) / 2, y2 = (b - c + 1 + m) / 2;
        if (x1 <= 0 || y1  <= 0 || x1 > n || y1 > m) {
            cout << "! " << x2 << " "<< y2 << endl;
        }
        else {
            cout << "? " << x1 << " " << y1 << endl;
            cin >> k;
            if (k == 0) cout <<  "! " << x1 << " "<< y1 << endl;
            else cout << "! " << x2 << " "<< y2 << endl;
        }
    }
    return 0;
}
```
