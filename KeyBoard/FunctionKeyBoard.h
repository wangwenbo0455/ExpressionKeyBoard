//
//  FunctionKeyBoard.h
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FuncKeyBoardBtnTag){
    FunctionKeyBoardBtnImage,
    FunctionKeyBoardBtnCamera,
    FunctionKeyBoardBtnLcation,
    FunctionKeyBoardBtnMoney
};

typedef void(^FuncBlock)(FuncKeyBoardBtnTag tag);

@interface FunctionKeyBoard : UIView

@property (nonatomic,strong) FuncBlock tapFuncBtnTag;

@end
