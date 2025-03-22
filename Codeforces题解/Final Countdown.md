# Final Countdown

所有者: Zvezdy
标签: 数学
创建时间: 2024年4月18日 10:36

已知每一位所贡献的数是自己的位数-1，那么不妨这么想，对于12345，有多少个十位?答案是1234个十位，所以先加1234*(2-1)，然后对于百位，一共有123个百位，所以是123*(3-1)。。。

自然而然想到高精度，但看这题的数据范围，高精度必G，所以来考虑优化：

12345

  1234

    123

      12

        1

不难发现这玩意有点前缀和的味道在里面，其实每一位上的数字就是一种前缀和，那根本就不需要开string，直接按位模拟，毕竟计算的就是每一位上的数字相加之和。然后·后面再模拟进位就行。

所以说位数，位数，某一位到底有几个？什么算是“按位模拟”？另外对数字也敏感一点，从1加到9不会超过两位数，所以单纯模拟进位是完全可能的。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
//#pragma GCC optimize(2)
//#pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define ld long double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x; endll
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(auto word=begin;word<=endd;++word)
#define ROF(word,begin,endd) for(auto word=begin;word>=endd;--word)
#define cmp(what_type) function<bool(what_type,what_type)>
#define r(x) cin>>x
#define s(x) cout<<x
#define cint(x) int x;cin>>x
#define cchar(x) char x;cin>>x
#define cstring(x) string x;cin>>x
#define cll(x) ll x; cin>>x
#define cld(x) ld x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>

void solve(){
    cint(n); int suf=0;
	vector<int> a(n), res(n + 1, 0);
	FOR (i, 0, n - 1) {
		char c;
		cin >> c;
		a[i] = c - '0';
		suf += a[i];//每一位之和
	}
	reverse(a.begin(), a.end());
	FOR (i, 0, n - 1) {
		res[i] = suf;
		suf -= a[i];
	}
	
	int fin = n;
    
	FOR (i, 0, n - 1) {
		res[i + 1] += res[i] / 10;
		res[i] %= 10;
	}
	while (!res[fin] && fin) fin -- ;
	ROF (i, fin, 0) cout << res[i];
	endll;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT; cin>>TTT;
//    int TTT=1;
    while(TTT--){solve();}
    return 0;
}
```

vector真是好东西吧，可以用reverse翻转一波！还可以插入和删除以及尾接。