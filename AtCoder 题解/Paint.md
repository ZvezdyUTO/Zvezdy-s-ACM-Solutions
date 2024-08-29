# Paint

所有者: Zvezdy
标签: 思维

当一些操作只有后效性而没有前效性的时候，我们就可以考虑逆向推导来使它变得”没有后效性“。

```cpp
#include<bits/stdc++.h>
using namespace std;
#define debug(x) cout << #x << " = " << x << endl;
#define ld long double
#define ll long long
struct control{int t,x,a;}c[200001];
bool hh[200001],ww[200001],ocu[200001]={true};
int hn,wn,ans=0; int h,w,m;
map<int,ll>colour;
void solve(){
    cin>>w>>h>>m;
    for(int i=1;i<=m;++i) cin>>c[i].t>>c[i].a>>c[i].x;
    for(int i=m;i>=1;--i){//从后往前推导
        //如果当前行或列被覆盖就为0，跳过
        //如果没有，则考虑到底有多少已被覆盖，要减掉
        if(c[i].t-1){//列
            if(hh[c[i].a]) continue;
            if(!ocu[c[i].x] && w-wn!=0){
                ocu[c[i].x]=true;
                ++ans;
            }

            colour[c[i].x]+=(w-wn);
            hh[c[i].a]=true;
            ++hn;
        }
        else{//行
            if(ww[c[i].a]) continue;
            if(!ocu[c[i].x] && h-hn!=0){
                ocu[c[i].x]=true;
                ++ans;
            }

            colour[c[i].x]+=(h-hn);
            ww[c[i].a]=true;
            ++wn;
        }
    }
    for(int i=1;i<=h;++i){
        if(hh[i]) continue;
        colour[0]+=(w-wn);
    }
    if(colour[0]) ++ans;
    cout<<ans<<endl;
    for(int i=0;i<=200000;++i)
        if(colour[i]) cout<<i<<" "<<colour[i]<<endl;
}
int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL); cout.tie(NULL);
    int t=1;
//    int t; cin>>t;
    while(t--) solve();
    return 0;
}

```
