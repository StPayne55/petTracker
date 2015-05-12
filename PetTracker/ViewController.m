//
//  ViewController.m
//  PetTracker
//
//  Created by Stephen Payne on 5/9/15.
//  Copyright (c) 2015 Stephen Payne. All rights reserved.
//

#import "ViewController.h"
#import "TableView.h"
#import <UIKit/UIKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *allDogsButton;
@property (weak, nonatomic) IBOutlet UILabel *noPetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *noPetsLabel2;
@property (weak, nonatomic) IBOutlet UITextField *petNameField;
@property (weak, nonatomic) IBOutlet UITextField *petBreedField;
@property (weak, nonatomic) IBOutlet UIView *addPetView;
@property (weak, nonatomic) IBOutlet UIDatePicker *petBirthdatePicker;
@property (weak, nonatomic) IBOutlet UILabel *addPetButtonRestingLocation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addPetButtonConstraint;
@property (weak, nonatomic) IBOutlet UISegmentedControl *petTypePicker;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *optionsView;
@property (weak, nonatomic) IBOutlet UIImageView *catImage;
@property (weak, nonatomic) IBOutlet UIImageView *dogImage;
@property (weak, nonatomic) IBOutlet UIImageView *petsImage;
@property (weak, nonatomic) IBOutlet UIButton *addPetToArrayButton;
@property NSString* filterOption;

@end

@implementation ViewController


#pragma mark - View Controller Lifecycle Methods


-(void)viewDidAppear:(BOOL)animated{
    
        //create date formatter for test pet objects
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM-dd-YYYY"];
    
        //here, i'm creating 6 pets manually just for convenience
        if (_petArray == nil) {
            
            //inform the user that there are no pets
            _noPetsLabel.alpha = 1;
            _noPetsLabel2.alpha = 1;
            
            //allocate and initialize the array, then add all the following pets to it...
            _petArray = [[NSMutableArray alloc]init];
            Pet* test = [[Pet alloc]init];
            test.name = @"Jaina";
            test.breed = @"Shiba Inu";
            test.birthdate = [formatter dateFromString:@"09-19-2013"];
            test.petType = @"Dog";
            test.spotInArray = (int)_petArray.count;
            [_petArray addObject:test];
            
            Pet* test2 = [[Pet alloc]init];
            test2.name = @"Mac";
            test2.breed = @"Coon Hound";
            test2.birthdate = [formatter dateFromString:@"12-10-2014"];
            test2.petType = @"Dog";
            test2.spotInArray = (int)_petArray.count;
            [_petArray addObject:test2];
            
            Pet* test3 = [[Pet alloc]init];
            test3.name = @"Chloe";
            test3.breed = @"Saint Bernard";
            test3.birthdate = [formatter dateFromString:@"02-9-2014"];
            test3.petType = @"Dog";
            test3.spotInArray = (int)_petArray.count;
            [_petArray addObject:test3];
            
            Pet* test4 = [[Pet alloc]init];
            test4.name = @"Bella";
            test4.breed = @"Shiba Inu";
            test4.birthdate = [formatter dateFromString:@"03-8-2012"];
            test4.petType = @"Dog";
            test4.spotInArray = (int)_petArray.count;
            [_petArray addObject:test4];
            
            Pet* test5 = [[Pet alloc]init];
            test5.name = @"Fred";
            test5.breed = @"Hemmingway";
            test5.birthdate = [formatter dateFromString:@"07-10-2014"];
            test5.petType = @"Cat";
            test5.spotInArray = (int)_petArray.count;
            [_petArray addObject:test5];
            
            Pet* test6 = [[Pet alloc]init];
            test6.name = @"Tiger";
            test6.breed = @"Snow Lynx";
            test6.birthdate = [formatter dateFromString:@"02-13-2011"];
            test6.petType = @"Cat";
            test6.spotInArray = (int)_petArray.count;
            [_petArray addObject:test6];
            
        }else{
            //if the view is loaded and already has pets in the array, show filtering/viewing options...
            [UIView animateWithDuration:.3
                             animations:^{
                                 _optionsView.alpha = 1;
                                 _addPetButton.center = _addPetButtonRestingLocation.center;
                                 NSLog(@"%@", NSStringFromCGPoint(CGPointMake(_addPetButton.center.x, _addPetButton.center.y)));
                                 _optionsView.alpha = 1;
                                 _optionsView.center = self.view.center;
                                 _noPetsLabel.alpha = 0;
                                 _noPetsLabel2.alpha = 0;
                             }];
        }
}


