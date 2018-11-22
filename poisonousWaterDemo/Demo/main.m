//
//  main.m
//  Demo
//
//  Created by 光宇开发 on 2018/11/22.
//  Copyright © 2018 JL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottleWater : NSObject
// 是否有毒
@property (nonatomic,assign) BOOL poisonous;
@property (nonatomic,assign) NSUInteger num; // 编号
@end
@implementation BottleWater
-(NSString *)description
{
    return [NSString stringWithFormat:@"%lu号瓶子,%@毒",_num,_poisonous?@"有":@"无"];
}
@end

@interface Mouse : NSObject
// 是否中毒
@property (nonatomic,readonly,assign) BOOL poisoning;
@property (nonatomic,assign) NSUInteger num;// 编号
@property (nonatomic,readonly,getter=nextDayStatus) BOOL isLiving;
@end
@implementation Mouse
@synthesize poisoning = _poisoning;

- (void)drinkWater:(BottleWater *)water
{
    if (water.poisonous) {
        _poisoning = YES;
    }
}
- (BOOL)nextDayStatus
{
    return !_poisoning;
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%lu号老鼠%@中毒",_num,_poisoning?@"":@"未"];
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 创建瓶子
        NSMutableArray <BottleWater *>*waters = [NSMutableArray arrayWithCapacity:1];
        int poisoningNum = arc4random()%15+1;
        NSLog(@"第%d瓶有毒",poisoningNum);
        for (int i=1; i<=15; i++) {
            BottleWater *water = [[BottleWater alloc] init];
            water.num = i;
            if (i == poisoningNum) {
                water.poisonous = YES;
            }
            [waters addObject:water];
        }
        // 创建老鼠
        NSMutableArray <Mouse *>*mouses = [NSMutableArray arrayWithCapacity:1];
        for (int i=1; i<=4; i++) {
            Mouse *mouse = [[Mouse alloc] init];
            mouse.num = i;
            [mouses addObject:mouse];
        }
        // 分析：每瓶水对于每只老鼠来说都有喝或者不喝两种状态
        // 4只老鼠对于每瓶水都可以有 0000 -> 1111 16中状态
        // 由于要确认有毒，所以舍弃掉第一种都不喝的状态（0000）
        // 剩余15中状态正好与15个瓶子一一对应
        // 所以我们可以取瓶子编号的后4位(0001->1111)来对应4只
        // 老鼠是否喝这瓶水的状态 0代表喝 1代表不喝
        // 最后根据4只老鼠的中毒状态来代表4个bits就可以得到哪个瓶子有毒了
        //----------------------------------------
        // 代码
        for (UInt8 i=1; i<=waters.count; i++) {
            UInt8 index1,index2,index3,index4;
            // 取位
            index1 = i & 1; // 第一个老鼠是否喝
            index2 = i & 2; // 第二个老鼠是否喝
            index3 = i & 4; // 第三个老鼠是否喝
            index4 = i & 8; // 第四个老鼠是否喝
            if (index1) {
                [mouses[0] drinkWater:waters[i-1]];
            }
            if (index2) {
                [mouses[1] drinkWater:waters[i-1]];
            }
            if (index3) {
                [mouses[2] drinkWater:waters[i-1]];
            }
            if (index4) {
                [mouses[3] drinkWater:waters[i-1]];
            }
        }
        // 验证
        // 假设一天后
        UInt8 number = 0; // 有毒的瓶子
        for (UInt i=0; i<mouses.count; i++) {
            NSLog(@"%@",mouses[i]);
            UInt8 j = mouses[i].isLiving ? 0 : 1 << i;
            number |= j;
        }
        NSLog(@"-------------------");
        NSLog(@"有毒的瓶子编号是:%d",number);
    }
    return 0;
}
