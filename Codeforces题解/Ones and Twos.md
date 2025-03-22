# Ones and Twos

所有者: Zvezdy
标签: 思维, 树状数组
创建时间: 2024年5月13日 14:46

细节毛刺的地方很多。首先看到在线的区间查询和单点修改，很容易想到树状数组。不过这题需要找子区间，显然树状数组不支持快速筛选这个功能。

不过可以试着观察数组，数组缩减的时候一共有四种情况：一是左边或者右边端点值为1，另一个为2，或者是左右端点值都为1，还有左右端点值都为2。无论哪种情况，都可以通过某种缩减数组元素的方式让当前子区间总和减少2，并且可以一直持续下去直到结束。于是可以想到假如有一个子区间和我们当前需要查找的和同奇偶，那么就肯定可以通过缩短那个子区间来得到我们想要的值，所以我们选择维护一个当前所有元素之和以及一个和当前所有元素和奇偶性不同的最大子区间和。

维护另一个奇偶性不同区间的方式是找到开头第一个1所在的位置和最后一个1所在的位置，选择：减去前段或者后段，可以维护一个multiset来实现自动排序，注意特判集合为空的情况。

今后注意特判：某个元素的集合是否可能为空?  希望减少后缀取最优，有没有可能减少前缀会更优？

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
#pragma GCC optimize(2)
#pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define int long long
#define ld double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x; endll
#define ddbug(x) cout<<x<<" "
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(int word=begin;word<=endd;++word)
#define ROF(word,begin,endd) for(int word=begin;word>=endd;--word)
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
const int MAXN=200005;
const int mode=1e9+7;
class tree_list {
public:
    int lowbit(ll x){
	    return x & (-1 * x);
    }
	void add(ll index,ll num){//在index处添加num
		for (; index <=MAXN; index += lowbit(index)){
			arry[index]+=num;
        }
	}
	ll ask(ll index){//查找元素
		ll ans = 0;
		for (; index ; index -= lowbit(index)){
			ans += arry[index];
        }
		return ans;
	}
	ll arry[MAXN+5]{0};
};
int arr[200001];
void solve(){
    cint(n); cint(q);
    tree_list a;
    multiset<int,cmp(int)>one([](int x,int y){
        return x>y;
    });
    FOR(i,1,n){
        r(arr[i]);
        a.add(i,arr[i]);
        if(arr[i]==1) one.insert(i);
    }
    bool o=true;
    if(a.ask(n)%2) o=false;
    while(q--){
        cint(con);
        if(con==1){
            cint(num);
            // debug(o);
            if(num%2){
                if(one.size() && o && max(a.ask(*one.begin()), 
                        a.ask(n)-a.ask(*(--one.end())))>=num){
                    s("YES");endll;
                    continue;
                }
                if(!o && a.ask(n)>=num){
                    s("YES");endll;
                    continue;
                }
                s("NO");endll;
            }
            else{
                if(one.size() && !o && max(a.ask(*one.begin()), 
                         a.ask(n)-a.ask(*(--one.end())))>=num){
                    s("YES");endll;
                    continue;
                }
                if(o && a.ask(n)>=num){
                    s("YES");endll;
                    continue;
                }
                s("NO");endll;
            }
        }
        else{
            cint(i); cint(v);
            if(arr[i]==1)
                one.extract(i);
            a.add(i,-arr[i]);
            if(arr[i]%2==v%2) o^=1;
            if(v==1){
                one.insert(i);
                a.add(i,1);
            }
            else a.add(i,2);
            arr[i]=v;
            o^=true;
        }
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT=1; 
    cin>>TTT;
    while(TTT--){solve();}
    return 0;
}

```