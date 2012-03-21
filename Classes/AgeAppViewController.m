//
//  AgeAppViewController.m
//  Sound Recognizer
//
//  Created by Vladimir Glavtchev on 3/7/11.
//  Copyright 2011 BMW Technology Office USA. All rights reserved.
//

#import "AgeAppViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation AgeAppViewController
@synthesize isAudioPlaying;
@synthesize testHasStarted;
@synthesize mainButton;
@synthesize restartButton;
@synthesize resultText;
@synthesize restartText;
@synthesize helpText;
@synthesize urlMap;
@synthesize userHeardSoundsCount;

#define NUM_SOUNDS 12

NSString *ageTable[] = {
	@"61-80", //1
	@"51-60", //2
	@"41-50", //3
	@"36-40", //4
	@"31-35",
	@"26-30",
	@"21-25",
	@"16-20",
	@"11-15", //9
	@"6-10",
	@"1-5" ,
	@"Exceptional!" //12
};
	

- (id) init
{

    soundBank[0] = @"8k";
	soundBank[1] = @"10k";
	soundBank[2] = @"12k";
	soundBank[3] = @"14k";
	
	soundBank[4] = @"15k";
	soundBank[5] = @"16k";
	soundBank[6] = @"17k";
	soundBank[7] = @"18k";
	
	soundBank[8] = @"19k";
	soundBank[9] = @"20k";
	soundBank[10] = @"21k";
	soundBank[11] = @"22k";
	
	urlMap = [[NSMutableDictionary alloc] init];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/8000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"8k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/10000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"10k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/12000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"12k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/14000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"14k"];

	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/15000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"15k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/16000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"16k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/17000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"17k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/18000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"18k"];
	
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/19000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"19k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"20k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/21000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"21k"];
	[urlMap setObject:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/22000_half.wav", [[NSBundle mainBundle] resourcePath]]] forKey:@"22k"];
	
    [self initLabelsAndButtons];
    
	return self;
}

- (void)initLabelsAndButtons
{
    // Initialize all audio related variables
    [self setIsAudioPlaying:FALSE];
	[self setTestHasStarted:FALSE];
	
	[self setUserHeardSoundsCount:0];
	
	userHeardSounds[0] = FALSE;
	userHeardSounds[1] = FALSE;
	userHeardSounds[2] = FALSE;
	userHeardSounds[3] = FALSE;
    
	userHeardSounds[4] = FALSE;
	userHeardSounds[5] = FALSE;
	userHeardSounds[6] = FALSE;
	userHeardSounds[7] = FALSE;
    
	userHeardSounds[8] = FALSE;
	userHeardSounds[9] = FALSE;
	userHeardSounds[10] = FALSE;
	userHeardSounds[11] = FALSE;
    
    
    // Initialize all buttons and labels
    // Init results label to blank
	NSString *newText = [[NSString alloc] initWithFormat:@""];
	resultText.text = newText;
    
    // Init restart label to blank
	NSString *newRestartText = [[NSString alloc] initWithFormat:@""];
	restartText.text = newRestartText;
    
    // Initially hide the RESTART button
    restartButton.hidden = TRUE;
    restartButton.enabled = FALSE;
}

