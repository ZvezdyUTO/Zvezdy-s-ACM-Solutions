# XOR of Suffix Sums

所有者: Zvezdy

题目这里有一个小trick，就是给出的这个奇奇怪怪的模数是2的21次方，这意味着我们可以按位来分解去做，并且只考虑前21位。题目给出的修改也比较特殊，是删除后面一部分数字后再新添一个数字，如果我们打的是前缀和的话就可以在很短时间内完成此类修改，不过题目要求的是后缀和，我们就拿前缀和的最后一位减去我们所需的后缀和前一位就可以通过前缀和求出后缀和了，用公式来表示就是-pre+sum。

现在需要求的是这几个后缀和相互异或后的总值，已知我们可以按位去做，现在只要求出这些数字在每一位上的1的个数是奇数还是偶数就可以找到它们异或和了。考虑到本题是一个伪区间修改（看每次就多加一个数，能是区间删除也没用），我们可以用树状数组来维护一个位上1的个数。具体的实现方式就是，当我们需要新增加一个新的数字，我们就把目前的-pre打入树状数组中。已知取模运算可以让负数变为正数，所以我们在打入一个树状数组之前都进行取模运算，在它所出现的位置+1，表示我们此时拥有这个数。

然后就是使用树状数组求解每一位上1的个数了。已知一个数如果mod2^(d+1)之后大于等于2^d，就说明它在第d位上有1，我们就遍历这个d，每一次都找有多少个数字符合这个条件。假设我们目前正在统计第d位1的个数，我们可以直接把sum模上2^(d+1)，此时就是寻找 (-pre+sum)%2^(d+1)≥2^d的数字个数了，易知当我们的-pre在取模后处于2^d~2^(d+1)-1的区间时符合要求，但还有一种情况就是如果x>(2^d)的话，那么-pre处于n+(n/2-x)，2^(d+1)-1的时候也符合要求。这个特殊的条件可以这么推理来：我们把2^(d+?)看作是(2^?)*2^d，那么在2^(d+2)，2^(d+3)范围内的数字显然也符合要求，当然这仅仅只是在x>2^d的时候。

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
#define PII pair<i64,i64>
const int N = 300005;
const int INF = 1e18;
const int MODE=(1ll<<21ll);

template <typename T>
struct Fenwick {
    int n;
    vector<T> a;

    Fenwick(int n_ = 0) {
        init(n_);
    }

    void init(int n_) {
        n = n_;
        a.assign(n + 10, T{});
    }

    void add(int x, const T &v) {
        x = (x % n + n) % n; 
        for (int i = x + 1; i <= n; i += i & -i) {
            a[i] = a[i] + v;
        }
    }

    T sum(int x) {
        T ans{};
        for (int i = x; i >= 1; i -= i & -i) {
            ans = ans + a[i];
        }
        return ans;
    }

    T rangeSum(int l, int r) {
        ++l; ++r;  // 将 l 和 r 调整为从 1 开始
        return sum(r) - sum(l - 1);
    }

    bool query(int x) {
        x %= n;
        int cnt = 0;
        cnt += rangeSum((n/2)-x, n-x-1);
        if (x > (n/2)) {
            cnt += rangeSum(n+(n/2-x), n-1);
        }
        return cnt%2;
    }
};

void solve(){
    Fenwick<int>fenwick_tree[21];
    for(int i=0;i<21;++i){
        fenwick_tree[i].init(1ll<<(i+1));
    }
    int q; cin>>q;
    stack<int>nums;
    int sum=0;
    while(q--){
        int t,v;
        cin>>t>>v;
        
        for(int i=1;i<=t;++i){
            sum-=nums.top();
            nums.pop();
            for(int j=0;j<21;++j){
                fenwick_tree[j].add(-sum,-1);
            }
        }
        nums.push(v);

        for(int i=0;i<21;++i){
            fenwick_tree[i].add(-sum,1);
        }

        sum+=nums.top();
        int res=0;
        for(int i=0;i<21;++i){
            res|=fenwick_tree[i].query(sum) << i;
            
        }
        cout<<res<<endl;
    }
} 
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    // freopen("test.out","w",stdout);
    long Zvezdy = 1;
    // cin >> Zvezdy;

    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```
