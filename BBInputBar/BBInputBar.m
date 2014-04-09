//
//  BDInputBar.m
//  Sheet
//
//  Created by Benni on 05.02.14.
//  Copyright (c) 2014 BD. All rights reserved.
//

#import "BBInputBar.h"

static CGFloat const kDefaultBarHeight = 44.0;
static CGFloat const kDefaultBarWidth = 320.0;
static CGRect const kDefaultBarFrame = {0.0, 0.0, kDefaultBarWidth, kDefaultBarHeight};
static CGFloat const kDefaultButtonHeight = 38.0;
static CGFloat const kDefaultButtonWidth = 26.0;
static CGFloat const kHorizontalButtonSpacing = 6.0;
static CGFloat const kButtonFontSize = 16.0;

static NSString * const kExceptionTitle = @"BBInputBarException";
static NSString * const kExceptionMessageTitleImageNumberMismatch = @"Number of button titles doesn't match number of images";


@interface BBInputBar ()
@property (nonatomic, strong) NSMutableArray *buttons;
@end


@implementation BBInputBar


#pragma mark - Initialization

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleKeyboard];

	if (self)
	{
		[self createButtons:titles.count];

		for (int i = 0; i < titles.count; i++)
		{
			[self setTitle:titles[i] atIndex:i];
		}
    }

    return self;
}

- (instancetype)initWithImages:(NSArray *)images
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleKeyboard];

	if (self)
	{
		[self createButtons:images.count];

		for (int i = 0; i < images.count; i++)
		{
			[self setImage:images[i] atIndex:i];
		}
    }

    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleKeyboard];

	if (self)
	{
		if (titles.count != images.count)
		{
			[NSException raise:kExceptionTitle format:kExceptionMessageTitleImageNumberMismatch];
		}
		else
		{
			[self createButtons:titles.count];

			for (int i = 0; i < titles.count; i++)
			{
				[self setTitle:titles[i] atIndex:i];
				[self setImage:images[i] atIndex:i];
			}
		}
    }

    return self;
}



#pragma mark - Public methods

- (void)setTitle:(NSString *)title atIndex:(NSInteger)index
{
	[self.buttons[index] setTitle:title forState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image atIndex:(NSInteger)index
{
	[self.buttons[index] setImage:image forState:UIControlStateNormal];
}

- (void)updateTitles:(NSArray *)titles animation:(BBInputBarAnimation)animation
{
	
}

- (void)updateImages:(NSArray *)images animation:(BBInputBarAnimation)animation
{

}

- (void)updateTitles:(NSArray *)titles images:(NSArray *)images animation:(BBInputBarAnimation)animation
{

}

#pragma mark - Private methods

- (void)createButtons:(NSInteger)numberOfButtons
{
	for (int i = 0; i < numberOfButtons; i++)
	{
		UIButton *button = [self createKeyboardButton];
		[self.buttons addObject:button];
		[self addSubview:button];
	}
}

- (UIButton*)createKeyboardButton
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.99];
	button.layer.shadowRadius = 0.0;
	button.layer.shadowOpacity = 1.0;
	button.layer.shadowOffset = CGSizeMake(0.0, 1.0);
	button.layer.shadowColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0].CGColor;
	button.layer.cornerRadius = 3.0;
	button.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:24.0];
	button.titleLabel.textAlignment = NSTextAlignmentCenter;

	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

	return button;
}

- (CGSize)calculateButtonSizeAtIndex:(NSInteger)index
{
	CGSize buttonSize = CGSizeZero;

	if ([self.delegate respondsToSelector:@selector(inputBar:widthForButtonAtIndex:)])
	{
		buttonSize = CGSizeMake([self.delegate inputBar:self widthForButtonAtIndex:index], kDefaultButtonHeight);
	}
	else
	{
		buttonSize = CGSizeMake(kDefaultButtonWidth, kDefaultButtonHeight);
	}

	return buttonSize;
}

#pragma mark - UIView

- (void)layoutSubviews
{
	[super layoutSubviews];


	for (UIButton *button in self.buttons)
	{

	}
}


#pragma mark - Accessors

- (NSMutableArray *)buttons
{
	if (!_buttons)
	{
		_buttons = [NSMutableArray new];
	}

	return _buttons;
}

- (void)setDelegate:(id<BDInputBarDelegate>)delegate
{
	if (delegate)
	{
		_delegate = delegate;
	}
}


@end
