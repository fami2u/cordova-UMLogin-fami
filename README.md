###README   
### 下载说明
* 下载插件源代码

* 下载fami-plugin-lists用于集成插件 git clone git@github.com:fami2u/fami-plugin-lists.git

* 以上两个目录平级

* cd fami-plugin-lists

* 查看当前安装的插件 cordova plugin list

* 删除插件 cordova plugin remove com.fami2u.plugin.

* 安装插件 cordova-plugin- 使用命令 cordova plugin add ../

* 重新编译插件 cordova build android||ios

### 调用说明
> IOS部分

此插件集成了友盟的登录（QQ,微信，新浪微博）
开发者使用时需要调取(下面示例是调取新浪微博登录):                                                           
                                                                                         		
                                                                                         		                                                                  var param = "Sina";
                                                                           UMLogin.Login(param);
                                                                                         		
 其中param参数代表登录类型，此处目前有三种常用值：
 
 “WX”(微信)
 
 “QQ”(QQ)

 "Sina"(新浪微博)                                                                               
                                                                                 
                                                                                
- 请到所需平台注册该平台appID 和appKey，并在info.plist的URL Scheme中相应添加

	微博，wb+appkey，如"wb3921700954"，

	微信appid，如：wxdc1e388c3822c80b                                                                            

	QQ,tencent+appId,如：tencent100424468。

	否则不能正确跳转。以上实例中的appId，仅为登录测试提供。

- 请在AppDelegate.m 中注册友盟以及要跳转的平台。
  	
  	1.导入所需头文件
  		
		#import "UMSocial.h"
		#import "UMSocialWechatHandler.h"
		#import "UMSocialSinaSSOHandler.h"
		#import "UMSocialQQHandler.h"
	
  	2.在如下方法中注册
  	
		  	- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
		{
		  
		    self.viewController = [[MainViewController alloc] init];
		    
		    
		    //设置友盟社会化组件appkey
		    [UMSocialData setAppKey:APPKEY];
		    
		    //设置微信AppId，设置分享url，默认使用友盟的网址
		    [UMSocialWechatHandler setWXAppId:@"wxdc1e388c3822c80b" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.umeng.com/social"];
		    
		    //设置分享到QQ空间的应用Id，和分享url 链接
		    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
		    
		    //设置支持没有客户端情况下使用SSO授权
		    [UMSocialQQHandler setSupportWebView:YES];
		    
		    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
		    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
		    
		    // 打开新浪微博的SSO开关
		    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
		    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
		                                              secret:@"04b48b094faeb16683c32669824ebdad"
		                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
		    
		    
		    return [super application:application didFinishLaunchingWithOptions:launchOptions];
		}
		
		
- 实现代理事件
 		
		 /**
		这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
		 */
		- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
		{
		    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
		}
		
		/**
		 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
		 */
		- (void)applicationDidBecomeActive:(UIApplication *)application
		{
		    [UMSocialSnsService  applicationDidBecomeActive];
		}



#####更多插件请点击：[fami2u](https://github.com/fami2u)
#####关于我们：[FAMI](http://fami2u.com)
