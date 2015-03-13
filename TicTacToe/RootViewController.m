//
//  RootViewController.m
//  TicTacToe
//
//  Created by Timothy Mueller on 3/12/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIAlertViewDelegate>
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

@property CGPoint originalCenter;
@property CGPoint locationOfDrag;
@property NSArray *combinationArray;

@property NSMutableArray *currentMoves;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.whichPlayerLabel.text = @"O";
    self.whichPlayerLabel.textColor = [UIColor redColor];
    self.originalCenter = self.whichPlayerLabel.center;
    self.combinationArray = [NSArray arrayWithObjects:@"123", @"147", @"159", @"258", @"357", @"369", @"456", @"789", nil];
    self.currentMoves = [[NSMutableArray alloc] init];


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


- (void) logicOfChange {

    self.pointOfTap = self.locationOfDrag;
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
    [self checkForWinner];
    [self checkForCatsGame];



}


- (void)checkForWinner {
    BOOL isWinner = false;

    if (self.LabelOne.text == self.LabelTwo.text && self.LabelTwo.text == self.LabelThree.text && ![self.LabelOne.text isEqual: @""]){ isWinner = true; }
    if (self.LabelOne.text == self.LabelFour.text && self.LabelFour.text == self.LabelSeven.text && ![self.LabelOne.text isEqual: @""]){ isWinner = true; }
    if (self.LabelOne.text == self.LabelFive.text && self.LabelFive.text == self.LabelNine.text && ![self.LabelOne.text isEqual: @""]){ isWinner = true; }
    if (self.LabelTwo.text == self.LabelFive.text && self.LabelFive.text == self.LabelEight.text && ![self.LabelTwo.text isEqual: @""]){ isWinner = true; }
    if (self.LabelThree.text == self.LabelFive.text && self.LabelFive.text == self.LabelSeven.text && ![self.LabelThree.text isEqual: @""]){ isWinner = true; }
    if (self.LabelThree.text == self.LabelSix.text && self.LabelSix.text == self.LabelNine.text && ![self.LabelThree.text isEqual: @""]){ isWinner = true; }
    if (self.LabelFour.text == self.LabelFive.text && self.LabelFive.text == self.LabelSix.text && ![self.LabelFour.text isEqual: @""]){ isWinner = true; }
    if (self.LabelSeven.text == self.LabelEight.text && self.LabelEight.text == self.LabelNine.text && ![self.LabelSeven.text isEqual: @""]){ isWinner = true; }

    if (isWinner)
    {

    NSString *currentPlayerString = (!self.currentPlayer? @"X":@"O");

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Winner"
                                                    message:[NSString stringWithFormat:@"The Winner is %@", currentPlayerString]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"New Game", nil];
    [alert show];
        return;
    }
    [self onAITurn];
}

- (void)checkForCatsGame {
    BOOL isCats = true;
    for (UILabel *label in self.labels) {
        if([label.text isEqual:@""])
        {
            isCats = false;
        }
    }
    if (isCats)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cats Game"
                                                        message:@"It's a Draw"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"New Game", nil];
        [alert show];
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self startNewGame];
    }
}


- (void)startNewGame {
    for (UILabel *label in self.labels) {
        label.text = @"";
    }
    self.whichPlayerLabel.text = @"O";
    self.whichPlayerLabel.textColor = [UIColor redColor];
    self.currentPlayer = false;

}


- (IBAction)onPanComplete:(UIPanGestureRecognizer *)gestureRecognizer {
    self.pointOfTap = [gestureRecognizer locationInView:self.view];
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.locationOfDrag = self.whichPlayerLabel.center;
        [self logicOfChange];
        [UIView animateWithDuration:1.0 animations:^{
            self.whichPlayerLabel.center = self.originalCenter;
        }];
    }
    else{
        CGPoint point = [gestureRecognizer locationInView:self.view];
        self.whichPlayerLabel.center = point;

//    }
//    [self findLabelUsingPoint:self.pointOfTap];
//    if (self.currentTappedLabel == nil) {
//        return;
//    }
    }


}


