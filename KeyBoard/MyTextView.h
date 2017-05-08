//
//  MyTextView.h
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceKeyBoard.h"
#import "FunctionKeyBoard.h"
typedef void(^TextViewSendMessage)(NSString * text);

typedef NS_ENUM(NSInteger,KeyBoardMode)
{
    KeyBoardModeSystem,
    KeyBoardModeFace,
    KeyBoardModeFunc,
    KeyBoardModeRecord
};

@protocol MyTextViewDelegate;

@interface MyTextView : UITextView
@property (nonatomic,strong) TextViewSendMessage textViewSendBlock;
@property (nonatomic,weak) id<MyTextViewDelegate> delegate;
- (void)changeKeyBoardWithMode:(KeyBoardMode)mode;
@end

@protocol MyTextViewDelegate <UITextFieldDelegate>

@optional
//使用此方法继续向上传递

-(void)myTextView:(MyTextView *)mtv didtapFuncBtn:(FuncKeyBoardBtnTag)tag;

@end