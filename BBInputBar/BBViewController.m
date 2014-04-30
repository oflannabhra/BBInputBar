//
//  BBViewController.m
//  BBInputBar
//
//  Created by Benni on 09.04.14.
//
//

#import "BBViewController.h"
#import "BBInputBar.h"
#import "BBInputBarButton.h"

@interface BBViewController () <BBInputBarDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSArray *buttonTitles;

@end

@implementation BBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.buttonTitles = @[@"!", @"\"", @"§", @"$", @"%", @"&", @"/", @"(", @")"];

	BBInputBar *inputBar = [[BBInputBar alloc] initWithTitles:self.buttonTitles];
	inputBar.delegate = self;
	self.textView.inputAccessoryView = inputBar;
	[self.textView becomeFirstResponder];




}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)inputBar:(BBInputBar *)inputBar didPressButtonAtIndex:(NSInteger)index
{
	NSLog(@"%@", self.buttonTitles[index]);

}

@end
