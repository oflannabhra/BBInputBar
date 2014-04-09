//
//  BDInputBar.h
//  Sheet
//
//  Created by Benni on 05.02.14.
//  Copyright (c) 2014 BD. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, BBInputBarAnimation)
{
    BBInputBarAnimationNone,
    BBInputBarAnimationFade
};


@class BBInputBar;

@protocol BDInputBarDelegate <NSObject>
@optional
- (CGFloat)inputBar:(BBInputBar*)inputBar widthForButtonAtIndex:(NSInteger)index;
- (CGFloat)inputBar:(BBInputBar*)inputBar backgroundColorForButtonAtIndex:(NSInteger)index;

- (void)inputBar:(BBInputBar*)inputBar didPressButtonAtIndex:(NSInteger)index;
@end


@interface BBInputBar : UIInputView

@property (nonatomic, weak) id<BDInputBarDelegate> delegate;

- (instancetype)initWithTitles:(NSArray*)titles;
- (instancetype)initWithImages:(NSArray*)images;
- (instancetype)initWithTitles:(NSArray*)titles images:(NSArray*)images;

- (void)setTitle:(NSString*)title atIndex:(NSInteger)index;
- (void)setImage:(UIImage*)image atIndex:(NSInteger)index;
- (void)setTitle:(NSString*)title image:(UIImage*)image atIndex:(NSInteger)index;

- (void)updateTitles:(NSArray*)titles animation:(BBInputBarAnimation)animation;
- (void)updateImages:(NSArray*)images animation:(BBInputBarAnimation)animation;
- (void)updateTitles:(NSArray*)titles images:(NSArray*)images animation:(BBInputBarAnimation)animation;

@end
