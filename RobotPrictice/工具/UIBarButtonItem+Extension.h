






#import <UIKit/UIKit.h>

#import "UIView+Extension.h"



@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action ;

+(UIBarButtonItem *)itemWithText:(NSString *)str target:(id)target action:(SEL)action;

@end