- (IBAction)userTap:(id)sender
{	
	
	if(testHasStarted == TRUE){
		// Tally up the score	
		userHeardSounds[currentSoundPlaying] = TRUE;
		NSLog(@"User heard sound: %d!", currentSoundPlaying);
	}else{
		if ([NSThread isMainThread]) {
			{
				mainButton.text = @"( Running... )";
			}
		} else {
			NSLog(@"is not main thread");
			[self performSelectorOnMainThread:@selector( userTap) withObject:nil waitUntilDone:YES];
		}
		
		NSNumber* sounds[12];
		
        // Create a look-up table of the order in which we want the sounds played
		sounds[0] = [NSNumber numberWithInt:3];
		sounds[1] = [NSNumber numberWithInt:7];

		sounds[2] = [NSNumber numberWithInt:11];
		sounds[3] = [NSNumber numberWithInt:1];

		sounds[4] = [NSNumber numberWithInt:10];
		sounds[5] = [NSNumber numberWithInt:2];
		
		sounds[6] = [NSNumber numberWithInt:8];
		sounds[7] = [NSNumber numberWithInt:5];
		
		sounds[8] = [NSNumber numberWithInt:6];
		sounds[9] = [NSNumber numberWithInt:9];
		
		sounds[10] = [NSNumber numberWithInt:0];
		sounds[11] = [NSNumber numberWithInt:4];

		NSError *error;
		NSURL *currentURL;
		NSString* soundToPlay = soundBank[[sounds[0] intValue]];
		currentURL = [urlMap objectForKey:soundToPlay];
		queuedSound = [sounds[0] intValue];	
		
		audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:currentURL error:&error];
		audioPlayer.numberOfLoops = 0;
		[audioPlayer prepareToPlay];
        audioPlayer.volume = 1.0;
		
		float delay = 1.5;
		float timeToPlay = 1.0;
		float stopInterval = 0.5;
		
		/** Queue up sound files to play every 2 seconds **/		
        [self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[1] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
        
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[2] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[3] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[4] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[5] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[6] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[7] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[8] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[9] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[10] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
		
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:sounds[11] afterDelay:timeToPlay + stopInterval];
		timeToPlay += delay;
	
		[self performSelector:@selector(playSound) withObject:nil afterDelay:timeToPlay];
		[self performSelector:@selector(stopSound:) withObject:nil afterDelay:timeToPlay + stopInterval];
        
        // Change the helper label
        helpText.text = [NSString stringWithFormat: @"( Tap each time you hear a sound! )"];
        
		testHasStarted = TRUE;
	}
}

- (IBAction)restartRequested:(id)sender
{	
    
}

-(void)playSound{
	[audioPlayer play];
	
	// Keep track of the sound currently playing
	currentSoundPlaying = queuedSound;
	NSLog(@"CurrentSoundPlaying: %d", currentSoundPlaying);
}

-(void)stopSound:(NSNumber*)soundId{
	
	//[audioPlayer stop];
	//[audioPlayer setCurrentTime:0.0];
	//[audioPlayer release];
	
	if(soundId == nil){
		[self performSelector:@selector(calculateAge) withObject:nil afterDelay:1.0];
        
        // Test is done - hide the helper label
        helpText.text = [NSString stringWithFormat: @""];

	}else{
		NSURL *currentURL;
		int index = [soundId intValue];
		NSString* curSound = soundBank[index];
		currentURL = [urlMap objectForKey:curSound];
		audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:currentURL error:nil];
		audioPlayer.numberOfLoops = 0;
		[audioPlayer prepareToPlay];
		
		// Remember that this sound has been queued up
		queuedSound = [soundId intValue];
	}
}

-(void)calculateAge
{
	// Create new text for the label
#ifdef DEBUG
	NSString *newText = [[NSString alloc] initWithFormat:@"User heard sounds: [ "];
	for(int i = 0; i < NUM_SOUNDS; i++){
		if(userHeardSounds[i] == TRUE){
			NSLog(@"%d ",i);
			newText = [newText stringByAppendingFormat:@" %d",i];
		}
	}
    
    newText = [newText stringByAppendingFormat:@" ]"];

	mainButton.text = newText;
#else
	NSString *newText = [[NSString alloc] initWithFormat:@"... is your age group"];
	int secondToLast = 0;
	int lastSound = 0;
	int currentSound = 0;
	int highestHeardSound = 0;
	
	for(int i = 0; i < NUM_SOUNDS; i++){
		if(userHeardSounds[i] == TRUE){
			secondToLast = lastSound;
			lastSound = currentSound;
			currentSound = i;
		}
	}
	
	if((currentSound - lastSound) > 2){
		highestHeardSound = lastSound;
	}else {
		highestHeardSound = currentSound;
	}
	
	//newText = [newText stringByAppendingFormat:@"%@",ageTable[highestHeardSound]];
	mainButton.text = newText;
	
    // Update the RESULTS label
	NSString *newResultText = [[NSString alloc] initWithFormat:@"%@", ageTable[highestHeardSound]];
	resultText.text = newResultText;
    
	// Update the help label
	NSString *newHelpText = [[NSString alloc] initWithFormat:@""];
	helpText.text = newHelpText;
    
    // Show restart label / button
	NSString *newRestartText = [[NSString alloc] initWithFormat:@"RESTART TEST?"];
	restartText.text = newRestartText;
    
    // Show the RESTART button
    restartButton.hidden = FALSE;
    restartButton.enabled = TRUE;
#endif
	
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
