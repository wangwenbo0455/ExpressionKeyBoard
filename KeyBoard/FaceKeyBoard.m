//
//  FaceKeyBoard.m
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "FaceKeyBoard.h"
#import "RecentFaceEntity.h"
#import "Coredata Manger.h"
#import <CoreData/CoreData.h>
@interface FaceKeyBoard ()

@property (nonatomic,strong)UIScrollView * faceScrollView;
@property (nonatomic,strong) UIView * historyView;
@property (nonatomic,strong) UIButton * historyBtn;
@property (nonatomic,strong) UIButton *  defaultBtn;
@property (nonatomic,strong) UIButton * confirmBtn;
@property (nonatomic,strong) UIButton * deleteBtn;
@property (nonatomic,strong) NSManagedObjectContext * context;
@end

@implementation FaceKeyBoard

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
    /**
     *  将表情贴到faceKB上
     */
    self.faceScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.faceScrollView.backgroundColor = [UIColor clearColor];
    self.faceScrollView.pagingEnabled = YES;
    [self addSubview:self.faceScrollView];
    
    self.historyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width/2.0)];
    self.historyView.backgroundColor = [UIColor whiteColor];
    self.historyView.hidden = YES;
    [self addSubview:self.historyView];
    
    self.historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.historyBtn setImage:[UIImage imageNamed:@"lishi.png"] forState:UIControlStateNormal];
    self.historyBtn.backgroundColor = [UIColor clearColor];
    self.historyBtn.tag = 1;
    [self.historyBtn addTarget:self action:@selector(tapFaceFuncButton:) forControlEvents:UIControlEventTouchUpInside];
    self.historyBtn.frame = CGRectMake(20, self.bounds.size.width/2.0, 80, 40);
    [self addSubview:self.historyBtn];
    
    self.defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.defaultBtn setImage:[UIImage imageNamed:@"moren.png"] forState:UIControlStateNormal];
    self.defaultBtn.backgroundColor = [UIColor clearColor];
    self.defaultBtn.tag = 2;
    [self.defaultBtn addTarget:self action:@selector(tapFaceFuncButton:) forControlEvents:UIControlEventTouchUpInside];
    self.defaultBtn.frame = CGRectMake(self.bounds.size.width/4.0, self.bounds.size.width/2.0, 80, 40);
    [self addSubview:self.defaultBtn];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[[UIColor alloc]initWithRed:6/255.0 green:167/255.0 blue:225/255.0 alpha:1] forState:0];
//    self.confirmBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.confirmBtn.tag = 3;
    [self.confirmBtn addTarget:self action:@selector(tapFaceFuncButton:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmBtn.frame = CGRectMake(self.bounds.size.width/4.0*2, self.bounds.size.width/2.0, 80, 40);
    [self addSubview:self.confirmBtn];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor = [UIColor clearColor];
    self.deleteBtn.tag = 4;
    [self.deleteBtn addTarget:self action:@selector(tapFaceFuncButton:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.frame = CGRectMake(self.bounds.size.width/4.0*3.2, self.bounds.size.width/2.0, 80, 40);
    [self addSubview:self.deleteBtn];
    
    
    [self addObserver:self forKeyPath:@"dataSource" options:NSKeyValueObservingOptionNew context:nil];
}

//当点击工具按钮时调用
- (void)tapFaceFuncButton:(UIButton *)btn
{
    switch (btn.tag) {
        case 1://点击历史按钮
        {
            self.historyView.hidden = NO;
            self.faceScrollView.hidden = YES;

            //从数据库中获取所有表情
            NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([RecentFaceEntity class])];
            NSSortDescriptor * sortD = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
            [request setSortDescriptors:@[sortD]];
            NSArray * list = [self.context executeFetchRequest:request error:nil];
            
            //移除历史界面上的所有表情再贴
            NSArray * subViews = self.historyView.subviews;
            
            //            for (UIView * obj in subViews)
            //            {
            //                [obj removeFromSuperview];
            //            }
            
            [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            NSMutableArray * arr = [NSMutableArray arrayWithArray:list];
            
            for (int i=32; i<list.count; i++) {
                [arr removeObject:list[i]];
            }
            
//            if (list.count<33) {
            
                for (int j = 0; j < arr.count; j++)
                {
//                
//                    if (list.count>32) {
//                        
//                        NSArray * subViews = self.historyView.subviews;
//                        
//                        //                                    for (UIView * obj in subViews)
//                        //                                    {
//                        //                                        [obj removeFromSuperview];
//                        //                                    }
//                        
//                        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//                        [self.context deleteObject:list.lastObject];
//
////                        [self.context save:nil];
//
//                    }
                    
                    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    RecentFaceEntity * face;
                    face = arr[j];
                    btn.tag = [face.faceindex intValue];//？？？？为什么不使用j赋值
                    
                    //获取该表情是在第几个
                    int index = j % 32;
                    
                    //第几行
                    int row = index / 8;
                    //第几列
                    int cloumn = index % 8;
                    
                    CGFloat bw = self.bounds.size.width / 8.0;
                    CGFloat x = cloumn * bw;
                    CGFloat y = row * bw;
                    btn.frame = CGRectMake(x, y, bw, bw);
                    UIImage * image = [self.dataSource faceKeyBoard:self faceButtonWithFaceItemAtIndex:btn.tag];
                    [btn setImage:image forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapFaceItem:) forControlEvents:UIControlEventTouchUpInside];
                    [self.historyView addSubview:btn];
                }
//            }else
//            {
//                [self.context deleteObject:list.lastObject];
//            }


            
            
            
            break;
        }
        case 2://点击默认
        {
            self.historyView.hidden = YES;
            self.faceScrollView.hidden = NO;
            break;
        }
        case 3://点击确定
        {
#warning TODO
        
            if (self.faceSendMessage) {
                self.faceSendMessage(3);
            }
            
            break;
        }
        case 4://点击删除
        {
            if (self.faceSendMessage) {
                self.faceSendMessage(4);
            }

            break;
        }
        default:
            break;
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //在此处贴表情
    NSInteger count = [self.dataSource numberOfFaceItemInFaceKeyBoard:self];
    int pages = ceil(count/32.0);
    self.faceScrollView.contentSize = CGSizeMake(self.bounds.size.width*pages, self.bounds.size.height);
    for (int i = 0; i<count; i++) {
        //通过循环将表情贴到btn上
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        
        //当前表情在第几页
        int page = i/32;
        //当前表情在某一页的第几个
        int index = i%32;
        
        //当前表情在哪一行
        int row = index/8;
        int cloumn = index%8;
        
        CGFloat bw = self.bounds.size.width/8.0;
        CGFloat x = page * self.bounds.size.width + cloumn * bw;
        CGFloat y = row * bw;
        button.frame = CGRectMake(x, y, bw, bw);
        
        UIImage * image = [self.dataSource faceKeyBoard:self faceButtonWithFaceItemAtIndex:i];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tapFaceItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.faceScrollView addSubview:button];
    }
}
-(void)tapFaceItem:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(faceKeyBoard:didTapFaceItemAtIndex:)])
    {
        [self.delegate faceKeyBoard:self didTapFaceItemAtIndex:btn.tag];
    }
    
}

@end
