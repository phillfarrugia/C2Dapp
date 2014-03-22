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
    
    // Fetch Data from Google Places API
    _feed = [[HFBFeed alloc] initFromURLWithString:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+Sydney&sensor=true&key=AIzaSyBmGfUedBA9Zm61R8KH9asr8Nf7arolcIc"
                                        completion:^(JSONModel *model, JSONModelError *err) {
                                            
                                            // Display in console
                                            NSLog(@"%@", _feed.results);
                                            
                                        }];
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"shopViewSegue"]) {
        HFBShopViewController *controller = (HFBShopViewController *)segue.destinationViewController;
        
        NSArray *results = _feed.results;
        controller.results = results;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
