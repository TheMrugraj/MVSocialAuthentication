//
//  MVSocialFacebookAuthentication.m
//  TwitterDemo
//
//  Created by Indianic on 18/11/14.
//  Copyright (c) 2014 Indianic. All rights reserved.
//

#import "MVSocialFacebookAuthentication.h"

@implementation MVSocialFacebookAuthentication
-(void)authenticateViaFacebook:(id)delegate{


    _delegate = delegate;
    if (FBSession.activeSession.state == FBSessionStateOpen || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        //Already have Opened Session
        [self sendDataWithSession:[FBSession activeSession]];
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        
        FBSession *session = [[FBSession alloc]init];
        [FBSession setActiveSession:session];
        [[FBSession activeSession] openWithBehavior:FBSessionLoginBehaviorUseSystemAccountIfPresent completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            if (session.state == FBSessionStateOpen || session.state == FBSessionStateOpenTokenExtended || session.state==FBSessionStateCreatedTokenLoaded) {
                [self sendDataWithSession:session];
            }else if(session.state==FBSessionStateClosedLoginFailed){
                [_delegate facebookAuthFailed:error];
            }
        }];
    }
}


-(void)sendDataWithSession:(FBSession*)session{
    _session = session;
    [_delegate facebookAuthSucceedWithUserData:(NSDictionary*)session];
}

-(void)logOutFromFacebook{
    if([FBSession activeSession]){
            [FBSession.activeSession closeAndClearTokenInformation];
    }
}

@end