- (void) onAITurn
{
    if (self.currentPlayer) {

        [self getCurrentMoves];

        int winningMove = [self checkForWinningMove];
        int blockingMove = [self checkForBlockingMove];
        int centerMove = [self checkForCenterMove];
        int nextMove = [self checkForNextMove];


        for (UILabel *label in self.labels) {
            if ([label.text isEqual: @""]) {
                label.textColor = (self.currentPlayer? [UIColor blueColor]:[UIColor redColor]);
                label.text = (self.currentPlayer? @"X":@"O");
                self.currentPlayer = self.currentPlayer == false;
                self.whichPlayerLabel.text = (self.currentPlayer? @"X":@"O");
                self.whichPlayerLabel.textColor = (self.currentPlayer? [UIColor blueColor]:[UIColor redColor]);
                [self checkForWinner];
                [self checkForCatsGame];
                return;
            }
        }
    }
}


- (int)checkForCenterMove {
    return [self.LabelFive.text isEqualToString:@""] ? 5 : 0;
}

- (int)checkForNextMove {
    int nextMove = 0;
    int counter = 1;
    for (UILabel *label in self.labels) {
        if ([label.text isEqual: @""]) {
            nextMove = counter;
            break;
        }
        counter++;
    }
    return nextMove;
}

- (int)checkForWinningMove {
    return [self checkForMove:@"OO"];
}

- (int)checkForBlockingMove {
    return [self checkForMove:@"XX"];
}

- (int)checkForMove:(NSString *)winBlockString {
    int winningMove = 0;
    int winningComboIndex = 0;
    int counter = 0;

    // search for winning combo
    for (NSString* currentMove in self.currentMoves) {
        if ([currentMove isEqual:winBlockString]) {
            winningComboIndex = counter;
            break;
        }
        counter++;
    }

    // select winning combo from combo array convert to char array
    if (winningComboIndex > 0) {
        NSArray * winningLabelMoves = [self getWinningLabelArray:winningComboIndex];

        // search for empty text, return that move
        for (NSString *winningLabelMove in winningLabelMoves) {
            if ([((UILabel *)[self.labels objectAtIndex:[winningLabelMove intValue] - 1]).text isEqualToString:@""]) {
                winningMove = [winningLabelMove intValue];
                break;
            }
        }
    }

    return winningMove;
}

- (NSArray *)getWinningLabelArray:(int)winningComboIndex {
    // pass in the winning combination of moves index
    // return an array to foreach through
    NSString *winningLabelString = self.combinationArray[winningComboIndex];
    NSArray *winningLabelMoves = [[NSArray alloc] initWithObjects:[winningLabelString substringToIndex:1],
    [winningLabelString substringWithRange:NSMakeRange(1, 1)],[winningLabelString substringFromIndex:2], nil];

    return winningLabelMoves;
}

- (void)getCurrentMoves {
    // loads all current moves into an array
    // @"123", @"147", @"159", @"258", @"357", @"369", @"456", @"789"    [self.currentMoves removeAllObjects];
    [self.currentMoves addObject:[NSString stringWithFormat:@"%@%@%@", self.LabelOne.text, self.LabelTwo.text, self.LabelThree.text ]];
    [self.currentMoves addObject:[NSString stringWithFormat:@"%@%@%@", self.LabelOne.text, self.LabelFour.text, self.LabelSeven.text ]];
    [self.currentMoves addObject:[NSString stringWithFormat:@"%@%@%@", self.LabelOne.text, self.LabelFive.text, self.LabelNine.text ]];
    [self.currentMoves addObject:[NSString stringWithFormat:@"%@%@%@", self.LabelTwo.text, self.LabelFive.text, self.LabelEight.text ]];
    [self.currentMoves addObject:[NSString stringWithFormat:@"%@%@%@", self.LabelThree.text, self.LabelFive.text, self.LabelSeven.text ]];
    [self.currentMoves addObject:[NSString stringWithFormat:@"%@%@%@", self.LabelThree.text, self.LabelSix.text, self.LabelNine.text ]];
    [self.currentMoves addObject:[NSString stringWithFormat:@"%@%@%@", self.LabelFour.text, self.LabelFive.text, self.LabelSix.text ]];
    [self.currentMoves addObject:[NSString stringWithFormat:@"%@%@%@", self.LabelSeven.text, self.LabelEight.text, self.LabelNine.text ]];

}


















@end
