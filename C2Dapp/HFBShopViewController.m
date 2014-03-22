//
//  HFBShopViewController.m
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "HFBShopViewController.h"
#import "JSONModelLib.h"
#import "HFBDataModel.h"
#import "HFBFeed.h"

@interface HFBShopViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shopTitle;
@property (weak, nonatomic) IBOutlet UILabel *shopAddress;

@end

@implementation HFBShopViewController

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
    // Log data in console
    NSLog(@"OMG DATA \n %@", self.results);
    
    // Get a random object from data
    int dataRange = [self.results count];
    int random = arc4random_uniform(dataRange);
    NSDictionary *info = [self.results objectAtIndex:random];
    
    self.shopTitle.text = [info valueForKey:@"name"];
    self.shopAddress.text = [info valueForKey:@"formatted_address"];

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
