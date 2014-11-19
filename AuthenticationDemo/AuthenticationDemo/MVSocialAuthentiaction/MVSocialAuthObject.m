//
//  MVSocialAuthObject.m
//  TwitterDemo
//
//  Created by Indianic on 18/11/14.
//  Copyright (c) 2014 Indianic. All rights reserved.
//

#import "MVSocialAuthObject.h"

static MVSocialAuthObject* _sharedMySingleton = nil;
@implementation MVSocialAuthObject


+(MVSocialAuthObject*)sharedInstance
{
    @synchronized([MVSocialAuthObject class])
    {
        if (!_sharedMySingleton)
            _sharedMySingleton = [[self alloc] init];
        
        return _sharedMySingleton;
    }
    
    return nil;
}

-(BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if([GPPURLHandler handleURL:url
              sourceApplication:sourceApplication
                     annotation:annotation]){
        return YES;}
    else if ( [FBAppCall handleOpenURL:url sourceApplication:sourceApplication]){
        return YES;
    }
    else{
        return NO;
    }
}


#pragma mark - Social Calls
-(void)authenticateViaFacebookDelegate:(id<MVSocialDelegates>)delegate{
    _facebookDelegate = delegate;
    facebookHandler = [[MVSocialFacebookAuthentication alloc]init];
    [facebookHandler authenticateViaFacebook:self];
}

-(void)authenticateViaTwitterDelegate:(id<MVSocialDelegates>)delegate{
    _twitterDelegate=delegate;
    twitterHandler = [MVTwitterAuthentication sharedInstance];
    [twitterHandler authenticateViaTwitterWithDelegate:self];
}

-(void)authenticateViaGoogleDelegate:(id<MVSocialDelegates>)delegate{
    _googleDelegate=delegate;
    googleHandler = [[MVGooglePlusAuthentication alloc]init];
    [googleHandler authenticateViaGoogleWithClientKey:kGoogleClientId delegate:self];
}


#pragma mark - TwitterDelegates
-(void)twitterAuthenticationSucceedWithUserData:(NSDictionary *)userInfo{
    NSLog(@"Twitter UserInfo : %@",userInfo);
    _authType = kMVAuthTypeTwitter;
    _authData = userInfo;
    [_twitterDelegate authenticataionDidFinishedWithType:_authType andAccessData:_authData];
}
-(BOOL)twitterAuthenticationDoneShouldGoForData{
    return YES;
}
-(void)twitterAuthenticationEnded{
    
}
-(void)twitterAuthenticationFailed:(NSError *)error{
    
}
-(void)twitterAuthenticationFailedAtAccounts{
    
}
-(BOOL)twitterauthenticationShouldHandleFallback{
    return YES;
}
-(void)twitterAuthenticationStarted{
    
}

-(NSString *)twitterAuthenticationNeedsConsumerKey{
    return @"Xg3ACDprWAH8loEPjMzRg";
}
-(NSString *)twitterAuthenticationNeedsSecret{
    return @"9LwYDxw1iTc6D9ebHdrYCZrJP4lJhQv5uf4ueiPHvJ0";
}
-(UIViewController *)twitterAuthenticationWillLoadWebViewForController{
    return (UIViewController*)_twitterDelegate;
}


-(void)logOut{
    [[MVSocialFacebookAuthentication sharedInstance]logOutFromFacebook];
    [[MVGooglePlusAuthentication sharedInstance]logoutFromGoogle];
    [[MVTwitterAuthentication sharedInstance]logoutFromTwitter];
}



#pragma mark - Google Delegates
-(void)googleAuthSucceedWithUserData:(NSDictionary *)userInfo{
    NSLog(@"Google UserInfo : %@",userInfo);
    _authType= kMVAuthTypeGoogle;
    _authData = userInfo;
    [_googleDelegate authenticataionDidFinishedWithType:_authType andAccessData:_authData];
}
-(BOOL)googleAuthDoneShouldGoForData{
    return YES;
}
-(void)googleAuthEnded{
    
}
-(void)googleAuthFailed:(NSError *)error{
    
}
-(void)googleAuthStarted{
    
}



#pragma mark - Facebook Delegate
-(void) facebookAuthSucceedWithUserData:(NSDictionary*)userInfo{
    NSLog(@"FB UserInfo : %@",userInfo);
    _authType = kMVAuthTypeFacebook;
    _authData = userInfo;
    [_facebookDelegate authenticataionDidFinishedWithType:_authType andAccessData:_authData];
}
-(BOOL) facebookAuthDoneShouldGoForData{
    return YES;
}
-(void) facebookAuthFailed:(NSError*)error{
    [_facebookDelegate authenticataionDidFailedByType:kMVAuthTypeFacebook withError:error];
}
-(void) facebookAuthStarted{
    
}
-(void) facebookAuthEnded{
    
}



@end
