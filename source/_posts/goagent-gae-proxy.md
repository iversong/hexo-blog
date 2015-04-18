title: Goagent+GAE+插件代理方式科学上网
date: 2015-03-21 15:23:24
keywords: Goagent 科学上网 GAE
categories: IT杂谈
tags: 
- porxy 
- 科学上网 
- 代理

-----

之前写过一篇文章，介绍google font拖垮网站访问速度的解决方法以及如何**科学上网**的简单方式，贴了几个Google数据中心的IP段，购买VPN等，没有啥干货；现在就来介绍下免费的技术解决方案，贴出来分享给有需要的朋友。

### Goagent+GAE+SwitchyOmega ###

### 什么是goagent？ ###

goAgent是一个基于Google Appengine的，全面兼容IE，FireFox，chrome的代理工具，使用Python和Google App EngineSDK编写，程序可以在Windows，Mac，Linux，Android，iPod，Touch，iPhone，iPad，webOS，OpenWrt，Maemo上使用。使用的是美国加利福尼亚州山景城Google数据中心IP段。

个人感觉，使用goagent为chrome做插件进行科学上网，相对于其他使用VPN等全局代理而言，优点在于：

1. 免费；
2. 非全局。

第一点就不用解释了。第二点是指对于使用qq、玩国服游戏等等这些非浏览器内的网络应用，同时又不需要代理操作时，goagent正好可以满足只在浏览器内运行的要求。

<!-- more -->

###首先从Google App Engine申请google appid###

简单普及一下什么是[Google App Engine(GAE)](http://baike.baidu.com/link?url=vJRrmZkBc3JKiUTR6UESz2FywgHlhhnfbjc42MlfiGLRXmiuDlyzW0OI73hbJqSygO4KPii5wHb-ASYJD0Wqa_)，就是和国内的 Baidu App Engine(BAE)，新浪的Sina App Engine(SAE)，阿里的Aliyun Cloud Engine(ACE)类似的应用托管环境。

如何申请[Google App Engine](https://appengine.google.com/)并创建appid，[（点这里查看教程）](http://wiki.geekfans.com/article/keji/20140827/306.html); 到这一步各位看官或许会郁闷了，尼玛没翻墙怎么登录[GAE](https://appengine.google.com/)，先别激动～～，奉上另外一个基于GoAgent和GAE appid的集成工具 [**XX-Net**](https://github.com/XX-net/XX-Net)，内置了公共appid，动态更新Google ip，公共appid只是限制了墙外视频的观看，其它网站浏览不受影响，然后去申请自己的appid填入配置就可以搞定一切了。

### 配置Goagent并部署到Google App Engine(GAE)###

	-------------如果上一步中大家觉得XX-Net好用，可以在github上给个star，然后忽略下面的内容-------------

1. 下载[Goagent](https://github.com/goagent/goagent)解压到任意位置；
2. 进入解压目录找到local文件夹，编辑里面的proxy.ini文件，把其中的appid = goagent中的goagent改成你申请的应用名，多个应用名使用`|`隔开。例如：
```php
[gae]
enable = 1
appid = appid1|appid2|appid3
```

3. 右键管理员权限运行goagent.exe，保持打开状态；
4. 双击sever文件夹下的uplaod.bat，然后输入你上步创建的appid（同时上传多appid在appid之间用 | 隔开,一次只能上传同一个谷歌帐户下的appid）填完按回车。根据提示填你的谷歌帐户邮箱地址，填完按回车。根据提示填你的谷歌帐户密码(注意：如果开启了两步验证，密码应为16位的应用程序专用密码而非谷歌帐户密码，否则会出现AttributeError: can't set attribute错误），填完按回车。
5. 导入证书lacal下的CA.crt文件，安装到“受信任的根证书颁发机构”；
6. 重新管理员权限运行local文件夹中的goagent.exe，代理就设置成功了

###设置浏览器代理###

	-------------只提供chrome和firefox浏览器设置，IE设置自行搜索，不建议使用IE代理------------------

1.  chrome浏览器代理：地址栏输入chrome://extensions/后按回车，打开扩展管理页，将local文件夹中的SwitchyOmega.crx拖拽到该页面之后点击确定即可安装。安装之后点击Proxy的图标->选项->导入导出，选择local下的"SwitchyOptions.bak"文件。确认导入配置即可。
2.  firefox浏览器代理：[教程在这里](http://www.cnblogs.com/coolicer/p/3519635.html)。

以上设置完成就可以Happy的上网了！


**新的问题来了，GFW手段用尽不让你出去啊，大量封杀google数据中心IP也使得Goagent变得不稳定了；怎么办呢，我擦来，不给你来点猛料，你不知道哥有多大潜力～～！！**

+ [gogo-tester](https://code.google.com/p/gogo-tester/)经测试已经很难找到可用Ip了；
+ 强大的 [GOGO Tester自带好IP版](http://nicevpncdn.sourceforge.net/GoGo%20Tester%20%E8%87%AA%E5%B8%A6%E5%A5%BDip%E7%89%88.exe)出现了，下载后放到你的local文件夹下，点击随机测试，生成几十个IP，全选右键->应用->选中IP到用户配置文件,会自动生成proxy.user.ini，然后重新运行goagent.exe，完美解决；缺点是无法自动更新google ip，需要定期执行寻找ip导入配置；如此看来，**XX-NET**动态更新Google ip倒是很方便，快去试试吧！

