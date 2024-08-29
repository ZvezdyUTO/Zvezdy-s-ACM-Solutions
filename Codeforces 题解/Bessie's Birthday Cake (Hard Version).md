# Bessie's Birthday Cake (Hard Version)

所有者: Zvezdy
标签: 几何
创建时间: 2024年4月1日 10:40

就是按思路放点，中间相差三个点的时候只要把中间的点补上就能一次多两个三角形，需要让这种情况尽可能变多。

那我们就可以用特殊的排序规则，让我们在遍历差集合的时候实现它，把偶数排在奇数前面，同奇偶则从小到大排，因为处理偶数差的时候就有机会补到特殊情况。

```jsx
sort(cha+1,cha+it+1,[](int x,int y){
    //通过返回true和false来控制特殊情况
    if(x%2==0 && y%2) return true;
    if(x%2 && y%2==0) return false;
    return x<y;
});
```

考虑到数据范围大，我们需要对求解部分进行优化，具体是分奇偶情况处理，偶数情况就用除法快速求出填补到只剩4个差的情况，再特判。奇数的话就直接除就好，同时保证有点可放，所以用min函数比较可放点和剩余的y。

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

ll a[200001];
ll cha[200001];
void solve(){
    cll(n);cll(x);cll(y);
    FOR(i,1,x) r(a[i]);
    ll ans=x+y-2;
    sort(a+1,a+x+1);
    ll it=0;
    FOR(i,2,x){
        if(a[i]-a[i-1]>2) cha[++it]=a[i]-a[i-1];//可作为插入点
        if(a[i]-a[i-1]==2) ++ans;//原本就存在的边沿三角形
    }
    ll chaa=a[1]+n-a[x];
    if(chaa==2) ++ans;
    if(chaa>2) cha[++it]=chaa;
    sort(cha+1,cha+it+1,[](int x,int y){
        if(x%2==0 && y%2) return true;//如果偶数就排在前面
        if(x%2 && y%2==0) return false;//奇数排在后面
        return x<y;//同奇偶就从小到大排
    });//优先保证4在前面，且后面的数都是为了最快能凑出4
    if(it>0)//如果有能插入的空间
    for(int i=1;i<=it && y!=0;++i){
        if(cha[i]%2==0){//偶数
            ll cut=min((cha[i]-4)/2,y);
            y-=cut;
            ans+=cut;
            if(y){--y; ans+=2;}
        }
        else{//奇数，直接计算
            ll cut=min((cha[i]/2),y);
            y-=cut;
            ans+=cut;
        }
    }
    ans=min(n-2,ans);//不超过n-2个三角形
    s(ans); endll;
}
int main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int T; cin>>T;
//    int T=1;
    while(T--){solve();}
    return 0;
}

```
