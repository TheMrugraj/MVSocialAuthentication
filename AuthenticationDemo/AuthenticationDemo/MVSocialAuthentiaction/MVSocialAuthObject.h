//
//  MVSocialAuthObject.h
//  TwitterDemo
//
//  Created by Indianic on 18/11/14.
//  Copyright (c) 2014 Indianic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVTwitterAuthentication.h"
#import "MVGooglePlusAuthentication.h"
#import "MVFacebookAuthentication/MVSocialFacebookAuthentication.h"



typedef enum : NSUInteger {
    kMVAuthTypeFacebook = 1,
    kMVAuthTypeGoogle =2,
    kMVAuthTypeTwitter=3,
} MVAuthType;

@protocol MVSocialDelegates <NSObject>

-(void)authenticateionDidStartedWithType:(MVAuthType)authType;
-(void)authenticataionDidFailedByType:(MVAuthType)authType withError:(NSError*)error;
-(void)authenticataionDidFinishedWithType:(MVAuthType)authType andAccessData:(NSDictionary*)userInfo;

@end
@interface MVSocialAuthObject : NSObject<MVTwitterAuthenticationDelegate,MVGooglePlusDelegate,MVFacebookDelegaete>
{
    MVTwitterAuthentication *twitterHandler;
    MVGooglePlusAuthentication *googleHandler;
    MVSocialFacebookAuthentication *facebookHandler;
}


+(MVSocialAuthObject*)sharedInstance;

-(BOOL)handleOpenURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation;
-(void)authenticateViaFacebookDelegate:(id<MVSocialDelegates>)delegate;
-(void)authenticateViaTwitterDelegate:(id<MVSocialDelegates>)delegate;
-(void)authenticateViaGoogleDelegate:(id<MVSocialDelegates>)delegate;
-(void)logOut;
@property(nonatomic,strong)id<MVSocialDelegates> facebookDelegate;
@property(nonatomic,strong)id<MVSocialDelegates> twitterDelegate;
@property(nonatomic,strong)id<MVSocialDelegates> googleDelegate;

@property(nonatomic,assign)MVAuthType authType;
@property(nonatomic,strong)NSDictionary *authData;
@end
