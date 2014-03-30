//
//  CMJViewControllerCell.h
//  WildKingdomBoundless
//
//  Created by Claire Jencks on 3/29/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMJViewControllerCell : UICollectionViewCell

//created here, initialized in the .m file
@property (nonatomic) UIImageView *imageView;

@property (nonatomic) NSArray *photo; //this is storing the image data from dictionary within the photosArray

@end
