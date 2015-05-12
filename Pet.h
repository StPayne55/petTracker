//
//  Pet.h
//  PetTracker
//
//  Created by Stephen Payne on 5/9/15.
//  Copyright (c) 2015 Stephen Payne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject

//Required attributes for pet object
@property NSString* name;
@property NSString* breed;
@property NSDate* birthdate;

//used for convenience in sorting and deletion
@property NSString* petType;
@property int spotInArray;

@end
