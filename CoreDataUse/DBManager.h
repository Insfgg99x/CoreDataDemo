//
//  DBManager.h
//  CoreDataUse
//
//  Created by 夏桂峰 on 16/4/24.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People.h"

@interface DBManager : NSObject

+(instancetype)shared;

-(NSArray *)allPeople;
-(People *)isPeopleExist:(NSString *)uid;
-(void)insert:(NSString *)name sex:(NSString *)sex age:(NSNumber *)age uid:(NSString *)uid;
-(void)deletePeopleWithUid:(NSString *)uid;
-(void)updatePeople:(People *)people name:(NSString *)name age:(NSNumber *)age sex:(NSString *)sex;
-(NSArray *)filterSex:(NSString *)sex;
-(NSArray *)sortWithAgeAcsend:(NSComparisonResult)compare;
-(NSArray *)fiterSex:(NSString *)sex ageAcsending:(NSComparisonResult)compare;

@end
