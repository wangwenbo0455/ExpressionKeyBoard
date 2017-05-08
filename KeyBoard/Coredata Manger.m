//
//  Coredata Manger.m
//  Core data
//
//  Created by 刘伟华 on 15/11/23.
//  Copyright © 2015年 Apple Inc. All rights reserved.
//

#import "Coredata Manger.h"

@implementation Coredata_Manger

+ (instancetype)shareCoreDataManager
{
    static Coredata_Manger * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Coredata_Manger alloc]init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //1、获取数据模型文件
        NSURL * modelUrl = [[NSBundle mainBundle]URLForResource:@"Model" withExtension:@"momd"];
        //2、根据数据模型文件创建数据模型对象
        NSManagedObjectModel * managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
        //3、使用数据模型文件创建持久储存协调器
        NSPersistentStoreCoordinator * coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:managedObjectModel];
        //4、创建储存文件
        NSURL * url = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
        NSURL * storeUrl = [url URLByAppendingPathComponent:@"core_1.sqlite"];
        
        //5、通过持久储存器创建或者打开、关闭数据保存文件
        NSError * error = nil;
        NSPersistentStore * p = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:0 error:&error];
        if (p == nil)
        {
            NSLog(@"addPersistentStore Error = %@",error.localizedDescription);
        }
        
        //6、创建托管对象上下文
        NSManagedObjectContext * mContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        //7、把持久储存协调器绑定到上下文上
        [mContext setPersistentStoreCoordinator:coordinator];
        
        self.context = mContext;
        
    }
    return self;
}
@end
