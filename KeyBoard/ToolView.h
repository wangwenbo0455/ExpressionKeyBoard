//
//  ToolView.h
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"

typedef void(^ToolViewFuncBlock)(FuncKeyBoardBtnTag tag);
typedef void(^ToolViewSendMessage)(NSString * text);


@interface ToolView : UIView

@property (nonatomic,strong) ToolViewFuncBlock toolViewFuncBlock;
@property (strong, nonatomic) ToolViewSendMessage sendMessageBlock;


-(void)pingmuzhanyong;
@end
