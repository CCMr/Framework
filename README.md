##CCFramework
当前工程如名含义一样，主要是对IOS移动端开发的项目框架主要使用的语言是objective-c。其中集成多方的开源库，主体思路是MVVM架构。工程中还有诸多不足之处希望大家提出意见与建议。


##主体架构目录

* BaseViewController（基础父类页面）
    *  Navigation（导航栏）
    *  UI（主体UI）
* Config（配置文件）
    * PrefixHeader（导入与服务器地址）
    * Config（Block、宏定义）
* DatabaseLayer（数据库层）
    *  CoreDataManager（封装苹果数据库）
* ModelLayer（实体层 ）
    * Entity（自定义实体）
    * BaseViewModel（View层实体基类）
    * BaseEntity（实体基类）
    * UserDefaultsEntity (NSUserDefaults封装实体)
* RequestProtocol （网络请求层）
    * HTTPRequestManager （HTTP请求工厂） 
* Resource（资源文件）
    * ImageLayer （图片）
    * InterfaceBuilder（xib、Storyboard）
* ThirdParty（第三方库）
    * Ability（能力）
    * UI（页面）
    * Animation（效果）
* Tools（工具）
    * ChatDisplayKitLib （聊天模块）
    * SignalRChat （接连聊天服务）
    * Vender.a（第三方.a库）
    * CameraViewController （图片与照片选择器）
    * Category （扩展库）
        * Class （扩展类）
        * Controls （扩展控件）
    * LocationManager（定位工厂）
    * TimePicker （时间选择器）
* ViewController （试图层） 
* ViewModelLayer （试图模型层）

## 宝贵意见
如果有任何问题，请到githug开issue，[点击这里](https://github.com/CCMr/Framework/issues?state=open)移步新建一个issue，写上你不明白的地方，我会在github给予帮助。 

It's ok if you don't understand how the code works. Most code has comments, which I believe will help you a lot. Feel free to [open is issues](https://github.com/CCMr/Framework/issues?state=open) if you have any questions. I will do my best to answer them.

## 组件要求 Requirements
* iPhone4/5/6/6+/iPad，Portrait
* Xcode6 or later
* iOS 6.0+ 
* ARC
* System Frameworks : 'APService', 'MapKit', 'Foundation', 'CoreGraphics', 'UIKit', 'MobileCoreServices', 'AVFoundation', 'CoreLocation', 'MediaPlayer', 'CoreMedia', 'CoreText', 'AudioToolbox' 等等.

## License

中文: MessageDisplayKit 是在MIT协议下使用的，可以在LICENSE文件里面找到相关的使用协议信息。

English: MessageDisplayKit is available under the MIT license, see the LICENSE file for more information.     


## 须知Notes
如果您在您的项目中使用该开源组件，请给我们发[电子邮件](mailto:gmaukh4517@163.com?subject=From%20GitHub%20MessageDisplayKit)告诉我们您的应用程序的名称，谢谢！主要是为了互推的效果，如果您的app火了，请给予少许的回报，如果您的App不火，或许能通过这个开源库了解到您的App！         
主要目的只有一个，互推，使用该开源库的开发者，我都会向其保证，永远免费，不涉及任何商业纠纷的事情，请放心使用。

If you use this open source components in your project, please [Email us](mailto:gmaukh@163.com?subject=From%20GitHub%20MessageDisplayKit) to notify us the name of your application(s). Thanks!


## 使用到的第三方组件
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)用于网络请求。
* [PathCover](https://github.com/JackTeam/PathCover)用于朋友圈的下拉刷新。
* [XHImageViewer](https://github.com/JackTeam/XHImageViewer)图片查看器，用于整个项目。
* [XHRefreshControl](https://github.com/xhzengAIB/XHRefreshControl)是一款高扩展性、低耦合度的下拉刷新、上提加载更多的组件。用于整个项目的所有下拉刷新和上提加载更多的UI和业务逻辑。    
* 谢谢[molon](https://github.com/molon)提供多选组件[MLMultiSelectViewController](https://github.com/molon/MLMultiSelectViewController)，现在已经集成进去了。可用于群聊、添加多个朋友、等等。
* Thanks you [lakesoft](https://github.com/lakesoft) provide [LKBadgeView](https://github.com/lakesoft/LKBadgeView).
* Thanks you [kishikawakatsumi](https://github.com/kishikawakatsumi) provide [SECoreTextView](https://github.com/kishikawakatsumi/SECoreTextView).     

##有问题反馈
在使用中有任何问题，欢迎反馈给我，可以用以下联系方式跟我交流

* 邮件(gmaukh4517#163.com, 把#换成@)
* QQ: 1292522572
* weibo: [@CCMisters](http://weibo.com/CCSkill)

##捐助开发者
在兴趣的驱动下,写一个`免费`的东西，有欣喜，也还有汗水，希望大家喜欢我的作品，同时也能支持一下。谢谢各位。


