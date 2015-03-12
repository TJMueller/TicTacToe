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

@property UILabel *currentTappedLabel;

@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *labels;

@property BOOL currentPlayer;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



- (void)findLabelUsingPoint:(CGPoint)point {
    for (UILabel *label in self.labels) {
        if (CGRectContainsPoint(label.frame, point) && [label.text isEqual: @""]) {
            self.currentTappedLabel = label;
            return;
        }
        self.currentTappedLabel = nil;
    }
}


- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender {

    self.pointOfTap = [sender locationInView:self.view];
    // ? allows for an if statement if true x if false O
    [self findLabelUsingPoint:self.pointOfTap];
    if (self.currentTappedLabel == nil) {
        return;
    }

    self.currentTappedLabel.text = (self.currentPlayer? @"X":@"O");
    self.currentTappedLabel.textColor = (self.currentPlayer? [UIColor blueColor]:[UIColor redColor]);
    self.whichPlayerLabel.textColor = (!self.currentPlayer? [UIColor blueColor]:[UIColor redColor]);
    self.currentPlayer = self.currentPlayer == false;
    self.whichPlayerLabel.text = (self.currentPlayer? @"X":@"O");


}


- (void)checkForWinner {
    BOOL isWinner = false;
    if (self.LabelOne.text == self.LabelTwo.text && self.LabelTwo == self.LabelThree) {
        <#statements#>
    }



}













@end
