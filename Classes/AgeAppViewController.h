//
//  AgeAppViewController.h
//  Sound Recognizer
//
//  Created by Vladimir Glavtchev on 3/7/11 .
//  Copyright Vladimir Glavtchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AgeAppViewController : UIViewController {
	AVAudioPlayer *audioPlayer;
	bool isAudioPlaying;
	bool testHasStarted;
	IBOutlet UILabel *mainButton;
    IBOutlet UILabel *resultText;
    IBOutlet UILabel *restartText;
	IBOutlet UILabel *helpText;
    IBOutlet UIImageView *companyLogo;
	NSMutableDictionary *urlMap;
	NSString* soundBank[13];
	
	int queuedSound;
	int currentSoundPlaying;
	bool userHeardSounds[12];
	int userHeardSoundsCount;
}

@property (nonatomic, retain) IBOutlet UIButton *restartButton;
@property (nonatomic, retain) IBOutlet UILabel *mainButton;
@property (nonatomic, retain) IBOutlet UILabel *resultText;
@property (nonatomic, retain) IBOutlet UILabel *restartText;
@property (nonatomic, retain) IBOutlet UILabel *helpText;
@property (nonatomic, retain) IBOutlet UIImageView *companyLogo;
@property bool isAudioPlaying;
@property bool testHasStarted;
@property (nonatomic, retain) NSMutableDictionary* urlMap;
@property int userHeardSoundsCount;
// Crittercism test button
@property (nonatomic, retain) IBOutlet UIButton *critterTestButton;

- (IBAction)userTap:(id)sender;
- (IBAction)restartRequested:(id)sender;
- (void)stopSound:(NSNumber*)soundId;
- (void)initLabelsAndButtons;
// Crittercism induce crash test function
- (IBAction) crashPressed:(id) sender;

#define UPPERBUTTON 0
#define LOWERBUTTON 1

@end

