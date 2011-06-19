//
//  DetailViewController.m
//  SvgLoader
//
//  Created by Joshua May on 19/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

#import "SVGDocument.h"
#import "SVGView.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize svgPath = _svgPath;
@synthesize svgView = _svgView;

- (void)dealloc {
    [_svgPath release], _svgPath = nil;
    [_svgView release], _svgView = nil;

    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Load SVG
- (void)configureView {
    if (nil == _svgPath) {
        NSLog(@"No _svgPath, bailing from configureView");
        return;
    }

    NSLog(@"Attempting to load _svgPath: %@", _svgPath);

    SVGDocument *document = [SVGDocument documentWithContentsOfFile:_svgPath];
	
	self.svgView.bounds = CGRectMake(0.0f, 0.0f, document.width, document.height);
	self.svgView.document = document;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
