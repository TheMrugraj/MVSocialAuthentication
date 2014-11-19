//
//  MVTwitterAuthentication.h
//  TwitterDemo
//
//  Created by Mrugraj on 18/11/14.
//   
//

#import <Foundation/Foundation.h>

@protocol MVTwitterAuthenticationDelegate <NSObject>

-(void)twitterAuthenticationSucceedWithUserData:(NSDictionary*)userInfo;
-(BOOL)twitterAuthenticationDoneShouldGoForData;
-(void)twitterAuthenticationFailed:(NSError*)error;
-(void)twitterAuthenticationFailedAtAccounts;
-(BOOL)twitterauthenticationShouldHandleFallback;
-(void)twitterAuthenticationStarted;
-(void)twitterAuthenticationEnded;

@end

@interface MVTwitterAuthentication : NSObject

@property(nonatomic,strong)NSString *strScreenName;
@property(nonatomic,strong)NSString *strName;
@property(nonatomic,strong)NSString *strTwitterId;
@property(nonatomic,strong)NSString *strTwitterEmail;

@property(nonatomic,strong)id<MVTwitterAuthenticationDelegate> twitterDelegate;
@property(nonatomic,readonly,strong)NSDictionary *userInfo;

-(void)authenticateViaTwitterWithDelegate:(id<MVTwitterAuthenticationDelegate>)delegate;
-(NSDictionary *)userInfo:(BOOL)basicDetail;

@end
