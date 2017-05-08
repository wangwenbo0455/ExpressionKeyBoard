//
//  ToolView.m
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "ToolView.h"
#import "CleanView.h"

@interface ToolView ()<MyTextViewDelegate>
@property (nonatomic,strong) MyTextView * textView;
@property (nonatomic,strong) UIButton * yinBtn;
@property (nonatomic,strong) UIButton * yuyinBtn;
@property (nonatomic,strong) UIButton * faceBtn;
@property (nonatomic,strong) UIButton * funcBtn;
@property (nonatomic,strong) UIView * cleanView;
@property (nonatomic,strong) CleanView * clean;
@end

@implementation ToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadModule];
    }
    return self;
}
-(void)loadModule
{
    

    
    _yuyinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_yuyinBtn setImage:[UIImage imageNamed:@"yuyin.png"] forState:UIControlStateNormal];
    _yuyinBtn.frame = CGRectMake(5, 10, 40, 40);
    [self addSubview:_yuyinBtn];
    _yuyinBtn.tag = KeyBoardModeRecord;
    [_yuyinBtn addTarget:self action:@selector(yuyinBtn:) forControlEvents:UIControlEventTouchUpInside];
    
     _yinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_yinBtn setImage:[UIImage imageNamed:@"yin.png"] forState:UIControlStateNormal];
    _yinBtn.frame = CGRectMake(60, 10, 230, 40);
    _yinBtn.layer.cornerRadius = 10;
    [self addSubview:_yinBtn];
    _yinBtn.hidden = YES;
    [_yinBtn addTarget:self action:@selector(tapRecordButton:) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer * longG = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecordButton:)];
    longG.minimumPressDuration = 1;
    [_yinBtn addGestureRecognizer:longG];
    
    
    self.textView = [[MyTextView alloc]initWithFrame:CGRectMake(60, 10, 230, 40)];
    self.textView.backgroundColor = [UIColor grayColor];
    self.textView.layer.cornerRadius = 10;
    [self addSubview:self.textView];
    self.textView.delegate = self;
    
    self.clean = [[CleanView alloc]initWithFrame:CGRectMake(60, 10, 230, 40)];
    self.clean.layer.cornerRadius = 10;
    
    [self addSubview:self.clean];
    
    
    _faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _faceBtn.tag = KeyBoardModeFace;
    [_faceBtn setImage:[UIImage imageNamed:@"face.png"] forState:UIControlStateNormal];
    _faceBtn.frame = CGRectMake(320, 10, 40, 40);
    [self addSubview:_faceBtn];
    [_faceBtn addTarget:self action:@selector(faceBtn:) forControlEvents:UIControlEventTouchUpInside];
   
    
    _funcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _funcBtn.tag = KeyBoardModeFunc;
    [_funcBtn setImage:[UIImage imageNamed:@"func.png"] forState:UIControlStateNormal];
    _funcBtn.frame = CGRectMake(370, 10, 40, 40);
    [self addSubview:_funcBtn];
    [_funcBtn addTarget:self action:@selector(funcBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    __weak __block ToolView * copy_clself = self;
    self.clean.cleanViewBlock = ^(int tag)
    {
        [copy_clself.textView changeKeyBoardWithMode:tag];
        [copy_clself changeToolViewNormal];
    };
    
    self.textView.textViewSendBlock = ^(NSString * text){
        if (copy_clself.sendMessageBlock) {
            copy_clself.sendMessageBlock(text);
        }
    };

//    //当键盘有事件触发时系统会发送通知消息
//    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(recieveNoti:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)changeToolViewNormal
{
    

    self.yuyinBtn.tag = KeyBoardModeRecord;
    [_yuyinBtn setImage:[UIImage imageNamed:@"yuyin.png"] forState:UIControlStateNormal];
    
    self.textView.hidden = NO;
    self.clean.hidden = NO;
    self.yinBtn.hidden = YES;
    
    self.faceBtn.tag = KeyBoardModeFace;
    [_faceBtn setImage:[UIImage imageNamed:@"face.png"] forState:UIControlStateNormal];
    
    self.funcBtn.tag = KeyBoardModeFunc;
    [_funcBtn setImage:[UIImage imageNamed:@"func.png"] forState:UIControlStateNormal];
    
    self.textView.inputView = KeyBoardModeSystem;
}
-(void)pingmuzhanyong
{
    
    self.faceBtn.tag = KeyBoardModeFace;
    [_faceBtn setImage:[UIImage imageNamed:@"face.png"] forState:UIControlStateNormal];
    
    self.funcBtn.tag = KeyBoardModeFunc;
    [_funcBtn setImage:[UIImage imageNamed:@"func.png"] forState:UIControlStateNormal];
    
    self.textView.inputView = KeyBoardModeSystem;

}

-(void)yuyinBtn:(UIButton *)btn
{
    if (btn.tag == KeyBoardModeRecord) {
        [self changeToolViewNormal];
        btn.tag = KeyBoardModeSystem;
        [btn setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
        _yinBtn.hidden = NO;
        self.textView.hidden = YES;
       self.clean.hidden = YES;
        [self.textView endEditing:YES];
        //注销第一响应者 同样效果
        //[self.textView resignFirstResponder];
//        [self.textView changeKeyBoardWithMode:KeyBoardModeSystem];
    }else
    {
        self.clean.hidden = NO;
        [self changeToolViewNormal];
        [self.textView changeKeyBoardWithMode:KeyBoardModeSystem];
    }
}
//录音长按手势

- (void)tapRecordButton:(UILongPressGestureRecognizer *)longG
{
    if (longG.state == UIGestureRecognizerStateBegan)
    {
#warning 添加开始录音
        NSLog(@"开始录音");
    }else if (longG.state == UIGestureRecognizerStateEnded)
    {
#warning 发送录音
        NSLog(@"发送录音");
    }
}

-(void)faceBtn:(UIButton *)btn
{
    if (btn.tag == KeyBoardModeFace) {
        [self changeToolViewNormal];
        self.faceBtn.tag = KeyBoardModeSystem;
        [_faceBtn setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
        [self.textView changeKeyBoardWithMode:KeyBoardModeFace];
    }else
    {
        [self changeToolViewNormal];
        [self.textView changeKeyBoardWithMode:KeyBoardModeSystem];
    }
    
}

-(void)funcBtn:(UIButton *)btn
{
    if (btn.tag == KeyBoardModeFunc) {
        [self changeToolViewNormal];
        self.funcBtn.tag = KeyBoardModeSystem;
        [_funcBtn setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
        [self.textView changeKeyBoardWithMode:KeyBoardModeFunc];
    }else
    {
        [self changeToolViewNormal];
        [self.textView changeKeyBoardWithMode:KeyBoardModeSystem];
    }
}
-(void)myTextView:(MyTextView *)mtv didtapFuncBtn:(FuncKeyBoardBtnTag)tag
{
    if (self.toolViewFuncBlock) {
        self.toolViewFuncBlock(tag);
    }
}



@end
