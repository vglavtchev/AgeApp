//
//  soundEventController.m
//  Sound Recognizer
//
//  Created by Vladimir Glavtchev on 3/18/11.
//  Copyright Vladimir Glavtchev. All rights reserved.
//

#import "ageEventController.h"

@implementation soundEventController

- (id) init
{
	/*//register to listen for event    
	 [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(startTest:)
	 name:@"startSoundTest"
	 object:nil ];
	 return;*/
}

//event handler when event occurs
-(void)startTest: (NSNotification *) notification
{
    NSLog(@"event triggered");
}

@end