-(void)viewWillAppear:(BOOL)animated{
    //hide elements that dont necessarily need to be visible yet
    _addPetView.alpha = 0;
    _noPetsLabel.alpha = 0;
    _noPetsLabel2.alpha = 0;
    _addPetView.alpha = 0;
    
    //this will add rounded edges to the options panel and the pet creation card
    _addPetView.layer.cornerRadius = 20;
    _addPetView.layer.shadowOffset = CGSizeMake(2, 2);
    _addPetView.layer.shadowOpacity = 1;
    _optionsView.layer.cornerRadius = 50;
    _optionsView.clipsToBounds = YES;
    _optionsView.alpha = 0;
    
    //customize dog UIImageView
    _dogImage.layer.cornerRadius = _dogImage.frame.size.width/2;
    _dogImage.clipsToBounds = YES;
    [_dogImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [_dogImage.layer setBorderWidth: 2.0];
    
    //customize cat UIImageView
    _catImage.layer.cornerRadius = _catImage.frame.size.width/2;
    _catImage.clipsToBounds = YES;
    [_catImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [_catImage.layer setBorderWidth: 2.0];
    
    //customize all pets UIImageView
    _petsImage.layer.cornerRadius = _petsImage.frame.size.width/2;
    _petsImage.clipsToBounds = YES;
    [_petsImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [_petsImage.layer setBorderWidth: 2.0];
    
    //_filterOption = [[NSString alloc]init];
    _addPetButton.center = CGPointMake(self.view.center.x, self.view.center.y);
    _petNameField.delegate = self;
    [_petBreedField setDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - custom methods


//add pet button pressed
- (IBAction)addPet:(UIButton *)sender {
    
    _petNameField.text = nil;
    _petBreedField.text = nil;
    _addPetView.alpha = 1;
    _optionsView.alpha=0;
    _addPetToArrayButton.enabled=NO;
}

//add the created pet to the array of pets
- (IBAction)addPetToArray:(UIButton *)sender {
    
    Pet* newPet = [[Pet alloc]init];
    newPet.name = _petNameField.text;
    newPet.breed = _petBreedField.text;
    newPet.birthdate = _petBirthdatePicker.date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-YYYY"];
    
    //select animal type based on the selected segment in the segment control
    if (_petTypePicker.selectedSegmentIndex == 0) {
        newPet.petType = @"Dog";
    }else{
        newPet.petType = @"Cat";
    }
    
    //number this pet based on it's location at the end of the array
    newPet.spotInArray = (int)_petArray.count;
    
    //add to array
    [_petArray addObject:newPet];
    
    //show the options for viewing/sorting pets and move 'add pet' button to upper right
    [UIView animateWithDuration:.3
                     animations:^{
                    _addPetView.alpha = 0;
                         _noPetsLabel.alpha = 0;
                         _noPetsLabel2.alpha = 0;
                         _addPetButton.center = _addPetButtonRestingLocation.center;
                         _optionsView.alpha = 1;
                         _optionsView.center = self.view.center;
                     }];
}


#pragma mark - Navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //determine which button triggered segue based on tag value
    //tag 1 - show dogs only
    //tag 2 - show cats only
    if ([sender tag] == 1) {
        //create a new array only containing the dogs from the pet array
        NSMutableArray* dogsOnly = [[NSMutableArray alloc]init ];
        for (Pet* pet in _petArray) {
            if ([pet.petType isEqualToString:@"Dog"]) {
                [dogsOnly addObject:pet];
            }
        }
        //pass this dogs-only array to the tableview controller and segue to it
        TableView *B = [segue destinationViewController];
        B.filteredArray = dogsOnly;
        B.petArray = _petArray;
        B.petFilter = @"dogs";
        
    }else if([sender tag] == 2) {
            //create a new array only containing the cats from the pet array
            NSMutableArray* catsOnly = [[NSMutableArray alloc]init ];
            for (Pet* pet in _petArray) {
                if ([pet.petType isEqualToString:@"Cat"]) {
                    [catsOnly addObject:pet];
                }
            }
            //pass this cats-only arry to the tableview controller and segue to it
            TableView *B = [segue destinationViewController];
            B.filteredArray = catsOnly;
            B.petArray = _petArray;
            B.petFilter = @"cats";
        
    }else{
        //pass entire pet array to tableview controller since the user wants to view ALL pets
        TableView *B = [segue destinationViewController];
        B.petArray = _petArray;
        B.filteredArray = _petArray;
        B.petFilter = @"both";
    }
}
    

#pragma mark - UITextField Delegate Methods

//Here, I limit the number of characters that can be entered into each textField
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //disable the ability to add a pet to the array UNTIL something is entered for name and breed
    if ([_petNameField.text length] ==0 || [_petBreedField.text length]==0) {
        _addPetToArrayButton.enabled = NO;
    }else{
        _addPetToArrayButton.enabled = YES;
    }
    
    //for the name field, the user will NOT be able to enter more than 30 characters
    if (textField == _petNameField) {
        int limit = 29;
        return !([textField.text length]>limit && [string length] > range.length);
    }
    
    //for the breed field, the user will NOT be able to enter more than 50 characters
    else{
        int limit = 49;
        return !([textField.text length]>limit && [string length] > range.length);
    }
}


//Hide keyboard when return is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}



@end
