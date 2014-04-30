//
//  BBInputBarButton.m
//  BBInputBar
//
//  Created by Benni on 11.04.14.
//
//

#import "BBInputBarButton.h"

@interface BBInputBarButton ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BBInputBarButton


#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
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
			UIImage *backgroundImageHightlighted = [UIImage imageNamed:@"backgroundImageNormal"];
			UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImageNormal highlightedImage:backgroundImageHightlighted];
			
			backgroundImageView;
		});
		
		_titleLabel = ({
			UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			titleLabel.textAlignment = NSTextAlignmentCenter;
			titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:21.5];
			titleLabel.backgroundColor = [UIColor clearColor];
			titleLabel;
		});

		_imageView = ({
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];

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
	backgroundImageFrame.size.height += 1.0;
	self.backgroundImageView.frame = backgroundImageFrame;
	
	self.titleLabel.frame = self.bounds;
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


@end
