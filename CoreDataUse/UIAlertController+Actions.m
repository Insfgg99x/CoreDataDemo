//
//  UIAlertController+Actions.m
//  CoreDataUse
//
//  Created by 夏桂峰 on 16/4/24.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import "UIAlertController+Actions.h"

@implementation UIAlertController (Actions)

-(void)addActions:(NSArray<UIAlertAction *> *)actions{
    if(actions.count==0)
        return;
    for(UIAlertAction *action in actions){
        [self addAction:action];
    }
}

@end
