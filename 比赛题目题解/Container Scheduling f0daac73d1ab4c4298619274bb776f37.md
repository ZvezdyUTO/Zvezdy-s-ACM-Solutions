# Container Scheduling

所有者: Zvezdy

纯纯是一个疯狂模拟题，很容易想到每个集装箱放置的时候要挨着已经放好的箱子的左边或者右边放置，那么就枚举每一个可能放置的位置，再看能不能放就好了。如果能放就代表此处不与任何一个箱子重叠或者超出边界，几何图形判断重叠就看中心点之间的距离和两个图形边长之间距离的大小关系就好。有一个细节需要注意：当double用于除常数的时候，记得加 .0 ，就像long long与常数进行处理需要把常数写成 ?ll 一样。

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
#define debug(x) cout<<#x<<" = "<<x<<endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int,int>
int MODE = 998244353;
const int INF = 1e18;
multiset<int>X,Y;
struct Box{
    int x1,y1, x2,y2;
}; vector<Box>box;
void solve(){
    int n,l,h; cin>>n>>l>>h;
    box.push_back({0,0,0,0});
    X.insert(0); Y.insert(0);
    for(int i=1;i<=n;++i){
        int now_l,now_h; cin>>now_l>>now_h;
        Box now{0,0,0,0};

        function<bool()>control=[&]()->bool{ //能不能放
            for(auto x:X){
                for(auto y:Y){
                    now.x1=x, now.y1=y;
                    now.x2=x+now_l, now.y2=y+now_h;
                    bool found=(now.x2<=l && now.y2<=h);

                    function<bool(Box&,Box&)>same=[&](Box& a,Box&b)->bool{
                        double mid_xa=(a.x1+a.x2)/2.0;
                        double mid_ya=(a.y1+a.y2)/2.0;
                        double mid_xb=(b.x1+b.x2)/2.0;
                        double mid_yb=(b.y1+b.y2)/2.0;
                        double l_a=abs(a.x2-a.x1)/2.0;
                        double h_a=abs(a.y2-a.y1)/2.0;
                        double l_b=abs(b.x2-b.x1)/2.0;
                        double h_b=abs(b.y2-b.y1)/2.0;

                        if(abs(mid_xa-mid_xb)>=l_a+l_b || abs(mid_ya-mid_yb)>=h_a+h_b){
                            return true;
                        }
                        else{
                            return false;
                        }
                    }; //判重

                    for(auto it:box){ //挨个看有没有重复的
                        found&=same(now,it);
                    }

                    if(found) return true;
                }
            }
            return false;
        };
        
        if(control()){
            box.push_back(now);
            X.insert(now.x2);
            Y.insert(now.y2);
            cout<<now.x1<<" "<<now.y1<<endl;
        }
        else{
            cout<<-1<<endl;
        }
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```