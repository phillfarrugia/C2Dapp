//
//  HFBLocationErrorViewController.m
//  C2Dapp
//
//  Created by Robin Wohlers-Reichel on 23/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "HFBLocationErrorViewController.h"

@interface HFBLocationErrorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *errorIcon;

@end

@implementation HFBLocationErrorViewController

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
    FAKFontAwesome *alertIcon = [FAKFontAwesome exclamationTriangleIconWithSize:60];
    [alertIcon addAttribute:NSForegroundColorAttributeName value:[UIColor
                                                                    whiteColor]];
    self.errorIcon.image = [alertIcon imageWithSize:CGSizeMake(60, 60)];
    // Do any additional setup after loading the view.
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
