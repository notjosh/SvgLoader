//
//  RootViewController.m
//  SvgLoader
//
//  Created by Joshua May on 19/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "DetailViewController.h"

enum RootViewControllerSections {
    kRootViewControllerSectionSvg = 0,
    kRootViewControllerSectionSkitch,
    NUM_SECTIONS
};

@interface RootViewController (Private)
- (NSArray *)recursivePathsForResourcesOfType:(NSString *)type inDirectory:(NSString *)directoryPath;
- (NSString *)pathForIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootViewController

- (void)dealloc {
    [_svgFiles release], _svgFiles = nil;

    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _svgFiles = [[NSMutableArray alloc] initWithCapacity:NUM_SECTIONS];

        NSString *resourcesDirectory = [[NSBundle mainBundle] bundlePath];
        [_svgFiles addObject:[self recursivePathsForResourcesOfType:@"svg" inDirectory:resourcesDirectory]];
        [_svgFiles addObject:[self recursivePathsForResourcesOfType:@"skitch" inDirectory:resourcesDirectory]];

        //NSAssert(nil == error, @"Error loading SVG files", [error description]);

        NSLog(@"%@", _svgFiles);
    }
    return self;
}

- (NSArray *)recursivePathsForResourcesOfType: (NSString *)type inDirectory: (NSString *)directoryPath {

    NSMutableArray *filePaths = [[NSMutableArray alloc] init];

    NSDirectoryEnumerator *enumerator = [[[NSFileManager defaultManager] enumeratorAtPath:directoryPath] retain] ;

    NSString *filePath;
    
    while (nil != (filePath = [enumerator nextObject])) {
        if( [[filePath pathExtension] isEqualToString:type] ){
            [filePaths addObject:[NSString stringWithFormat:@"%@/%@", directoryPath, filePath]];
        }
    }

    [enumerator release];

    return [filePaths autorelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    detailViewController.svgPath = [self pathForIndexPath:indexPath];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_svgFiles objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"SVG";
        case 1:
            return @"Skitch";
    }

    return @"Unknown";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnotherIdentifier"];

    NSString *errorMessage = [NSString stringWithFormat:@"indexPath.section out of bounds (%d >= %d)", indexPath.section, NUM_SECTIONS];
    NSAssert(indexPath.section < NUM_SECTIONS, errorMessage);

//    cell.textLabel.text = [NSString stringWithFormat:@"%d,%d", indexPath.section, indexPath.row];
    NSString *path = [self pathForIndexPath:indexPath];
    cell.textLabel.text = [path lastPathComponent];
    
    return cell;
}

- (NSString *)pathForIndexPath:(NSIndexPath *)indexPath {
    return [[_svgFiles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

@end
