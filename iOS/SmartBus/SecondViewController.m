//
//  SecondViewController.m
//  SmartBus
//
//  Created by Dian Wen on 4/29/15.
//  Copyright (c) 2015 Dian Wen. All rights reserved.
//

#import "SecondViewController.h"

static NSString * const kPublicWebmapId = @"d0d37e23340042e8abafc509b4cf152d";

@interface SecondViewController ()

@property (nonatomic, strong) AGSWebMap *webMap;
@property (nonatomic, strong) NSString* webmapId;
@property (nonatomic, strong) NSMutableArray* popups;

@end

@implementation SecondViewController
#pragma mark - View lifecycle

// Release any retained subviews of the main view.
- (void)viewDidUnload
{
    self.webMap = nil;
    self.mapView = nil;
    self.webmapId = nil;
    [super viewDidUnload];
}
// in iOS7 this gets called and hides the status bar so the view does not go under the top iPhone status bar
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

// Do any additional setup after loading the view
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.callout.delegate = self;

    self.webMap = [AGSWebMap webMapWithItemId:kPublicWebmapId credential:nil];
    
    // Set self as the webmap's delegate so that we get notified
    // if the web map opens successfully or if errors are encounterer
    self.webMap.delegate = self;
    
    // Open the webmap
    [self.webMap openIntoMapView:self.mapView];
    
}

- (NSString*) bingAppIdForWebMap:(AGSWebMap *)webMap {
    //this delegate method is called when the webmap contains a Bing Maps basemap layer
    //you should return a valid Bing Maps ID so that the basemap can be displayed.
    return @"<your-bingid-goes-here>";
}


- (void) webMap:(AGSWebMap *)webMap didFetchPopups:(NSArray *)popups forExtent:(AGSEnvelope *)extent {
    //hold on to the results
    for (AGSPopup* popup in popups) {
        //disable editing because this sample does not implement any editing functionality.
        //only permit viewing of popups
        popup.allowEdit = NO;
        popup.allowEditGeometry = NO;
        popup.allowDelete = NO;
        [self.popups addObject:popup];
    }
}

- (void) webMap:(AGSWebMap *)webMap didFinishFetchingPopupsForExtent:(AGSEnvelope *)extent {
    
    //show the popups
    AGSPopupsContainerViewController* pvc =
    [[AGSPopupsContainerViewController alloc]initWithPopups:self.popups];
    pvc.delegate = self;
    [self presentViewController:pvc animated:YES completion:nil];
    
}


#pragma  mark - AGSCalloutDelegte methods
- (void) didClickAccessoryButtonForCallout:(AGSCallout *)callout {
    //fetch popups
    [self.webMap fetchPopupsForExtent:callout.mapLocation.envelope];
    
    //reinitialize the popups array that will hold the results
    self.popups = [[NSMutableArray alloc]init];
}


#pragma mark - AGSPopupsContainerDelegate
- (void) popupsContainerDidFinishViewingPopups:(id<AGSPopupsContainer>)popupsContainer {
    [(AGSPopupsContainerViewController*)popupsContainer dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return  YES;
}

@end
