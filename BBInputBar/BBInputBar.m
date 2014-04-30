//
//  BDInputBar.m
//  Sheet
//
//  Created by Benni on 05.02.14.
//  Copyright (c) 2014 BD. All rights reserved.
//

#import "BBInputBar.h"
#import "BBInputBarButton.h"

static CGFloat const kDefaultBarHeight = 54.0;
static CGFloat const kDefaultBarWidth = 320.0;
static CGRect const kDefaultBarFrame = {0.0, 0.0, kDefaultBarWidth, kDefaultBarHeight};
static CGFloat const kDefaultButtonHeight = 38.0;
static CGFloat const kDefaultButtonWidth = 26.0;
static CGFloat const kHorizontalButtonSpacing = 6.0;

static NSString * const kExceptionTitle = @"BBInputBarException";
static NSString * const kExceptionMessageTitleImageNumberMismatch = @"Number of button titles doesn't match number of images";


@interface BBInputBar ()
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic) CGFloat *buttonWidthCache;
@end


@implementation BBInputBar


#pragma mark - Initialization

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleKeyboard];

	if (self)
	{
		[self createButtons:titles.count];
		[self updateTitles:titles animation:BBInputBarAnimationNone];
    }

    return self;
}

- (instancetype)initWithImages:(NSArray *)images
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleKeyboard];

	if (self)
	{
		[self createButtons:images.count];
		[self updateImages:images animation:BBInputBarAnimationNone];
    }

    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleKeyboard];

	if (self)
	{
		[self createButtons:titles.count];
		[self updateTitles:titles images:images animation:BBInputBarAnimationNone];
    }

    return self;
}


#pragma mark - Public methods

- (void)setTitle:(NSString *)title atIndex:(NSInteger)index
{
	[self.buttons[index] setTitle:title];
}

- (void)setImage:(UIImage *)image atIndex:(NSInteger)index
{
	[self.buttons[index] setImage:image];
}


- (void)updateTitles:(NSArray *)titles animation:(BBInputBarAnimation)animation
{
	for (int i = 0; i < self.buttons.count; i++)
	{
		[self.buttons[i] setTitle:titles[i]];
	}
}

- (void)updateImages:(NSArray *)images animation:(BBInputBarAnimation)animation
{
	for (int i = 0; i < self.buttons.count; i++)
	{
		[self.buttons[i] setImage:images[i]];
	}
}

- (void)updateTitles:(NSArray *)titles images:(NSArray *)images animation:(BBInputBarAnimation)animation
{
	if (titles.count != images.count)
	{
		[NSException raise:kExceptionTitle format:kExceptionMessageTitleImageNumberMismatch];
	}
	else
	{
		for (int i = 0; i < self.buttons.count; i++)
		{
			[self.buttons[i] setTitle:titles[i]];
			[self.buttons[i] setImage:images[i]];
		}
	}
}



#pragma mark - Action methods

- (void)handleButtonPress:(BBInputBarButton*)button
{
	NSInteger buttonIndex = [self.buttons indexOfObject:button];
	
	if ([self.delegate respondsToSelector:@selector(inputBar:didPressButtonAtIndex:)])
	{
		[self.delegate inputBar:self didPressButtonAtIndex:buttonIndex];
	}
}

#pragma mark - Private methods

- (void)createButtons:(NSInteger)numberOfButtons
{
	for (int i = 0; i < numberOfButtons; i++)
	{
		BBInputBarButton *button = [self createKeyboardButton];
		[button addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
		[self.buttons addObject:button];
		[self addSubview:button];
	}

	[self generateButtonWidthCache];
}

- (BBInputBarButton*)createKeyboardButton
{

	BBInputBarButton *button = [[BBInputBarButton alloc] initWithFrame:CGRectZero];

	return button;
}

- (void)generateButtonWidthCache
{
	self.buttonWidthCache = malloc(self.buttons.count * sizeof(CGFloat));

	for (int i = 0; i < self.buttons.count; i++)
	{
		if ([self.delegate respondsToSelector:@selector(inputBar:widthForButtonAtIndex:)])
		{
			self.buttonWidthCache[i] = [self.delegate inputBar:self widthForButtonAtIndex:i];
		}
		else
		{
			self.buttonWidthCache[i] = kDefaultButtonWidth;
		}
	}
}

#pragma mark - UIView

- (void)layoutSubviews
{
	[super layoutSubviews];

	CGFloat totalWidth = -kHorizontalButtonSpacing;

	for (int i = 0; i < self.buttons.count; i++)
	{
		totalWidth += self.buttonWidthCache[i] + kHorizontalButtonSpacing;
	}

	CGFloat xPos = CGRectGetMidX(self.frame) - totalWidth / 2;

	for (int i = 0; i < self.buttons.count; i++)
	{
		UIButton *button = self.buttons[i];
		CGSize buttonSize = CGSizeMake(self.buttonWidthCache[i], kDefaultButtonHeight);
		CGRect buttonFrame = CGRectMake(xPos, CGRectGetHeight(self.frame) - kDefaultButtonHeight - 4.0, buttonSize.width, buttonSize.height);
		button.frame = buttonFrame;

		xPos += buttonSize.width + kHorizontalButtonSpacing;
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

- (void)setDelegate:(id<BBInputBarDelegate>)delegate
{
	if (delegate)
	{
		_delegate = delegate;

		[self generateButtonWidthCache];
	}
}


#pragma mark - Cleanup

- (void)dealloc
{
	free(self.buttonWidthCache);
}



@end
