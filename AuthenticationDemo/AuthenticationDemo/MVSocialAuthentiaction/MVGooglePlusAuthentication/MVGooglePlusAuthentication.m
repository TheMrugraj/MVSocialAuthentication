//
//  MVGooglePlusAuthentication.m
//  TwitterDemo
//
//  Created by Indianic on 18/11/14.
//  Copyright (c) 2014 Indianic. All rights reserved.
//

#import "MVGooglePlusAuthentication.h"

@implementation MVGooglePlusAuthentication

-(void)authenticateViaGoogleWithClientKey:(NSString *)clientId delegate:(id<MVGooglePlusDelegate>)delegate{
 
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.clientID = clientId;
    signIn.scopes = [NSArray arrayWithObject:kGTLAuthScopePlusLogin];
    signIn.delegate = self;
    _googleDelegate=delegate;
    [signIn authenticate];
    
}


- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    if(!error){
        [_googleDelegate googleAuthSucceedWithUserData:(NSDictionary*)auth];
    }else{
        [_googleDelegate googleAuthFailed:error];
    }

}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    if([(UIViewController*)_googleDelegate navigationController]){
        [[(UIViewController*)_googleDelegate navigationController] pushViewController:viewController animated:YES];
    }
}

@end
