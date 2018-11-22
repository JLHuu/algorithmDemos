###关于爬楼问题的最优算法实现

**爬楼问题：假设有一段n阶的楼梯，每次可以爬1阶或者2阶，问：共有多少种爬楼方式.**

--

*分析问题：假设`n`阶楼梯的爬楼方式有`f(n)`种。</br>当`n=1`时，得到`f(1)=1`;</br>当`n=2`时，得到`f(2)=2`;</br>当`n>2`时,如果第一步走1步的话则有`f(n-1)`种方式，如果第一步走2步的话则有`f(n-2)`种，所以可得:`f(n)=f(n-1)+f(n-2)`;*

分析完毕，接下来就是代码的实现了。</br>
**方案一:</br>**
由分析很容易想到递归的方式来设计代码.设计代码如下:</br>

```c
unsigned long stepWays(unsigned long num){
    if (num == 1) {
        return 1;
    }
    if (num == 2) {
        return 2;
    }
    return stepWays(num-1)+stepWays(num-2);
}
```
运行一下代码测试一下</br>

```c
NSDate *date = [NSDate date];
printf("方式一有%lu种方式",stepWays(45));
NSTimeInterval time = date.timeIntervalSinceNow*-1;
printf("\n耗时:%lfs",time);
```
结果如下：


```
方式一有1836311903种方式
耗时:6.249614s
```
考虑到时间和空间复杂度的问题，显然递归并不是一个好的算法解决方案。所以考虑到不使用递归的方式二来实现。</br>
**方案一:</br>**
根据`f(n)=f(n-1)+f(n-2)`表达式，设计代码如下：

```c
unsigned long stepWays2(unsigned long num){
    if (num == 1) {
        return 1;
    }
    if (num == 2) {
        return 2;
    }
    unsigned long n = 3;
    unsigned long n1 = 1;//f(n-2)
    unsigned long n2 = 2;//f(n-1)
    unsigned long res = 0 ;//f(n)
    while (n <= num) {
        res = n1 + n2;
        n1 = n2;
        n2 = res;
        n ++;
    }
    return res;
}
```
很明显方式二这种设计在复杂度上来说是最优的。验证一下：

```c
NSDate *date = [NSDate date];
printf("方式二共有%lu种方式",stepWays2(45));
NSTimeInterval time = date.timeIntervalSinceNow*-1;
printf("\n耗时:%lfs",time);

```
输出如下：

```
方式二共有1836311903种方式
耗时:0.000023s
```
**验证方式二为最优解**
