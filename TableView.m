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

@property (weak, nonatomic) IBOutlet UIImageView *petImage;
@property (weak, nonatomic) IBOutlet UIView *petImageViewContainer;
@property (weak, nonatomic) IBOutlet UILabel *petNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *petBreedLabel;
@property (weak, nonatomic) IBOutlet UILabel *petBirthdateLabel;
@property UIImageView* dogImage;
@property UIImageView* catImage;
@property UIImageView* bothImage;



@end

@implementation TableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-YYYY"];
    
    _dogImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Doge.png"]] ;
    _catImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"625x465_2870939_7548194_1430772522.jpg"]] ;
    _bothImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dogecate.tiff"]] ;
    
    if ([_petFilter isEqualToString:@"cats"]) {
        _petImage.image = _catImage.image;
    }else if ([_petFilter isEqualToString:@"dogs"]){
        _petImage.image = _dogImage.image;
    }else{
        _petImage.image = _bothImage.image;
    }
//    _petArray = [[NSMutableArray alloc]init];
//    Pet* test = [[Pet alloc]init];
//    test.name = @"Chloe";
//    test.breed = @"Saint Bernard";
//    test.birthdate = [formatter dateFromString:@"02-9-2014"];
//    test.petType = @"Dog";
//    [_petArray addObject:test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    _petDetailedView.layer.cornerRadius = 20;
    _petImage.layer.cornerRadius = _petImage.frame.size.width/2;
    _petImage.clipsToBounds = YES;
    [_petImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [_petImage.layer setBorderWidth: 4.0];
    
    


}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"petCell"];
    [cell.textLabel setText:[[_filteredArray objectAtIndex:indexPath.row]name]];
    return cell;
}



-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:.2 delay:0
         usingSpringWithDamping:.8 initialSpringVelocity:2.0f
                        options:0 animations:^{
                           _petImageViewContainer.center = CGPointMake(self.view.bounds.size.width/ 2, _petImageViewContainer.center.y); 
                            
                        } completion:nil];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_filteredArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create formatter object to format birthdate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-YYYY"];
    
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
    
   [self performSelector:@selector(performOperation:) withObject:indexPath afterDelay:0];
    
   

    
}

- (void)performOperation :(NSIndexPath *)indexPath
{
    //display pet's details
    [UIView animateWithDuration:.4 delay:0
         usingSpringWithDamping:.8 initialSpringVelocity:2.0f
                        options:0 animations:^{
                            _petImageViewContainer.transform = CGAffineTransformMakeScale(.5, .5);
                            _petImageViewContainer.center = CGPointMake(_petImageDetailLocation.center.x /2, _petImageDetailLocation.center.y);
                            _petDetailedView.center = CGPointMake(_petImageDetailLocation.center.x+100, _petImageDetailLocation.center.y);
                        } completion:^(BOOL finished) {
  
                            
                        }];


}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController *A = [segue destinationViewController];
    A.petArray = _petArray;
}




@end
