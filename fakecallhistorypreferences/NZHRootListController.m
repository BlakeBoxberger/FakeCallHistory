#include "NZHRootListController.h"

@implementation NZHRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

static int count = 0;

- (void)loadView {
	[super loadView];
	if(count >= 4) {
		UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Enjoying my tweak, \nFake Call History?"
																									message:@"Please consider donating so I can continue to develop tweaks like this! \n-NeinZedd9 <3"
																									preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* dismissAction = [UIAlertAction actionWithTitle:@"Dismiss"
																									style:UIAlertActionStyleDefault
																									handler:^(UIAlertAction * action) {}];
		[alert addAction:dismissAction];
		[self presentViewController:alert animated:YES completion:nil];
		count = 0;
	}
	else {
		count++;
	}
}

@end
