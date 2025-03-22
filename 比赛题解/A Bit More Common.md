# A Bit More Common

所有者: Zvezdy

相较于A题，我们只需要把符合A题但是不符合B题的情况容斥掉就好了，所以我们要找的是必须要所有数一起按位与才能拿到1的方案数。我们假设目前我们手上的全是奇数，然后一共有m位，我们手头的奇数有k位，我们称某一位必须有个0的位置为关键位，那我们就需要预先求出多少数中包含多少关键位的方案数，算出来以后，剩余位就是补0。

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
#define debug(x) cout<<#x<<" = "<<x<<endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int,int>
const int N = 300005;
const int INF = 1e18;

using i64 = long long;
i64 MODE = 998244353;
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
i64 MInt<0>::Mod = 998244353;
using Z = MInt<0>;

void solve(){
    i64 n,m; cin>>n>>m>>MODE;
    MInt<0>::setMod(MODE);

    vector<Z>qmi(n+1,1);
    for(int i=1;i<=n;++i){
        qmi[i]=qmi[i-1]*2;
    }

    vector<vector<Z>>c(5001,vector<Z>(5001,0));
    c[0][0]=1;
    for(int i=1;i<=max(n,m-1);i++){
        c[i][0]=1;
        for(int j=1;j<=i;j++)
            c[i][j]=c[i-1][j]+c[i-1][j-1];
    }

    vector<vector<Z>>pre(n+1,vector<Z>(m+1,0));
    pre[0][0]=1;
    for(int i=1;i<=n;++i){
        for(int j=1;j<=m-1;++j){
            pre[i][j]=i*(pre[i][j-1]+pre[i-1][j-1]);
        }
    }

    Z ans=0;
    for(int i=2;i<=n;++i){
        Z cur1=1,cur2=1;
        for(int j=1;j<m;++j){
            cur1*=qmi[n-i];
            cur2*=qmi[i]-1;
        }
        Z cur3=0,cur4=1;
        for(int j=m-1;j>=i;--j){
            cur3+=c[m-1][j]*pre[i][j]*cur4;
            cur4*=qmi[i]-1-i;
        }
        ans+=cur1*(cur2-cur3)*c[n][i];
    }
    cout<<ans.val()<<endl;
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