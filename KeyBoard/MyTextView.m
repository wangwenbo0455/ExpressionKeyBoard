//
//  MyTextView.m
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "MyTextView.h"
#import "RecentFaceEntity.h"
#import "Coredata Manger.h"
#import <CoreData/CoreData.h>
#define SCREEN_SIZE [[UIScreen mainScreen]bounds].size


@interface MyTextView ()<FaceKeyBoardDataSource,FaceKeyBoardDelegate>

@property (nonatomic,strong) FaceKeyBoard * faceKB;
@property (nonatomic,strong) FunctionKeyBoard * funcKB;
@property (nonatomic,strong) NSArray * faces;
@property (strong, nonatomic) NSManagedObjectContext * context;

@end

@implementation MyTextView

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
    //初始化上下文
    Coredata_Manger * manager = [Coredata_Manger shareCoreDataManager];
    self.context = manager.context;
    
    self.layer.cornerRadius = 5;

    self.faces = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"]];

    self.faceKB = [[FaceKeyBoard alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.width/2.0+40)];
    self.faceKB.backgroundColor = [UIColor whiteColor];
    __weak __block typeof(self) copy_self = self;
    self.faceKB.faceSendMessage = ^(int tag){
        if (tag == 1) {
            if (copy_self.textViewSendBlock) {
                copy_self.textViewSendBlock(copy_self.text);
            }
        }else if(tag == 4)
        {
            NSAttributedString * text = copy_self.attributedText;
            if (![copy_self.text isEqualToString:@""]) {
                text = [text attributedSubstringFromRange:NSMakeRange(0, text.length-1)];
                copy_self.attributedText = text;
            }
        }else if(tag == 3)
        {
            copy_self.text = @"";
            if (copy_self.textViewSendBlock) {
                copy_self.textViewSendBlock(copy_self.text);
            }

        }
        
    };
    self.faceKB.delegate = self;
    self.faceKB.dataSource = self;
    
    self.funcKB = [[FunctionKeyBoard alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.width/2.0+40)];
    self.funcKB.backgroundColor = [UIColor whiteColor];
    
    __weak __block MyTextView * copy_selfFunc = self;
    self.funcKB.tapFuncBtnTag = ^(FuncKeyBoardBtnTag tag)
    {
        [copy_selfFunc.delegate myTextView:copy_selfFunc didtapFuncBtn:tag];
    };

//    self.funcKB.tapFuncBtnTag = ^(FuncKeyBoardBtnTag tag)
//    {
//        [self.delegate myTextView:self didtapFuncBtn:tag];
//
//    };
    
    self.inputView = KeyBoardModeSystem;
}

-(void)changeKeyBoardWithMode:(KeyBoardMode)mode
{
    switch (mode) {
        case KeyBoardModeSystem:
        {
            self.inputView = nil;
            break;
        }
        case KeyBoardModeFace:
        {
            self.inputView = self.faceKB;
            break;
        }
        case KeyBoardModeFunc:
        {
            self.inputView = self.funcKB;
            break;
        }
            
        default:
            break;
    }
    
    if (self.isFirstResponder) {
        [self reloadInputViews];
    }else
    {
        [self becomeFirstResponder];
    }
    
    
}

-(void)coreDaraDelaga
{
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([RecentFaceEntity class])];
    NSArray * list = [self.context executeFetchRequest:request error:nil];
    if (list.count >= 32) {
        [self.context deleteObject:list.lastObject];
        [self.context save:nil];
    }
}

-(void)faceKeyBoard:(FaceKeyBoard *)faceKB didTapFaceItemAtIndex:(NSInteger)index
{
   
    //在此处将点击的表情进行保存
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([RecentFaceEntity class])];
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"faceindex = %ld",index];
    [request setPredicate:pre];
    
    //上下文请求数据
    NSArray * list = [self.context executeFetchRequest:request error:nil];
    RecentFaceEntity * face ;

    if (list.count > 0)
    {
        face = list[0];
        face.date = [NSDate date];//更新点击时间

    }else
    {
        face = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([RecentFaceEntity class]) inManagedObjectContext:self.context];
        face.faceindex = [NSString stringWithFormat:@"%ld",index];
        face.date = [NSDate date];

    }
    [self.context save:nil];
    
    
//    //展示文本
//    NSDictionary * dic = self.faces[index];
//    NSString * name = dic[@"chs"];
//    NSMutableString * mStr = [NSMutableString stringWithString:self.text];
//    [mStr appendString:name];
//    self.text = mStr;

    
//    展示图片
    NSDictionary * dic = self.faces[index];
    NSString * name = dic[@"png"];
    UIImage * image = [UIImage imageNamed:name];
    NSTextAttachment *  attachment = [[NSTextAttachment alloc]init];
    attachment.image = image;
    NSAttributedString * atts = [NSAttributedString attributedStringWithAttachment:attachment];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    [attStr appendAttributedString:atts];
    self.attributedText = attStr;
}

-(NSInteger)numberOfFaceItemInFaceKeyBoard:(FaceKeyBoard *)faceKB
{
    return self.faces.count;
}

-(UIImage *)faceKeyBoard:(FaceKeyBoard *)faceKB faceButtonWithFaceItemAtIndex:(NSInteger)index
{
    NSDictionary * dic = self.faces[index];
    NSString * name = dic[@"png"];
    UIImage * image = [UIImage imageNamed:name];
    return image;
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"1");
//    self.inputView = KeyBoardModeSystem;
//}

@end
