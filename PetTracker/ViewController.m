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
@property NSString* filterOption;


@end

@implementation ViewController
-(void)viewDidAppear:(BOOL)animated{
    CGPoint test = CGPointMake(_addPetButton.center.x, _addPetButton.center.y);
    NSLog(@"Button Center:%@", NSStringFromCGPoint(test));
    
    
        //create date formatter for test pet objects
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM-dd-YYYY"];
        
        if (_petArray == nil) {
            
            _petArray = [[NSMutableArray alloc]init];
            Pet* test = [[Pet alloc]init];
            test.name = @"Jaina";
            test.breed = @"Shiba Inu";
            test.birthdate = [formatter dateFromString:@"09-19-2013"];
            test.petType = @"Dog";
            [_petArray addObject:test];
            
            Pet* test2 = [[Pet alloc]init];
            test2.name = @"Mac";
            test2.breed = @"Coon Hound";
            test2.birthdate = [formatter dateFromString:@"12-10-2014"];
            test2.petType = @"Dog";
            [_petArray addObject:test2];
            
            Pet* test3 = [[Pet alloc]init];
            test3.name = @"Chloe";
            test3.breed = @"Saint Bernard";
            test3.birthdate = [formatter dateFromString:@"02-9-2014"];
            test3.petType = @"Dog";
            [_petArray addObject:test3];
            
            Pet* test4 = [[Pet alloc]init];
            test4.name = @"Bella";
            test4.breed = @"Shiba Inu";
            test4.birthdate = [formatter dateFromString:@"03-8-2012"];
            test4.petType = @"Dog";
            [_petArray addObject:test4];
            
            Pet* test5 = [[Pet alloc]init];
            test5.name = @"Fred";
            test5.breed = @"Hemmingway";
            test5.birthdate = [formatter dateFromString:@"07-10-2014"];
            test5.petType = @"Cat";
            [_petArray addObject:test5];
            
            Pet* test6 = [[Pet alloc]init];
            test6.name = @"Tiger";
            test6.breed = @"Snow Lynx";
            test6.birthdate = [formatter dateFromString:@"02-13-2011"];
            test6.petType = @"Cat";
            [_petArray addObject:test6];
            
        }else{
            
           
            
            [UIView animateWithDuration:.3
                             animations:^{
                                 _optionsView.alpha = 1;
                                 _addPetButton.center = _addPetButtonRestingLocation.center;
                                 NSLog(@"%@", NSStringFromCGPoint(CGPointMake(_addPetButton.center.x, _addPetButton.center.y)));
                                 _optionsView.alpha = 1;
                                 _optionsView.center = self.view.center;
                                 
                             }];
            
            NSLog(@"%@", NSStringFromCGPoint(CGPointMake(_addPetButtonRestingLocation.center.x, _addPetButtonRestingLocation.center.y)));
        }
        
        if ([_petArray count] == 0) {
            _noPetsLabel.alpha = 1;
            _noPetsLabel2.alpha = 1;
        }else{
            _noPetsLabel.alpha = 0;
            _noPetsLabel2.alpha = 0;
        }

        //_addPetButton.center = _addPetButtonRestingLocation.center;
    
}
-(void)viewWillAppear:(BOOL)animated{
    _addPetView.alpha = 0;
    _noPetsLabel.alpha = 0;
    _noPetsLabel2.alpha = 0;
    _addPetView.alpha = 0;
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
    
    _filterOption = [[NSString alloc]init];
    _addPetButton.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    
    _petNameField.delegate = self;
    [_petBreedField setDelegate:self];
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addPet:(UIButton *)sender {
    
    _petNameField.text = nil;
    _petBreedField.text = nil;
    _addPetView.alpha = 1;
    _optionsView.alpha=0;
    
}


- (IBAction)addPetToArray:(UIButton *)sender {
    
    Pet* newPet = [[Pet alloc]init];
    
    newPet.name = _petNameField.text;
    newPet.breed = _petBreedField.text;
    newPet.birthdate = _petBirthdatePicker.date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-YYYY"];
    NSLog([formatter stringFromDate:newPet.birthdate]);
    
    if (_petTypePicker.selectedSegmentIndex == 0) {
        newPet.petType = @"Dog";
    }else{
        newPet.petType = @"Cat";
    }
          
    [_petArray addObject:newPet];
    
    
    
    [UIView animateWithDuration:.3
                     animations:^{
                    _addPetView.alpha = 0;
                         _noPetsLabel.alpha = 0;
                         _noPetsLabel2.alpha = 0;
                         _addPetButton.center = _addPetButtonRestingLocation.center;
                         
                         _optionsView.alpha = 1;
                         _optionsView.center = self.view.center;
                         CGPoint test = CGPointMake(_addPetButton.center.x, _addPetButton.center.y);
                         NSLog(@"Button Center:%@", NSStringFromCGPoint(test));
                     }];
    
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"%ld", (long)[sender tag]);
    if ([sender tag] == 1) {
        NSMutableArray* dogsOnly = [[NSMutableArray alloc]init ];
        for (Pet* pet in _petArray) {
            if ([pet.petType isEqualToString:@"Dog"]) {
                [dogsOnly addObject:pet];
            }
        }
        
        TableView *B = [segue destinationViewController];
        B.filteredArray = dogsOnly;
        B.petArray = _petArray;
        B.petFilter = @"dogs";
    }else if([sender tag] == 2) {
        
            NSMutableArray* catsOnly = [[NSMutableArray alloc]init ];
            for (Pet* pet in _petArray) {
                if ([pet.petType isEqualToString:@"Cat"]) {
                    [catsOnly addObject:pet];
                }
            }
            
            TableView *B = [segue destinationViewController];
            B.filteredArray = catsOnly;
            B.petArray = _petArray;
            B.petFilter = @"cats";
    }
    else{
        TableView *B = [segue destinationViewController];
        B.petArray = _petArray;
        B.filteredArray = _petArray;
        B.petFilter = @"both";
    }
}
    

#pragma mark - UITextField Delegate Methods


//Here, I limit the number of characters that can be entered into each textField
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
