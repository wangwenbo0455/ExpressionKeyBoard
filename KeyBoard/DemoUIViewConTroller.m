//
//  DemoUIViewConTroller.m
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//


#import "DemoUIViewConTroller.h"
#import "ToolView.h"
@interface DemoUIViewConTroller ()

@property (nonatomic,strong) ToolView * toolView;
@end

@implementation DemoUIViewConTroller
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.toolView = [[ToolView alloc]initWithFrame:CGRectZero];
    self.toolView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    __weak __block DemoUIViewConTroller * copy_self = self;
    self.toolView.toolViewFuncBlock = ^(FuncKeyBoardBtnTag tag)
    {
        switch (tag) {
            case FunctionKeyBoardBtnImage:
            {
                NSLog(@"点击图片了！");
                break;
                
            }
            case FunctionKeyBoardBtnCamera:
            {
                NSLog(@"点击相机了");
                break;
                
            }
            case FunctionKeyBoardBtnLcation:
            {
                NSLog(@"点击地图了");
                break;
                
            }
            case FunctionKeyBoardBtnMoney:
            {
                NSLog(@"点击红包了");
                break;
                
            }
                
            default:
                break;
        }
    };
    self.toolView.sendMessageBlock = ^(NSString * text){
        NSLog(@"text = %@",text);
    };
    
    [self.view addSubview:self.toolView];
    
    NSArray * c1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_toolView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolView)];
    [self.view addConstraints:c1];
    NSArray * a2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolView(60)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolView)];
    [self.view addConstraints:a2];
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(recieveNoti:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)recieveNoti:(NSNotification *)noti
{
    NSDictionary * dic = noti.userInfo;
    NSValue * value = dic[UIKeyboardFrameEndUserInfoKey];
    CGRect f = [value CGRectValue];
    
    CGRect frame = self.view.frame;
    frame.size.height = f.origin.y;
    self.view.frame = frame;
    [self.view layoutIfNeeded];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   // [self.toolView changeToolViewNormal];
    
    [self.toolView pingmuzhanyong];
    [self.view endEditing:YES];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
