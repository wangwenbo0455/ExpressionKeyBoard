//
//  FaceKeyBoard.h
//  KeyBoard
//
//  Created by 王文博 on 16/1/5.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FaceSendMessage)(int tag);

@protocol FaceKeyBoardDelegate;
@protocol FaceKeyBoardDataSource;


@interface FaceKeyBoard : UIView

@property (nonatomic,weak) id<FaceKeyBoardDelegate> delegate;
@property (nonatomic,weak) id<FaceKeyBoardDataSource> dataSource;
@property (strong, nonatomic) FaceSendMessage faceSendMessage;
@end
@protocol FaceKeyBoardDelegate <NSObject>

@optional
/**
 *  当表情按钮被点击时使用
 */
-(void)faceKeyBoard:(FaceKeyBoard *)faceKB didTapFaceItemAtIndex:(NSInteger)index;

@end

@protocol FaceKeyBoardDataSource <NSObject>

@required
//有多少表情需要显示
-(NSInteger)numberOfFaceItemInFaceKeyBoard:(FaceKeyBoard *)faceKB;

//为KB 上的按钮提供图片

-(UIImage *)faceKeyBoard:(FaceKeyBoard *)faceKB faceButtonWithFaceItemAtIndex:(NSInteger)index;

@end