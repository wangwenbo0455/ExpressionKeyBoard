//
//  FunctionKeyBoard.m
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "FunctionKeyBoard.h"

@implementation FunctionKeyBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadModle];
    }
    return self;
}

-(void)loadModle
{
    /**
     *  添加相关功能组件
     */
    UIButton * camarebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    camarebtn.frame = CGRectMake(20, 20, 80, 80);
    camarebtn.tag = FunctionKeyBoardBtnCamera;
    [camarebtn setImage:[UIImage imageNamed:@"camare.png"] forState:UIControlStateNormal];
    [camarebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [camarebtn addTarget:self action:@selector(tapFuncBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:camarebtn];
    
    UIButton * tubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tubtn.frame = CGRectMake(110, 20, 80, 80);
    tubtn.tag = FunctionKeyBoardBtnImage;
    [tubtn setImage:[UIImage imageNamed:@"tu.png"] forState:UIControlStateNormal];
    [tubtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [tubtn addTarget:self action:@selector(tapFuncBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tubtn];
    
    UIButton * ditubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ditubtn.frame = CGRectMake(200, 20, 80, 80);
    ditubtn.tag = FunctionKeyBoardBtnLcation;
    [ditubtn setImage:[UIImage imageNamed:@"ditu.png"] forState:UIControlStateNormal];
    [ditubtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [ditubtn addTarget:self action:@selector(tapFuncBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ditubtn];
    
    UIButton * redbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    redbtn.frame = CGRectMake(290, 20, 80, 80);
    redbtn.tag = FunctionKeyBoardBtnMoney;
    [redbtn setImage:[UIImage imageNamed:@"hongbao.png"] forState:UIControlStateNormal];
    [redbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [redbtn addTarget:self action:@selector(tapFuncBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:redbtn];
}

-(void)tapFuncBtn:(UIButton *)btn
{
    if (self.tapFuncBtnTag) {
        self.tapFuncBtnTag(btn.tag);
    }
}

@end
