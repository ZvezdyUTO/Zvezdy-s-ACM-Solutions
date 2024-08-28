# Square Pair

所有者: Zvezdy
标签: 数学

如果是一个数为0，那么这个数乘什么数都等于0，所以这个数前面所有数乘上它都能算完全平方数。

由唯一分解可知，两个数如果要相乘变为完全平方数，那么它们相乘后所有因子应该成对存在，由于完全平方数的性质，所以关键在于这两个数剃去各自所有完全平方数后的因子。如果它们相等，那么便可以组成完全平方数。

记得答案要开long long，(2*1e5)^2会爆…

```cpp
#include<bits/stdc++.h>
using namespace std;
#define debug(x) cout << #x << " = " << x << endl;
#define ld long double
#define i64 long long
i64 a[200001];
unordered_map<int,i64>save;
void solve(){
    int n; cin>>n;
    i64 ans=0;
    for(int i=1;i<=n;++i){
        cin>>a[i];
        for(int j=2;j*j<=a[i];++j) 
            while(a[i]%(j*j)==0)
                a[i]/=(j*j);

        if(a[i]){
            ans+=save[0];
            ans+=save[a[i]];//如果是1的话乘完全平方数等于1，完全平方数也会变为1
        }
        else ans+=(i-1);

        ++save[a[i]];
    }
    cout<<ans;
}
int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL); cout.tie(NULL);
//    int t=1;
//    int t; cin>>t;
//    while(t--) solve();
    solve();
    return 0;
}

```