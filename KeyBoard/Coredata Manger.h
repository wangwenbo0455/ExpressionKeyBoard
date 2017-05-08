//
//  Coredata Manger.h
//  Core data
//
//  Created by 刘伟华 on 15/11/23.
//  Copyright © 2015年 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface Coredata_Manger : NSObject

@property (strong, nonatomic) NSManagedObjectContext * context;

+ (instancetype)shareCoreDataManager;




@end
