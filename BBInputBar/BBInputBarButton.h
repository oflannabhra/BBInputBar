//
//  BBInputBarButton.h
//  BBInputBar
//
//  Created by Benni on 11.04.14.
//
//

#import <UIKit/UIKit.h>

extern CGFloat const kDefaultButtonHeight;
extern CGFloat const kDefaultButtonMinimumWidth;
extern CGFloat const kDefaultButtonPadding;


@interface BBInputBarButton : UIControl

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) CGFloat buttonWidth;

@end
