//
//  HFBShopViewController.h
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFBShopViewController : UIViewController

@property (strong, nonatomic) NSArray* results;
- (IBAction)goBackGesture:(id)sender;
- (void)populateTextViewsForDictionary;

@end
