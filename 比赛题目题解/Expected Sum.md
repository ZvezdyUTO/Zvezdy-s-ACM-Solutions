# Expected Sum

所有者: Zvezdy

对于组合数学的题目一般考虑递推求解。由题意可知这些操作实际上不会改变每一位的数字，而是会改变它们的位数，所以我们就从每一位下手分解。推导后可以发现，无论高位有无加号都不会影响低位数字是多少位，所以为了消除后效性，我们考虑从低位往高位递推求解。

结合我们得出的“改变位数”的结论，在手推后可得出某一位上数字后跟不同个零的概率，在这就可以发现实际上这些概率和这一位上数字是几完全没关系，但和概率以及所乘的10的某次方有关系，将这些元素结合为式子并多列出几项，整理比对后得出递推式，使用数组存储再计算可得出答案。

另外对于取模运算，实际上在一个式子中无论哪里塞入一个取模都是没影响的，当然分数取模得乘上逆元再取模，取模有分数的时候需要注意这个。在拆分多项式的时候，注意哪些和哪些有关，无关元素排除，有关元素结合后就有可能弄出递推的规律。

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
#define debug(x) cout<<#x<<"="<<x<<endl
#define ddbug(x) cout<<x<<" "
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(int word=begin;word<=endd;++word)
#define                                                                                                                ROF(word,begin,endd) for(int word=begin;word>=endd;--word)
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
const int MODE=998244353;
ll exgcd(ll l,ll r , ll &x,ll &y){//两个参数，两个解
    if(r==0){x=1;y=0;return l;}
    else{
        ll d=exgcd(r,l%r,y,x);
        y-=l/r*x;
        return d;
    }
}
ll NI(ll num,ll MODE){
    ll x,y;
    if(exgcd(num,MODE,x,y)==1)//ax+my=1
        return (x%MODE+MODE)%MODE;
    return -1;//不存在
}
int a[2000010],p[2000010],pp[2000010],digits[2000010];
void solve(){
    cint(n); cstring(s);
    FOR(i,1,n-1) r(p[i]);
    FOR(i,0,n-1) a[i+1]=s[i]-'0';
    digits[n]=a[n];
    int fm=NI(100,MODE);
    digits[n-1]=pp[n-1]*a[n-1]%MODE;
    ROF(i,n-1,1){
        if(i==n-1) pp[i]=(p[i]*fm)%MODE + 10 * ((100-p[i])*fm%MODE);
        else pp[i]= 10* ((100-p[i])*fm)%MODE * pp[i+1] + (p[i]*fm%MODE);
        pp[i]%=MODE;
        digits[i]=pp[i]*a[i]%MODE;
    }
    int anss=0; FOR(i,1,n){anss+=digits[i];anss%=MODE;} s(anss);
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    int TTT=1; 
    // cin>>TTT;
    while(TTT--){solve();}
    return 0;
}
```
