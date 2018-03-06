#import <UIKit/UIKit.h>
#define PLIST_PATH @"/Library/PreferenceLoader/Preferences/NostalgiaPrefs.plist"
#define imgPath @"/Library/PreferenceBundles/NostalgiaPrefs.bundle/ccwall.png"
#define imgModulePath @"/Library/PreferenceBundles/NostalgiaPrefs.bundle/ccmodule.png"
bool kEnabled = YES;
UIImageView *imgView = [[UIImageView alloc] init];
UIImageView *moduleImgView = [[UIImageView alloc] init];
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
  //Deleted until tweak is working properly [[prefs objectForKey:@"enabled"] boolValue]
  {
	//Changing the CC background
	MTMaterialView *MTView = MSHookIvar<MTMaterialView *>(self, "_backgroundView");
  imgView.image = [UIImage imageWithContentsOfFile:imgPath];
  UIView *picView = MSHookIvar<UIView *>(MTView, "_backdropView");
  [imgView setFrame:picView.frame];
  [picView insertSubview:imgView atIndex:0];

  }
}
-(void)presentAnimated:(BOOL)arg1 withCompletionHandler:(/*^block*/id)arg2{
 %orig;
  [UIImageView animateWithDuration:0.5 delay:0 options:0 animations:^{
  imgView.alpha = 1.0;}
  completion:0];
}
-(void)dismissAnimated:(BOOL)arg1 withCompletionHandler:(/*^block*/id)arg2{
 %orig;
  [UIImageView animateWithDuration:0.5 delay:0 options:0 animations:^{
  imgView.alpha = 0.0;}
  completion:0];
}
%end

//This code isn't working because it's not accessing the right views
%hook CCUIContentModuleContainerView
-(void)viewDidLoad{
%orig;
MTMaterialView *MTModuleView = MSHookIvar<MTMaterialView *>(self, "_moduleMaterialView");
UIView *picModuleView = MSHookIvar<UIView *>(MTModuleView, "_backdropView");
moduleImgView.image = [UIImage imageWithContentsOfFile:imgModulePath];
[moduleImgView setFrame:picModuleView.frame];
[picModuleView insertSubview:moduleImgView atIndex:0];
}
%end
