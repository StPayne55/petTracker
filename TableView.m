//
//  TableView.m
//  PetTracker
//
//  Created by Stephen Payne on 5/10/15.
//  Copyright (c) 2015 Stephen Payne. All rights reserved.
//

#import "TableView.h"
#import "Pet.h"
#import "ViewController.h"

@interface TableView ()
@property (weak, nonatomic) IBOutlet UIView *petDetailedView;
@property (weak, nonatomic) IBOutlet UIView *petImageDetailLocation;
@property (weak, nonatomic) IBOutlet UIView *petImageViewContainer;
@property (weak, nonatomic) IBOutlet UIImageView *petImage;
@property (weak, nonatomic) IBOutlet UILabel *petNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *petBreedLabel;
@property (weak, nonatomic) IBOutlet UILabel *petBirthdateLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *deletePetButton;
- (IBAction)deletePetButton:(UIButton *)sender;

@property UIImageView* dogImage;
@property UIImageView* catImage;
@property UIImageView* bothImage;
@property NSIndexPath* currentIndex;
@end

@implementation TableView


#pragma mark - View Controller Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    //create date formatter for pet birthday
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-YYYY"];
    
    //set default images for dogs, cats, or both being displayed in the Table
    _dogImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Doge.png"]] ;
    _catImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"625x465_2870939_7548194_1430772522.jpg"]] ;
    _bothImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dogecate.tiff"]] ;
    
    //if viewing ONLY cats, make the cat image default.
    //if viewing ONLY dogs, make the dog image default.
    //otherwise, show cat and dog
    if ([_petFilter isEqualToString:@"cats"]) {
        _petImage.image = _catImage.image;
    }else if ([_petFilter isEqualToString:@"dogs"]){
        _petImage.image = _dogImage.image;
    }else{
        _petImage.image = _bothImage.image;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    
    //this will give us a circular pet image with a border, and rounded edges on the pet's detailed view card.
    _petDetailedView.layer.cornerRadius = 20;
    _petImage.layer.cornerRadius = _petImage.frame.size.width/2;
    _petImage.clipsToBounds = YES;
    [_petImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [_petImage.layer setBorderWidth: 4.0];
}


-(void)viewDidAppear:(BOOL)animated{
    //bring the pet image to the center of the view and animate with spring velocity to give it bounce
    [UIView animateWithDuration:.2 delay:0
         usingSpringWithDamping:.8 initialSpringVelocity:2.0f
                        options:0 animations:^{
                            
                           _petImageViewContainer.center = CGPointMake(self.view.bounds.size.width/ 2, _petImageViewContainer.center.y);
                            
                        }completion:nil];
}


#pragma mark - TableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //there will be a row for each element in the filtered array
    return [_filteredArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set index property equal to the current selected item from the table(for deletion call)
    _currentIndex = indexPath;
    _deletePetButton.alpha = 1;
    
    //create formatter object to format birthdate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-YYYY"];
    
    //change the default image at top to match which ever type of pet was chosen (cat or dog)
    if ([[[_filteredArray objectAtIndex:indexPath.row]petType]  isEqual: @"Dog"]) {
        _petImage.image = _dogImage.image;
    }else{
        _petImage.image = _catImage.image;
    }
    
    //populate chosen pet's information in detail view
    _petNameLabel.text = [[_filteredArray objectAtIndex:indexPath.row]name];
    _petBreedLabel.text = [[_filteredArray objectAtIndex:indexPath.row]breed];
    NSString* birthdate = [formatter stringFromDate:[[_filteredArray objectAtIndex:indexPath.row]birthdate]];
    _petBirthdateLabel.text = [NSString stringWithFormat:@"Born: %@ ", birthdate];
    
    [self performSelector:@selector(animatePetImageView) withObject:nil afterDelay:0];
  
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //use the prototype cell and create a row for each element in the filtered array. If the user is viewing both cats AND dogs, the filtered array will contain all elements of the original array.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"petCell"];
    [cell.textLabel setText:[[_filteredArray objectAtIndex:indexPath.row]name]];
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //pass modified array back to the original view controller
    ViewController *A = [segue destinationViewController];
    A.petArray = _petArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - custom methods

//this animation needs to be called within a separate method call or else the tableview wont respond to the first tap of a cell
- (void)animatePetImageView
{
    //display pet's details and animate with spring velocity to add bounce
    [UIView animateWithDuration:.4 delay:0
         usingSpringWithDamping:.8 initialSpringVelocity:2.0f
                        options:0 animations:^{
                            _petImageViewContainer.transform = CGAffineTransformMakeScale(.5, .5);
                            _petImageViewContainer.center = CGPointMake(_petImageDetailLocation.center.x /2, _petImageDetailLocation.center.y);
                            _petDetailedView.center = CGPointMake(_petImageDetailLocation.center.x+100, _petImageDetailLocation.center.y);
                        } completion:nil];
}


//this will handle pet deletion
- (IBAction)deletePetButton:(UIButton *)sender {
    
    //If a pet is deleted from the filtered array, delete the object with the same index(position) in the original array
    if ([_petFilter isEqualToString:@"cats"] || [_petFilter isEqualToString:@"dogs"]) {
        Pet* temp = [_filteredArray objectAtIndex:_currentIndex.row];
        int position = (int)temp.spotInArray;
        [_filteredArray removeObjectAtIndex:_currentIndex.row];
        [_petArray removeObjectAtIndex:position];
        
    }
    //If the user is viewing all pets currently, just delete from the original array
    else{
        [_petArray removeObjectAtIndex:_currentIndex.row];
    }
    
    //after an element is deleted, each remaining element needs to be re-numbered
    int index = 0;
    for (Pet* pet in _petArray) {
        pet.spotInArray = index;
        index++;
    }
    
    //reload the tableview to reflect the changes
    [_tableView reloadData];
    
    //reset pet image animation and clear card once pet is deleted. When the user selects another pet, the original animation will start up again and populate that pet's details card
    [UIView animateWithDuration:.4 delay:0
         usingSpringWithDamping:.8 initialSpringVelocity:2.0f
                        options:0 animations:^{
                            _petImageViewContainer.transform = CGAffineTransformMakeScale(2, 2);
                            _petImageViewContainer.center = CGPointMake(_petImageDetailLocation.center.x /2, _petImageDetailLocation.center.y);
                            _petDetailedView.center = CGPointMake(_petImageDetailLocation.center.x+75, _petImageDetailLocation.center.y);
                            _petNameLabel.text = @"No Pet Selected";
                            _petBreedLabel.text = @"";
                            _petBirthdateLabel.text = @"";
                            _deletePetButton.alpha = 0;
                        } completion:nil];
}
@end
