//
//  SecondViewController.h
//  SmartBus
//
//  Created by Dian Wen on 4/29/15.
//  Copyright (c) 2015 Dian Wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@interface SecondViewController : UIViewController <AGSWebMapDelegate, AGSCalloutDelegate, AGSPopupsContainerDelegate>
@property (weak, nonatomic) IBOutlet AGSMapView *mapView;


@end

