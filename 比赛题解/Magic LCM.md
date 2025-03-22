# Magic LCM

所有者: Zvezdy

任何一个数的质因数分解结果都是唯一的，区别在于它们指数的部分，如果一个数不包含某个质因子，那么那个质因子的指数就为0，视为1。再来观察gcd和lcm的性质，gcd实际上就是两个数进行质因数分解以后，每一项的指数都取最小，而lcm则是每一项取最大。

来分析一下这个操作，假设x和y（y>x）两个数存在大于1的共有因子k，进行操作后会有：x/k+y*k>y*(k-1)+y>x+y，如果x=y或者x与y互质，最坏也就是操作完后两数相等，由此可证，只要执行操作就不会亏本。

结合质因数分解与gcd和lcm的性质，我们可以发现，操作的实质就是把两个数质因数分解后的较大指数结合到一个数上，然后较小指数给另一个数。接着已知操作为优，那么我们在执行无数次操作以后一定能拿到最优解，接着就是考虑如何优化这个过程。我们对每个数进行质因数分解以后，单独对每一个质因数的次数进行独立的排序操作，把大的都堆在一起并计算求和即可。

最后就在于质因数分解的优化，采用埃氏筛和根号级暴力分解会TLE5，所以最好的方式是采用欧拉筛和快速试除法进行质因数分解，时间复杂度为O(n log(n))。偷了蒋老师的取模机板子，顺便学一学他的码风。

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
#define ll long long
#define debug(x) cout<<#x<<" = "<<x<<endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int,int>
const int MODE = 998244353;
const int INF = 1e18;
const int N=1e6;

//自动取模机，使用的时候不能#define int long long
using i64 = long long;
template<class T>
constexpr T power(T a, i64 b) {
    T res {1};
    for (; b; b /= 2, a *= a) {
        if (b % 2) {
            res *= a;
        }
    }
    return res;
}

constexpr i64 mul(i64 a, i64 b, i64 p) {
    i64 res = a * b - i64(1.L * a * b / p) * p;
    res %= p;
    if (res < 0) {
        res += p;
    }
    return res;
}

template<i64 P>
struct MInt {
    i64 x;
    constexpr MInt() : x {0} {}
    constexpr MInt(i64 x) : x {norm(x % getMod())} {}
    
    static i64 Mod;
    constexpr static i64 getMod() {
        if (P > 0) {
            return P;
        } else {
            return Mod;
        }
    }
    constexpr static void setMod(i64 Mod_) {
        Mod = Mod_;
    }
    constexpr i64 norm(i64 x) const {
        if (x < 0) {
            x += getMod();
        }
        if (x >= getMod()) {
            x -= getMod();
        }
        return x;
    }
    constexpr i64 val() const {
        return x;
    }
    constexpr MInt operator-() const {
        MInt res;
        res.x = norm(getMod() - x);
        return res;
    }
    constexpr MInt inv() const {
        return power(*this, getMod() - 2);
    }
    constexpr MInt &operator*=(MInt rhs) & {
        if (getMod() < (1ULL << 31)) {
            x = x * rhs.x % int(getMod());
        } else {
            x = mul(x, rhs.x, getMod());
        }
        return *this;
    }
    constexpr MInt &operator+=(MInt rhs) & {
        x = norm(x + rhs.x);
        return *this;
    }
    constexpr MInt &operator-=(MInt rhs) & {
        x = norm(x - rhs.x);
        return *this;
    }
    constexpr MInt &operator/=(MInt rhs) & {
        return *this *= rhs.inv();
    }
    friend constexpr MInt operator*(MInt lhs, MInt rhs) {
        MInt res = lhs;
        res *= rhs;
        return res;
    }
    friend constexpr MInt operator+(MInt lhs, MInt rhs) {
        MInt res = lhs;
        res += rhs;
        return res;
    }
    friend constexpr MInt operator-(MInt lhs, MInt rhs) {
        MInt res = lhs;
        res -= rhs;
        return res;
    }
    friend constexpr MInt operator/(MInt lhs, MInt rhs) {
        MInt res = lhs;
        res /= rhs;
        return res;
    }
    friend constexpr std::istream &operator>>(std::istream &is, MInt &a) {
        i64 v;
        is >> v;
        a = MInt(v);
        return is;
    }
    friend constexpr std::ostream &operator<<(std::ostream &os, const MInt &a) {
        return os << a.val();
    }
    friend constexpr bool operator==(MInt lhs, MInt rhs) {
        return lhs.val() == rhs.val();
    }
    friend constexpr bool operator!=(MInt lhs, MInt rhs) {
        return lhs.val() != rhs.val();
    }
    friend constexpr bool operator<(MInt lhs, MInt rhs) {
        return lhs.val() < rhs.val();
    }
};
template<>
i64 MInt<0>::Mod = MODE;
constexpr int P = MODE;
using Z = MInt<P>;

//欧拉筛
vector<int>minp,primes; //用于记录每个数的最小质因数，还有已经筛出的质数
void sieve(int n){
    minp.assign(n+1,0);
    primes.clear();
    for(int i=2;i<=n;++i){
        if(!minp[i]){
            minp[i]=i;
            primes.push_back(i);
        }
        for(auto p:primes){
            if(i*p>n) break; //超过了范围
            minp[i*p]=p; //将i*p的最小质因数标记为p
            if(p==minp[i]) break; //发现这个数有更小的质因子
        }
    }
}

int decr[N+5][20];
int maxn[N+5];
void solve(){
    int n; cin>>n;
    vector<int>a(n+1);
    for(int i=1;i<=n;++i) cin>>a[i];

    //最小试除法进行质因数分解
    vector<int>stk; //记录已经出现过的质因数
    for(int i=1;i<=n;++i){
        while(a[i]>1){
            int p=minp[a[i]];
            int t=0; //指数
            while(minp[a[i]]==p){ //抽取这个质因数的幂次
                a[i]/=p;
                ++t;
            }
            if(maxn[p]==0){
                stk.push_back(p);
            }
            maxn[p]=max(maxn[p],t); //更新质因数p的最大幂次
            ++decr[p][t]; //记录该质因数的某个幂次出现了几次
        }
    }

    Z ans = 1;
    vector<Z> arr(n+1,1);
    for (auto p : stk) {
        int j=0;
        for (int i=maxn[p];i>0;--i) {
            j+=decr[p][i]; // 计算质因数 p 的总出现次数
        }
        Z pw=1;
        for(int i=1;i<=maxn[p];++i) {
            pw*=p;
            while(decr[p][i]) {
                --decr[p][i];
                arr[--j] *= pw;
            }
        }
        maxn[p] = 0; // 处理完成后清零
    }
    //求和函数，起点、终点、初始值
    ans=accumulate(arr.begin(),arr.end()-1,Z(0));
    cout<<ans<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    sieve(N);
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```