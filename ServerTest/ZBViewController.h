//
//  ZBViewController.h
//  ServerTest
//
//  Created by Zac Bowling on 11/29/11.
//  Copyright (c) 2011 i'mhello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBViewController : UIViewController
- (IBAction)runTest:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
