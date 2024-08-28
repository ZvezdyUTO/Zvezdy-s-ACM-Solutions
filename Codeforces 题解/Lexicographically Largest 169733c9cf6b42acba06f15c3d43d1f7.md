# Lexicographically Largest

所有者: Zvezdy
标签: 数学
创建时间: 2024年2月26日 20:31

题目给出的条件是，S变b会自动排降序

所以按理来说根本不用考虑所谓下标-1的情况

但是如果是相同的数，因为插入的是一个集合，所以要慢慢-1弄个倒序，毕竟如果需要保证字典序最大，那肯定数要尽可能地多

于是处理方法就是：把a[i]+i排序，然后相同大小的数就减一。

```cpp
#include<bits/stdc++.h>
using namespace std;
int a[300001];
int main(){
    int T; cin>>T;
    while(T--){
        int n; cin>>n;
        for(int i=1;i<=n;++i){
            scanf("%d",&a[i]);
            a[i]+=i;
        }
        sort(a+1,a+n+1,[](int x,int y){
            return x>y;
        });
        for (int i = 1; i <= n; i++)
            cout << a[i] << " ";
        cout<<endl;
        for (int i = 2; i <= n; i++)
            a[i]= min(a[i],a[i-1]-1);
        for (int i = 1; i <= n; i++)
            cout << a[i] << " ";
        printf("\n");
    }
}
```