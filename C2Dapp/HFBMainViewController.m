//
//  HFBMainViewController.m
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "HFBMainViewController.h"
#import "HFBShopViewController.h"
#import "JSONModelLib.h"
#import "HFBDataModel.h"
#import "HFBFeed.h"

@interface HFBMainViewController () {

    HFBFeed* _feed;

}

@end

@implementation HFBMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //GPS
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"shopViewSegue"]) {
        HFBShopViewController *controller = (HFBShopViewController *)segue.destinationViewController;
        
        NSArray *results = _feed.results;
        controller.results = results;
    }
    //DO GPS SENDY STUFF
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
