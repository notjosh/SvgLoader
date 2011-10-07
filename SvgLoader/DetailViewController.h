//
//  DetailViewController.h
//  SvgLoader
//
//  Created by Joshua May on 19/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVGView;

@interface DetailViewController : UIViewController {
}

@property (strong, nonatomic) NSString *svgPath;
@property (strong, nonatomic) IBOutlet SVGView *svgView;

@end
