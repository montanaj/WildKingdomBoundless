//
//  CMJViewControllerCell.m
//  WildKingdomBoundless
//
//  Created by Claire Jencks on 3/29/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import "CMJViewControllerCell.h"

@implementation CMJViewControllerCell


//override setter for our dictionary
//setPhoto gets called any time anyone writes cell.photo = ...
//-(void)setPhoto:(NSArray *)photo
//{
//    self.photo = photo;
//    
////    NSData *imageData = [NSData dataWithContentsOfURL:photosArray[indexPath.row]];
////    UIImage* image = [UIImage imageWithData:imageData];
////    cell.imageView.image = image;
////
////    NSURL *url = [[NSURL alloc]initWithString:self.photo[@"images"][@"standard_resolution"][@"url"]];
//    
//    [self downloadPhotoWithURL:<#(NSURL *)#>];
//    

//}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code - unlike table view, this is a blank canvas and needs an image view on top
     
        self.imageView = [UIImageView new];
        
        
        //add it to cell content view (otherwise a blank canvas)
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

//a method of UIVIEW
-(void)layoutSubviews
{
    //this sets the imageView to full bounds of the contentView (makes the imageView fill the cell)
    self.imageView.frame = self.contentView.bounds;
    
}

-(void)downloadPhotoWithURL:(NSURL *)url
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {
        NSData *data = [[NSData alloc]initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc]initWithData:data];
        
        //going back to main lane in traffic analogy
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            
        });
    }];
        [task resume];
                             
    
}




@end
