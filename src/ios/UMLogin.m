/********* UMLogin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "UMSocial.h"


@interface UMLogin : CDVPlugin<UMSocialUIDelegate>


- (void)Login:(CDVInvokedUrlCommand*)command;

@end

@implementation UMLogin

- (void)Login:(CDVInvokedUrlCommand*)command
{
    
    NSString* echo = [command.arguments objectAtIndex:0];
    
    UMSocialSnsPlatform *snsPlatform = nil;
    
    
    if (echo.length == 0) {
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"无参数,调起登录失败!"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        
    }else{
        
        if ([echo isEqualToString:@"WX"]) {
            
            snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            
            [self LogUsingThirdParty:snsPlatform];
            
        }
        
        else if ([echo isEqualToString:@"QQ"]){
            
            snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            
            [self LogUsingThirdParty:snsPlatform];
            
            
        }
        
        
        else if ([echo isEqualToString:@"Sina"]){
            
            snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            
            [self LogUsingThirdParty:snsPlatform];
            
        }
        
        
    }
    
    
}


- (void)LogUsingThirdParty:(UMSocialSnsPlatform *)snsPlatform{
    
    
    snsPlatform.loginClickHandler(self.viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //获取第三方的用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
}




@end
