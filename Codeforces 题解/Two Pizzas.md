# Two Pizzas

所有者: Zvezdy
标签: 思维, 状态压缩动态规划
创建时间: 2024年7月14日 09:44

有一部分题目是，题目给出的数据范围很大，但是数据量却只有2e5或者更少，所以并不用按照题目给出的数据范围打空间，而是只用开map存离散化表就行。而这题不一样，这题是题目给出的数据量大，但是在分析以后可以发现其实最多只有2^9种可能，也就是说按原料来看，进行最多只有0~511编号的披萨，但披萨还有一个价格属性，所以不能简单压缩为512种披萨去处理。

可以在处理人数的时候统计所有种类披萨的可满足人数，然后在录入披萨信息的时候，我们先把当前披萨和所有种类披萨跑一遍组合再将当前披萨统计入披萨池中，这样就可以完美处理选择两个重复披萨的情况。已知披萨组合是A|B=C，我们跑组合的时候是拿A和枚举的C找出B，这也是知二求一思想的运用，处理枚举信息的时候最好是利用手头所拥有的资源来进行枚举，哪个容易跑遍历就利用哪个，另外的不好遍历或者说不好存储的就将其推出就好。

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
const int MODE = 1e9+7;
const int INF = 1e18;
const int N = 1e6;
int vis[600],cnt[600],v[600];
int pay[100001];
void solve() {
	int n,m; cin>>n>>m;
	for(int i=1;i<=n;i++){
		int k; cin>>k;
		int s=0;
		for(int j=1;j<=k;j++){
			int x; cin>>x;
			s|=1<<(x-1);
		}

		for(int j=0;j<512;j++){//统计人数
			if((s|j)==j){ //当j可以完全覆盖s的时候，s|j==j
				++cnt[j];
			}
		}
	}

	int ans=0,res=-1;
	int A,B;
	for(int i=1;i<=m;i++){
		int c,k; cin>>c>>k;
		int s=0;
		for(int j=1;j<=k;j++){
			int x; cin>>x;
			s|=1<<(x-1);
		}

		for(int j=0;j<512;j++){//枚举编号或和
			if((s|j)!=j || cnt[j]<res) continue; //当前披萨比j覆盖范围还大或者披萨不好
			int o=j^s; //另外一个披萨的编号
			if(!vis[o]) continue; //另一个披萨不存在
			if(cnt[j]>res || (cnt[j]==res && v[o]+c<ans)){ //更换方案
				res=cnt[j];
				ans=v[o]+c;
				A=i;
				B=vis[o];
			}
		}

		for(int j=0;j<512;j++){ //先枚举后再补充，就可以处理重复的情况
			if((s|j)==s && (!vis[j] || c<v[j])){ //填补披萨
				vis[j]=i;
				v[j]=c;
			}
			if(!vis[0] || c<v[0]){ //更新披萨价格
				vis[0]=i;
				v[0]=c;
			}
		}
	}
	cout<<A<<" "<<B<<endl;
}
signed main() {
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
