//
//  AgeAppViewController.h
//  Sound Recognizer
//
//  Created by Vladimir Glavtchev on 3/7/11 .
//  Copyright 2011 BMW Technology Office USA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AgeAppViewController : UIViewController {
	AVAudioPlayer *audioPlayer;
	bool isAudioPlaying;
	bool testHasStarted;
	IBOutlet UILabel *mainButton;
    IBOutlet UILabel *resultText;
	IBOutlet UILabel *helpText;
	NSMutableDictionary *urlMap;
	NSString* soundBank[13];
	
	int queuedSound;
	int currentSoundPlaying;
	bool userHeardSounds[12];
	int userHeardSoundsCount;
}

@property (nonatomic, retain) IBOutlet UILabel *mainButton;
@property (nonatomic, retain) IBOutlet UILabel *resultText;
@property (nonatomic, retain) IBOutlet UILabel *helpText;
@property bool isAudioPlaying;
@property bool testHasStarted;
@property (nonatomic, retain) NSMutableDictionary* urlMap;
@property int userHeardSoundsCount;

- (IBAction)userTap:(id)sender;
- (void)stopSound:(NSNumber*)soundId;

#define UPPERBUTTON 0
#define LOWERBUTTON 1

@end

