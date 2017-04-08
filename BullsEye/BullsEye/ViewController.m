//
//  ViewController.m
//  BullsEye
//
//  Created by michael qian on 2016/10/15.
//  Copyright © 2016年 mqstack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonHitMe;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *target;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@end

@implementation ViewController
{
    int _currentValue;
    int _targetValue;
    int _score;
    int _round;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startNewRound];
    _round = 0;
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
}

- (IBAction)startOver{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewRound];
    [self updateLabel];
    [self.view.layer addAnimation:transition forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTappedHitMe:(id)sender {
    
    int diff = abs(_currentValue - _targetValue);
    int points = 100 - diff;
    _score += points;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", _score];
    _round+=1;
    self.roundLabel.text = [NSString stringWithFormat:@"%d", _round];
    NSString *title;
    if(diff < 5){
        title = @"Perfect!";
    }else if(diff < 10){
        title = @"Good!";
    }else{
        title = @"Not even close";
    }
    NSString *message = [NSString stringWithFormat:@"The value is %d\n the target is %d\n the difference is %d", _currentValue, _targetValue, points];
    UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [alertControler addAction:action];
    [self presentViewController:alertControler animated:YES completion:nil];
    [self startNewRound];
}

- (IBAction)sliderMoved:(UISlider*)slider {
    
    _currentValue = lround(slider.value);
    NSLog(@"The value of slider is now: %f", slider.value);
}

- (void)startNewRound{
    _targetValue =  1+ arc4random_uniform(100);
    _currentValue = 50;
    self.slider.value = _currentValue;
    NSString *targetText = [NSString stringWithFormat:@"%d", _targetValue];
    self.target.text = targetText;
}

- (void) updateLabel{
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
