
//
//  DBManager.m
//  CoreDataUse
//
//  Created by 夏桂峰 on 16/4/24.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import "DBManager.h"
#import <CoreData/CoreData.h>

@interface DBManager()

@property(nonatomic,strong)NSManagedObjectContext *ctxt;

@end

static DBManager *manager=nil;

@implementation DBManager

+(instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager=[[DBManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if(self=[super init]){
     
        [self createDatabase];
    }
    return self;
}
-(void)createDatabase{
    
    _ctxt=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    NSURL *mmodelPath=[[NSBundle mainBundle]URLForResource:@"Student" withExtension:@"momd"];
    NSLog(@"%@",mmodelPath.absoluteString);
    NSManagedObjectModel *mmodel=[[NSManagedObjectModel alloc]initWithContentsOfURL:mmodelPath];
    NSPersistentStoreCoordinator *store=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:mmodel];
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlitePath=[docPath stringByAppendingPathComponent:@"People.db"];
    NSURL *sqliteURL=[NSURL fileURLWithPath:sqlitePath];
    NSLog(@"%@",docPath);
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:nil error:nil];
    _ctxt.persistentStoreCoordinator=store;
}
-(NSArray *)allPeople{
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    return [_ctxt executeFetchRequest:request error:nil];
}
-(People *)isPeopleExist:(NSString *)uid{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"uid=%@",uid];
    request.predicate=pre;
    NSArray *array=[_ctxt executeFetchRequest:request error:nil];
    if(array.count>0){
        return array.firstObject;
    }
    return nil;
}
-(void)insert:(NSString *)name sex:(NSString *)sex age:(NSNumber *)age uid:(NSString *)uid{
    if([self isPeopleExist:uid]){
        return;
    }
    People *people=[NSEntityDescription insertNewObjectForEntityForName:@"People" inManagedObjectContext:_ctxt];
    people.name=name;
    people.sex=sex;
    people.age=age;
    people.uid=uid;
    [_ctxt save:nil];
}
-(void)deletePeopleWithUid:(NSString *)uid{
    People *people=[self isPeopleExist:uid];
    if(!people){
        return;
    }
    [_ctxt deleteObject:people];
    [_ctxt save:nil];
}
-(void)updatePeople:(People *)people name:(NSString *)name age:(NSNumber *)age sex:(NSString *)sex{
    if(![self isPeopleExist:people.uid]){
        return;
    }
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"uid=%@",people.uid];
    request.predicate=pre;
    People *result=[[_ctxt executeFetchRequest:request error:nil] firstObject];
    result.name=name;
    result.sex=sex;
    result.age=age;
    
    [_ctxt save:nil];
}
-(NSArray *)filterSex:(NSString *)sex{
    
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"People"];
    if(sex){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"sex=%@",sex];
        request.predicate=pre;
    }
    return [_ctxt executeFetchRequest:request error:nil];
}
-(NSArray *)sortWithAgeAcsend:(NSComparisonResult)compare{
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"People"];
    BOOL acsend=(compare==NSOrderedAscending);
    if(compare!=NSOrderedSame){
        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"age" ascending:acsend];
        request.sortDescriptors=@[sort];
    }
    return [_ctxt executeFetchRequest:request error:nil];
}
-(NSArray *)fiterSex:(NSString *)sex ageAcsending:(NSComparisonResult)compare{
    
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"People"];
    if(sex){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"sex=%@",sex];
        request.predicate=pre;
    }
    BOOL acsend=(compare==NSOrderedAscending);
    if(compare!=NSOrderedSame){
        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"age" ascending:acsend];
        request.sortDescriptors=@[sort];
    }
    return [_ctxt executeFetchRequest:request error:nil];
}

@end
