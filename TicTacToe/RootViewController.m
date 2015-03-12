//
//  RootViewController.m
//  TicTacToe
//
//  Created by Timothy Mueller on 3/12/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (strong, nonatomic) IBOutlet UILabel *LabelOne;
@property (strong, nonatomic) IBOutlet UILabel *LabelTwo;
@property (strong, nonatomic) IBOutlet UILabel *LabelThree;
@property (strong, nonatomic) IBOutlet UILabel *LabelFour;
@property (strong, nonatomic) IBOutlet UILabel *LabelFive;
@property (strong, nonatomic) IBOutlet UILabel *LabelSix;
@property (strong, nonatomic) IBOutlet UILabel *LabelSeven;
@property (strong, nonatomic) IBOutlet UILabel *LabelEight;
@property (strong, nonatomic) IBOutlet UILabel *LabelNine;
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;

@property CGPoint pointOfTap;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *labels;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];




}



- (void)findLabelUsingPoint:(CGPoint)point {
    for (UILabel *label in self.labels) {
        NSLog(label.text);
    }



}



- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender {

    self.pointOfTap = [sender locationInView:self.view];
    [self findLabelUsingPoint:self.pointOfTap];



}

@end
