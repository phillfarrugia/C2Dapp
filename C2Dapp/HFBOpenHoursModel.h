//
//  HFBOpenHoursModel.h
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "JSONModel.h"

@interface HFBOpenHoursModel : JSONModel

@property (assign, nonatomic) BOOL open_now;
@property (strong, nonatomic) NSArray* periods;


@end
