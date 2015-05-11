//
//  ViewController.h
//  PetTracker
//
//  Created by Stephen Payne on 5/9/15.
//  Copyright (c) 2015 Stephen Payne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"

@interface ViewController : UIViewController <UITextFieldDelegate>


@property NSMutableArray* petArray;

- (IBAction)addPet:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addPetButton;
- (IBAction)addPetToArray:(UIButton *)sender;

@end

