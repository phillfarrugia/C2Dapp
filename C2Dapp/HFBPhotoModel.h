//
//  HFBPhotoModel.h
//  C2Dapp
//
//  Created by Phill Farrugia on 22/03/2014.
//  Copyright (c) 2014 hereforbeer.io. All rights reserved.
//

#import "JSONModel.h"

@protocol HFBPhotoModel @end

@interface HFBPhotoModel : JSONModel

@property (strong, nonatomic) NSString* photo_reference;

@end
