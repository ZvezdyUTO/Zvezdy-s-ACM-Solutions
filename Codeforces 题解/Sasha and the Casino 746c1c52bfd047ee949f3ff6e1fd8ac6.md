# Sasha and the Casino

所有者: Zvezdy
标签: 找规律, 数学
创建时间: 2024年3月5日 21:34

题目说能拿到任意数量的钱，那我们只要保证，我们需要找出一种方法，保证在这种情况下每次我们都可以盈利。根据题目给出的公式：多得到的金币$=y*(k-1)$

我们不去考虑它的具体下注方案，而是专注于每次下注必定盈利，那我们可以创建一个lose代表输掉的钱数，每次下注的金额就是那个 $y$ ， $lose/(k-1)+1$就是每次我们需要的 $y$ ，每求出新的 $y$ 就把它累加到 lose 里面，如果在 $x+1$ 局内，我们输掉的钱多于我们的本金，那我们就GG了，如果坚持下来了，那就可以盈利。

```cpp
#include<bits/stdc++.h>
using namespace std;
int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL); cout.tie(NULL);
    int t; cin>>t;
    while(t--){
        long long k,x,a,lose=0;
				bool win=true;
				cin>>k>>x>>a;
				for(int i=1;i<=x+1;i++){
				lose+=lose/(k-1)+1;
				if(lose>a) {win=false;break;}
				if(win) cout<<"YES"<<endl;
				else cout<<"NO"<<endl;
		}  
    return 0;
}
```