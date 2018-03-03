#import <UIKit/UIKit.h>
#define PLIST_PATH @"/Library/PreferenceLoader/Preferences/NostalgiaPrefs.plist"
#define imgPath @"/Library/PreferenceBundles/NostalgiaPrefs.bundle/ccwall.png"
bool kEnabled = YES;
static
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

@interface MTMaterialView : UIView
@end

%hook CCUIModularControlCenterOverlayViewController

-(void)viewDidLoad{
%orig;
if(kEnabled == YES)
  //Deleted for testing purposes [[prefs objectForKey:@"enabled"] boolValue]
	//deleted for now(kEnabled == YES)
  {
	//Changing the CC background
	MTMaterialView *MTView = MSHookIvar<MTMaterialView *>(self, "_backgroundView");
	UIView *pic1View = MSHookIvar<UIView *>(MTView, "_backdropView");
	UIImageView *imgView = [[UIImageView alloc] init];
	imgView.image = [UIImage imageWithContentsOfFile:imgPath];
	imgView.alpha = 1; //Experiment to see how it looks with a lil opacity
	[imgView setFrame:pic1View.frame];
	[pic1View insertSubview:imgView atIndex:0];
	//Adding the picture as a subview does not make it fade away like _backdropView does

	//Changing the CC modules (I probably need help with this one)
  }
}

%end
