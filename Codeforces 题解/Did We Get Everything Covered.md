# Did We Get Everything Covered?

所有者: Zvezdy
标签: 构造
创建时间: 2024年3月5日 22:30

之前已经明白，只要能保证有这么 $n$ 个不重合子串，每个子串里面都有前 $k$ 个字母。就算成功。

那这题就用STL中的 string 和 set 来实现，set负责的是把每个字符压入，如果set的长度为 $k$  ，就算我们找到了一个合格的子串。然后我们把那个子串的最后一个字母压入我们的反例字符串中，因为可以保证如此组合是唯一的。

如果到结束我们没找到 $n$ 个串，那我们就遍历 ‘a’-’z’ 并用find函数找到set中未存储的字母，作为反例字符串的实现，然后剩余的部分就拿 ’a’ 补齐就好。

```cpp
#include<bits/stdc++.h>
using namespace std;
string now,out;
set<char>ocu;
int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL); cout.tie(NULL);
    int t; cin>>t;
    while(t--){
        int n,k,m; cin>>n>>k>>m>>now;
        int num=0; out=""; ocu.clear();
        for(int i=0;i<now.size();++i){
            ocu.insert(now[i]); //插入集合
            if(ocu.size()==k){ //集合满，则代表已经装够
                ocu.clear(); //更新集合
                out+=now[i];
                ++num; //记录出现的次数
            }
        }
        if(num<n){
            cout<<"NO"<<endl<<out;
            for(char i='a';i<='z';++i)
                if(ocu.find(i)==ocu.end())
                    {cout<<i;break;}
            while(num!=n-1){cout<<'a';++num;}
            cout<<endl;
        }
        else    cout<<"YES"<<endl;
    }
    return 0;
}

```

这题WA了几次，结果发现是set没有在每次循环开始前清空，我真服了。。。

以后得注意初始化的问题。
