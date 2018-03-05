#import <UIKit/UIKit.h>
#define PLIST_PATH @"/Library/PreferenceLoader/Preferences/NostalgiaPrefs.plist"
#define imgPath @"/Library/PreferenceBundles/NostalgiaPrefs.bundle/ccwall.png"
bool kEnabled = YES;
UIImageView *imgView = [[UIImageView alloc] init];
static
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

@interface MTMaterialView : UIView
@end

@interface CCUIModularControlCenterOverlayViewController : UIViewController
{
	UIView* view;
}
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
  //[MTView removeFromSuperview];
  imgView.image = [UIImage imageWithContentsOfFile:imgPath];
  UIView *pic1View = MSHookIvar<UIView *>(MTView, "_backdropView");
	//imgView.alpha = pic1View.alpha; //Experiment to see how it looks with a lil opacity
  [imgView setFrame:pic1View.frame];
  [pic1View insertSubview:imgView atIndex:0];

	//Adding the picture as a subview does not make it fade away like _backdropView does

	//Changing the CC modules (I probably need help with this one)
  }
}

-(id)_beginPresentationAnimated:(BOOL)arg1 interactive:(BOOL)arg2{
  %orig;
  [UIImageView animateWithDuration:0.5 delay:0 options:0 animations:^{
  imgView.alpha = 1.0;}
  completion:0];

  return self;
}

-(id)_beginDismissalAnimated:(BOOL)arg1 interactive:(BOOL)arg2{
  %orig;
  [UIImageView animateWithDuration:0.5 delay:0 options:0 animations:^{
  imgView.alpha = 0.0;}
  completion:0];

  return self;
}
%end
