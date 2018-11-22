//
//  main.m
//  climbStairsDemo
//
//  Created by 光宇开发 on 2018/11/6.
//  Copyright © 2018 JL. All rights reserved.
//

#import <Foundation/Foundation.h>
// 递归实现
unsigned long stepWays(unsigned long num);
//非递归实现
unsigned long stepWays2(unsigned long num);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDate *date = [NSDate date];
        printf("方式一共有%lu种方式",stepWays(45));
        NSTimeInterval time = date.timeIntervalSinceNow*-1;
        printf("\n耗时:%lfs\n",time);
        
        NSDate *date1 = [NSDate date];
        printf("方式二共有%lu种方式",stepWays2(45));
        NSTimeInterval time1 = date1.timeIntervalSinceNow*-1;
        printf("\n耗时:%lfs\n",time1);
    }
    return 0;
}

unsigned long stepWays(unsigned long num){
    if (num == 1) {
        return 1;
    }
    if (num == 2) {
        return 2;
    }
    return stepWays(num-1)+stepWays(num-2);
}
unsigned long stepWays2(unsigned long num){
    if (num == 1) {
        return 1;
    }
    if (num == 2) {
        return 2;
    }
    unsigned long n = 3;
    unsigned long n1 = 1; //f(n-2)
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
