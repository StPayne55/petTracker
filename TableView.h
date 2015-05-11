//
//  TableView.h
//  PetTracker
//
//  Created by Stephen Payne on 5/10/15.
//  Copyright (c) 2015 Stephen Payne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableView : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray* petArray;
@property NSMutableArray* filteredArray;
@property NSString* petFilter;

@end
