#import <Cephei/HBPreferences.h>
#import "version.h"


static NSString *phoneNumber;
static NSString *duration;
static NSString *hoursString;
static NSString *minutesString;
static BOOL past;
static BOOL outgoing;
static BOOL disableAddCall;


static void nz9_prefChanged() {
  HBPreferences *settings = [[HBPreferences  alloc] initWithIdentifier:@"com.neinzedd9.FakeCallHistory"];

  phoneNumber = [settings objectForKey:@"phoneNumber"];
  duration = [settings objectForKey:@"duration"];
	hoursString = [settings objectForKey:@"hours"];
	minutesString = [settings objectForKey:@"minutes"];
	past = [settings boolForKey:@"pastSwitch"];
  outgoing = [settings boolForKey:@"outgoingSwitch"];
  disableAddCall = [settings boolForKey:@"disableAddCallSwitch"];
}

@interface CHRecentCall : NSObject
@property (nonatomic) unsigned int callType;
@property (copy) NSString *callerId;
@property (copy) NSDate *date;
@property double duration;
@property int callStatus;
@end

@interface CHManager : NSObject
@property (copy) NSArray *recentCalls;
- (void)addToCallHistory:(CHRecentCall *)arg1;
- (void)flush;
@end

static CHManager *manager;

static void nz9_addFakeCall() {
	CHRecentCall *fakeCall = [[%c(CHRecentCall) alloc] init];
	fakeCall.callType = 1;
	int hours = [hoursString intValue];
	int minutes = [minutesString intValue];
	int timeInterval = (3600*hours) + (60*minutes);
	if(past) {
		timeInterval = (-1*timeInterval);
	}
  if(outgoing) {
    fakeCall.callStatus = 2;
  }
	fakeCall.date = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
	fakeCall.duration = [duration intValue];
	fakeCall.callerId = phoneNumber;
	[manager addToCallHistory:fakeCall];
	[manager flush];
  HBPreferences *settings = [[HBPreferences  alloc] initWithIdentifier:@"com.neinzedd9.FakeCallHistory"];
  [settings setBool:NO forKey:@"disableAddCallSwitch"];
}

%hook CHManager

- (id)init {
	%orig;
	manager = self;
	return self;
}

%end

%group iOS10
%hook MPRecentsTableViewController

- (void)loadView {
	%orig;
  if(manager && disableAddCall) {
		nz9_addFakeCall();
	}
}

%end
%end


%group iOS9
%hook PHRecentsViewController

- (void)loadView {
	%orig;
	if(manager && disableAddCall) {
		nz9_addFakeCall();
	}
}

%end
%end


%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)nz9_prefChanged, CFSTR("NZ9FakeCallHistoryPreferencesChangedNotification"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  if(IS_IOS_OR_NEWER(iOS_10_0)) {
		%init(iOS10);
	}
	else {
		%init(iOS9);
	}
  %init(_ungrouped);
	nz9_prefChanged();
}
