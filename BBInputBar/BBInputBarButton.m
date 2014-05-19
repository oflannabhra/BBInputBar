//
//  BBInputBarButton.m
//  BBInputBar
//
//  Created by Benni on 11.04.14.
//
//

#import "BBInputBarButton.h"


CGFloat const kDefaultButtonHeight = 38.0;
CGFloat const kDefaultButtonMinimumWidth = 26.0;
CGFloat const kDefaultButtonPadding = 4;


@interface BBInputBarButton ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BBInputBarButton


#pragma mark - Initialization

+ (instancetype)button
{
	return [[BBInputBarButton alloc] initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

	if (self)
	{
		self.userInteractionEnabled = YES;
		self.backgroundColor = [UIColor clearColor];
		self.clipsToBounds = NO;
		self.layer.masksToBounds = NO;

		_backgroundImageView = ({
			UIEdgeInsets insets = UIEdgeInsetsMake(3.0, 3.0, 4.0, 3.0);
			UIImage *backgroundImageNormal = [[UIImage imageNamed:@"backgroundImageNormal"] resizableImageWithCapInsets:insets];
			UIImage *backgroundImageHightlighted = [UIImage imageNamed:@"backgroundImageHighlighted"];
			UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImageNormal highlightedImage:backgroundImageHightlighted];
			
			backgroundImageView;
		});
		
		_titleLabel = ({
			UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			titleLabel.textAlignment = NSTextAlignmentCenter;
			titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:21.5];
			titleLabel.backgroundColor = [UIColor clearColor];
			titleLabel.lineBreakMode = NSLineBreakByClipping;
			titleLabel;
		});

		_imageView = ({
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
			imageView.contentMode = UIViewContentModeScaleAspectFit;
			imageView;
		});

		[self addSubview:_backgroundImageView];
		[self addSubview:_imageView];
		[self addSubview:_titleLabel];
	}

	return self;
}


#pragma mark - UIView

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect backgroundImageFrame = self.bounds;
//	backgroundImageFrame.size.height += 1.0;
	self.backgroundImageView.frame = backgroundImageFrame;

	CGRect imageViewFrame;
	CGRect titleLabelFrame;

	if (self.image)
	{
		if (self.title && ![self.title isEqualToString:@""])
		{
			CGRectDivide(self.bounds, &imageViewFrame, &titleLabelFrame, self.bounds.size.height * 0.6, CGRectMinYEdge);
			imageViewFrame = CGRectInset(imageViewFrame, kDefaultButtonPadding, 0);
			self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:7.0];
		}
		else
		{
			imageViewFrame = CGRectInset(self.bounds, kDefaultButtonPadding, 0);
			titleLabelFrame = CGRectZero;
		}
	}
	else
	{
		imageViewFrame = CGRectZero;
		titleLabelFrame = self.bounds;
	}

	self.imageView.frame = imageViewFrame;
	self.titleLabel.frame = titleLabelFrame;
}


#pragma mark - UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.backgroundImageView.highlighted = YES;

	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.backgroundImageView.highlighted = NO;
}


#pragma mark - Accessors

- (CGFloat)buttonWidth
{
	CGFloat buttonWidth = 0.0;

	if (self.image)
	{
		CGFloat rel = self.image.size.height / kDefaultButtonHeight + (2 * kDefaultButtonPadding);
		buttonWidth = self.image.size.width / rel;
	}
	else
	{
		CGSize textSize = [self.title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
		buttonWidth = textSize.width;
	}

	return buttonWidth;
}

- (void)setTitle:(NSString *)title
{
	if (title)
	{
		NSDictionary *attributes = @{
									 NSStrokeWidthAttributeName: @(-2.0)
									 };

		self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
	}
}

- (void)setImage:(UIImage *)image
{
	if (image)
	{
		self.imageView.image = image;
	}
}

- (NSString *)title
{
	return self.titleLabel.attributedText.string;
}

- (UIImage *)image
{
	return self.imageView.image;
}

@end
