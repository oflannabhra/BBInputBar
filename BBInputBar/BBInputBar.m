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
static CGFloat const kHorizontalButtonSpacing = 6.0;

static NSString * const kExceptionTitle = @"BBInputBarException";
static NSString * const kExceptionMessageTitleImageNumberMismatch = @"Number of button titles doesn't match number of images";
static NSString * const kExceptionMessageTitleInvalidIndex = @"Index out of bounds, use 'addButtonWithTitle:' or 'addButtonWithImage:' instead";


@interface BBInputBar ()
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic) CGFloat *buttonWidthCache;
@end


@implementation BBInputBar


#pragma mark - Initialization

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleDefault];

	if (self)
	{
		[self createButtons:titles.count];
		[self updateTitles:titles];
    }

    return self;
}

- (instancetype)initWithImages:(NSArray*)images
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleDefault];

	if (self)
	{
		[self createButtons:images.count];
		[self updateImages:images];
    }

    return self;
}

- (instancetype)initWithTitles:(NSArray*)titles images:(NSArray *)images
{
    self = [super initWithFrame:kDefaultBarFrame inputViewStyle:UIInputViewStyleDefault];

	if (self)
	{
		[self createButtons:titles.count];
		[self updateTitles:titles images:images];
    }

    return self;
}


#pragma mark - Public methods

- (void)addButtonWithTitle:(NSString*)title
{
	[self createButtons:1];
	[self setTitle:title atIndex:self.buttons.count - 1];
}

- (void)addButtonWithImage:(UIImage*)image
{
	[self createButtons:1];
	[self setImage:image atIndex:self.buttons.count - 1];
}

- (void)setTitle:(NSString*)title atIndex:(NSInteger)index
{
	if (index >= self.buttons.count)
	{
		[NSException raise:kExceptionTitle format:kExceptionMessageTitleInvalidIndex];
	}

	[self.buttons[index] setTitle:title];
	[self generateButtonWidthCache];
}

- (void)setImage:(UIImage*)image atIndex:(NSInteger)index
{
	if (index >= self.buttons.count)
	{
		[NSException raise:kExceptionTitle format:kExceptionMessageTitleInvalidIndex];
	}

	[self.buttons[index] setImage:image];
	[self generateButtonWidthCache];
}


- (void)updateTitles:(NSArray*)titles
{
	for (int i = 0; i < self.buttons.count; i++)
	{
		BBInputBarButton *button = self.buttons[i];
		button.title = titles[i];
	}

	[self generateButtonWidthCache];
}

- (void)updateImages:(NSArray*)images
{
	for (int i = 0; i < self.buttons.count; i++)
	{
		BBInputBarButton *button = self.buttons[i];
		button.image = images[i];
	}

	[self generateButtonWidthCache];
}

- (void)updateTitles:(NSArray*)titles images:(NSArray *)images
{
	if (titles.count != images.count)
	{
		[NSException raise:kExceptionTitle format:kExceptionMessageTitleImageNumberMismatch];
	}
	else
	{
		for (int i = 0; i < self.buttons.count; i++)
		{
			BBInputBarButton *button = self.buttons[i];
			button.image = images[i];
			button.title = titles[i];
		}
	}

	[self generateButtonWidthCache];
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
		BBInputBarButton *button = [BBInputBarButton button];
		[button addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
		[self.buttons addObject:button];
		[self addSubview:button];
	}

	[self generateButtonWidthCache];
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
			BBInputBarButton *button = (BBInputBarButton*)self.buttons[i];
			self.buttonWidthCache[i] = MAX(button.buttonWidth + (2 * kDefaultButtonPadding), kDefaultButtonMinimumWidth);
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
