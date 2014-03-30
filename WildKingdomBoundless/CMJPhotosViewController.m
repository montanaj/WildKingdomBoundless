//
//  CMJPhotosViewController.m
//  WildKingdomBoundless
//
//  Created by Claire Jencks on 3/29/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import "CMJPhotosViewController.h"
#import "CMJViewControllerCell.h"


@interface CMJPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSMutableArray *photosArray;

@end

@implementation CMJPhotosViewController

//instancetype - means whatever you're returning from this method is of the same type as the class you're in
-(instancetype)init
{
    
    //making a new collection view layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    
    //these two lines are equal to
    //self = [super initWithCollectionViewLayout:layout];
    //return self;
    
    //passing in the layout we just made
    return (self = [super initWithCollectionViewLayout: layout]);
}
//overriding view did load and setting background color of collectionview
-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //viewcontroller nav bar title
    self.title = @"Flikr Stream";
    //collection view is just another view and has color like any other
    //self.collectionView - if you go the header file of CMJPhotoVC and see that we/it inherits from uicollectionviewcontroller, which, just like tableview controller, it sets up a collectionview for us,  and makes our view controller the delegate and the data source, here, we're setting property of it (with self.)
    //registering a class (uicollectionviewcell class)
    //set reuse ID arbitrarily and match it with dequereusable cell ID down below
    [self.collectionView registerClass:[CMJViewControllerCell class] forCellWithReuseIdentifier:@"photoReuseID"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    self.apiKey = @"b540bffdef2e4be5e90462d0c2bf7cbf";
    self.photosArray = [NSMutableArray new];
    [self SearchForPhotosOnFlickr];
    
}

#pragma mark - CollectionViewDelegate Methods

//total number of rows
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMJViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoReuseID" forIndexPath:indexPath];

    //create the image from the URL - this may need to go into CMJVCCell
    //NSData *imageData = [NSData dataWithContentsOfURL:photosArray[indexPath.row]];
    //UIImage* image = [UIImage imageWithData:imageData];
    //cell.imageView.image = image;
    
    
    //this gets the photo out of the corresponding photoarray and sets on our cell
    //cell.photo = self.photosArray[indexPath.row];
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.photosArray[indexPath.row]];
    UIImage* image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
    
    
    cell.backgroundColor = [UIColor greenColor];
    return cell; 
}



#pragma mark - HELPER METHOD - LOAD FLIKR PHOTOS

-(void)SearchForPhotosOnFlickr
{
    NSString* tags = @"=lions+tigers+bears";
    NSString* texts = @"text=lion+tiger+bears";
    
    //user the flickr photos search url to get the initial JSON data
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&%@&per_page=20&format=json&nojsoncallback=1",self.apiKey,tags,texts]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         NSError *error;
         
         NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
         
         //get the array of dictionary items containing the photo locations
         NSArray* photos = jsonData[@"photos"][@"photo"];
         
         for (NSDictionary* item in photos)
         {
             NSString* photoURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg",item[@"farm"],item[@"server"],item[@"id"],item[@"secret"]];
             
             //store the URL for the photo in an array for use by the collection view
             [self.photosArray addObject:[NSURL URLWithString:photoURL]];
         }
         
         NSLog(@"THIS IS THE PHOTOS ARRAY %@", self.photosArray);
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.collectionView reloadData];
         });
         //[task resume];
     }];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
