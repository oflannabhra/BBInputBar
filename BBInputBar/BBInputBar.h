//
//  BDInputBar.h
//  Sheet
//
//  Created by Benni on 05.02.14.
//  Copyright (c) 2014 BD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBInputBar;

@protocol BBInputBarDelegate <NSObject>
@optional
- (CGFloat)inputBar:(BBInputBar*)inputBar widthForButtonAtIndex:(NSInteger)index;
- (void)inputBar:(BBInputBar*)inputBar didPressButtonAtIndex:(NSInteger)index;
@end


@interface BBInputBar : UIInputView

@property (nonatomic, weak) id<BBInputBarDelegate> delegate;

- (instancetype)initWithTitles:(NSArray*)titles;
- (instancetype)initWithImages:(NSArray*)images;
- (instancetype)initWithTitles:(NSArray*)titles images:(NSArray*)images;

- (void)addButtonWithTitle:(NSString*)title;
- (void)addButtonWithImage:(UIImage*)image;

- (void)setTitle:(NSString*)title atIndex:(NSInteger)index;
- (NSString*)getTitleAtIndex:(NSInteger)index;
- (void)setImage:(UIImage*)image atIndex:(NSInteger)index;

- (void)updateTitles:(NSArray*)titles;
- (void)updateImages:(NSArray*)images;
- (void)updateTitles:(NSArray*)titles images:(NSArray*)images;

@end
