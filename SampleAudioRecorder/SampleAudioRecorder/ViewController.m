//
//  ViewController.m
//  SampleAudioRecorder
//
//  Created by 김성준 on 2016. 11. 9..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (){
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _playButton.enabled = false;
    _stopButton.enabled = false;
    
//    Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject], @"MyAudioMemo.m4a", nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
//    Setup audio session
//    audio session은 오디오에관한 행동을 제어한다. setCategory에 있는 파라미터는 input과 output이 동시에 가능하게 한다.
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
//    Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
//    initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
}

- (IBAction)recordAudio:(id)sender {
    //    stop the audio player before recording
    if(player.playing){
        [player stop];
    }
    if(!recorder.recording){
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        //        start recording
        [recorder record];
        [_recordButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    }else{
        //        pause recording
        [recorder pause];
        [_recordButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
    [_stopButton setEnabled:YES];
    [_playButton setEnabled:NO];
    
}

- (IBAction)stopAudio:(id)sender {
    [recorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (IBAction)playAudio:(id)sender {
    if(!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
    }
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    [_recordButton setTitle:@"Record" forState:UIControlStateNormal];
    
    [_stopButton setEnabled:NO];
    [_playButton setEnabled:YES];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Finish playing this recording" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}
@end
