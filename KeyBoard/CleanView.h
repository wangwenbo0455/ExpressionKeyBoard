//
//  CleanView.h
//  KeyBoard
//
//  Created by 王文博 on 16/1/6.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"
typedef void(^CleanBlock)(int tag);

@interface CleanView : UIView
@property (nonatomic,strong) CleanBlock cleanViewBlock;
@end
