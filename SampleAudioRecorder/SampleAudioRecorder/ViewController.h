//
//  ViewController.h
//  SampleAudioRecorder
//
//  Created by 김성준 on 2016. 11. 9..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate,AVAudioRecorderDelegate>

@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)recordAudio:(id)sender;
- (IBAction)stopAudio:(id)sender;
- (IBAction)playAudio:(id)sender;


@end

