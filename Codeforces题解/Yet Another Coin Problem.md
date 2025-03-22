# Yet Another Coin Problem

所有者: Zvezdy
标签: 数学, 暴力枚举
创建时间: 2024年3月2日 11:34

在观察数据范围后，可以发现他们基本都是彼此的倍数。

1*3=3   3*2=6

另外10*3=15*2

于是可以判断出，1绝对不会抽超过2枚，因为可以用3填补；而3绝对不会超过1枚，因为可以用6填补；6绝对不会超过4枚，因为可以用15*2填补；10绝对不会超过2枚，因为可以用15*2填补。

那么就暴力吧，没什么好说的。直接套好几层循环，模拟一元拿0枚，1枚，2枚，三元拿0枚，1枚。。。。以此类推。。。的情况。最后一层就补上15，看补不补得完，也看是不是选取了最少的硬币。

这可以算另外一种枚举的模式，就是通过题目给出的条件的特殊之处（在该题中表现为彼此为彼此的倍数）来缩短可能得情况，比如本来是认为每个硬币都可以拿无数枚，实际上能拿的很少，甚至这个范围已经被缩短为通用的有限个，因为有上位替代。

```cpp
#include<bits/stdc++.h>
using namespace std;
int main(){
    int t; cin>>t;
    while(t--){
        int n,ans=0x7fffffff; cin>>n;
        for(int yi=0;yi<=2;++yi)
        for(int san=0;san<=1;++san)
        for(int liu=0;liu<=4;++liu)
        for(int shi=0;shi<=2;++shi){
            int last=n-(yi+3*san+6*liu+10*shi);
            if(last<0){continue;} //减到小于0就跳过，该方案失效
            if(last%15==0){ //如果剩下的不能用15填完，跳过，该方案失效
                ans=min(ans,last/15+yi+san+liu+shi); //选择最优方案
            }
        }
        cout<<ans<<endl;
    }
    return 0;
}
```