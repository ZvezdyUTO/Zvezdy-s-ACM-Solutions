# 最大为 N 的数字组合

所有者: Zvezdy
标签: 数位动态规划
创建时间: 2024年6月26日 16:46

题目给出的条件是，不能大于目标数，那不大于目标数能有什么放法？首先，判断一个数是否小于目标数就是看两个数的位数，如果位数相同的时候，就从最高位开始依次往下看。

接下来进行数位动态规划，先分析所有可能性，我们是按照位数一位一位放数字，并且已知最高位影响最低位，所以我们考虑从最高位开始放起，以便于抵消后效性。那么对于每一步我们都有三种选择：1.不放，直接跳到下一位，那么就代表后面的可以任选了。2.放置一个比当前位小的数字，那么后面的同样可以任选。3.放置一个跟当前位同样的数字（如果有的话），那么后面的数字就不能任意放了，还得重复判断是否相同。

```cpp
class Solution {
public:
    int atMostNGivenDigitSet(vector<string>& digits, int n) {
        int tmp = n/10, offset = 1, len = 1;
        while (tmp) {
            tmp /= 10;
            offset *= 10;
            ++len;
        }

        function<int(int, int, bool, bool)> f = [&](int offset, int len, bool free, bool zero) {
            if (len == 0) {
                return zero?0:1;
            }
            int cur = n / offset % 10;
            int ans = 0;
            if (zero){
                ans += f(offset / 10, len - 1, true, true);
            }
            if (free){
                ans += digits.size() * f(offset / 10, len - 1, true, false);
            } else {
                for (auto i : digits) {
                    int j = (i[0] - '0');
                    if (j < cur){
                        ans += f(offset / 10, len - 1, true, false);
                    }
                    else if (j == cur){
                        ans += f(offset / 10, len - 1, false, false);
                    }
                    else break;
                }
            }
            return ans;
        };

        return f(offset, len, false, true);
    }
};

```

优化一下，可以发现如果可以任选了后面就没必要一直递归下去重复计算了，所以预处理出幂数组来优化：

```cpp
class Solution {
public:
    int atMostNGivenDigitSet(vector<string>& digits, int n) {
        int tmp = n/10, offset = 1, len = 1;
        while (tmp) {
            tmp /= 10;
            offset *= 10;
            ++len;
        }
        int pre[len];
        pre[0]=1;
        int ans=0;
        for(int i=1,k=digits.size(); i<len; ++i,k*=digits.size()){
            pre[i]=k;
            ans+=k;
        }
        
        function<int(int,int)>f=[&](int offset,int len){
            if(len==0) return 1;
            int cur=n/offset%10;
            int res=0;
            for(auto i:digits){
                int j=i[0]-'0';
                if(j<cur) res+=pre[len-1];
                else if(j==cur) res+=f(offset/10,len-1);
                else break;
            }
            return res;
        };
        return ans+f(offset,len);
    }
};

```
