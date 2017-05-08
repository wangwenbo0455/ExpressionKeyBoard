//
//  CleanView.m
//  KeyBoard
//
//  Created by 王文博 on 16/1/6.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "CleanView.h"
#import "MyTextView.h"

@interface CleanView ()
@property (nonatomic,strong)MyTextView * TextView;
@end

@implementation CleanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.cleanViewBlock) {
        self.cleanViewBlock(KeyBoardModeSystem);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
