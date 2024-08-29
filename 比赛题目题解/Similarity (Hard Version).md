# Similarity (Hard Version)

所有者: Zvezdy

构造最长子串相同的不同字符串，仔细想想，其实ab ac ad ae…az，然后bc bd be…都不同，就算弄成ababab acacac adadad这样的串也不同。然后再把字符串中相同的字符拉长，弄成aaabbbaaabbb这种形式就完事了，能够保证最大子串相同。

比较坑的是这题的一些细节条件，比如每个字符串必须不同，还有m可能等于零，也就是每个字符必须不同。特判m=0，m=k的情况即可。
