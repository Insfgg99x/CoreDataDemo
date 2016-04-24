//
//  People.m
//  CoreDataUse
//
//  Created by 夏桂峰 on 16/4/24.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import "People.h"

@implementation People

// Insert code here to add functionality to your managed object subclass

-(NSString *)description{
    
    return [NSString stringWithFormat:@"姓名%@ 性别%@ 年龄%@ 学号%@",self.name,self.sex,self.age,self.uid];
}

@end
