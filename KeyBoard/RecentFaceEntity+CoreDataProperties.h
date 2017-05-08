//
//  RecentFaceEntity+CoreDataProperties.h
//  KeyBoard
//
//  Created by 王文博 on 16/1/6.
//  Copyright © 2016年 王文博. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RecentFaceEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecentFaceEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *faceindex;

@end

NS_ASSUME_NONNULL_END
