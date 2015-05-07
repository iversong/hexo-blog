title: 使用Vagrant配置本地开发环境
date: 2015-04-20 17:14:15
keywords: vagrant 跨平台 开发环境 开发工具
categories: 开发工具
tags: 
- vagrant
- 虚拟机 
- 开发工具

-----

从二零一四年开始使用vagrant+VirtualBox搭建linux开发环境，配置简单灵活，后台运行占用内存少，比vmware好用很多，果断弃用vmware转投vagrant的怀抱；无论是个人搭建开发环境还是团队统一开发环境，vagrant是最方便快捷的方式。

### 问题一：



但是最近在使用的时候遇到一些坑，记录下来以免下次遇到浪费时间去查找解决；经过是这样的：从家里的agrant打包了一份开发环境到公司的新电脑上，vagrant init {boxname}初始化后使用vagrant up启动虚拟机却一直启动失败，提示如下：

    D:\webroot\vagrant>vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    ==> default: Clearing any previously set forwarded ports...
    ==> default: Clearing any previously set network interfaces...
    ==> default: Preparing network interfaces based on configuration...
        default: Adapter 1: nat
    ==> default: Forwarding ports...
        default: 22 => 2222 (adapter 1)
    ==> default: Booting VM...
    ==> default: Waiting for machine to boot. This may take a few minutes...
        default: SSH address: 127.0.0.1:2222
        default: SSH username: vagrant
        default: SSH auth method: private key
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        default: Warning: Connection timeout. Retrying...
        Timed out while waiting for the machine to boot. This means that
        Vagrant was unable to communicate with the guest machine within
        the configured ("config.vm.boot_timeout" value) time period.

        If you look above, you should be able to see the error(s)  that Vagrant had when attempting to connect to the machine. These errors are usually good hints as to what may be wrong.

        If you're using a custom box, make sure that networking is properly working and you're able to connect to the machine. It is a common problem that networking isn't setup properly in these boxes. Verify that authentication configurations are also setup properly,as well.

        If the box appears to be booting properly, you may want to increase the timeout ("config.vm.boot_timeout") value.
        
通过查找资料，在stackowverflow上有网友也遇到过相同问题并给出解决方案如下：

+ 将Vagrantfile配置文件中vb.gui = true的注释去掉

        config.vm.provider "virtualbox" do |vb|
        #   # Don't boot with headless mode
            vb.gui = true
        #
        #   # Use VBoxManage to customize the VM. For example to change     memory:
        #   vb.customize ["modifyvm", :id, "--memory", "1024"]
         end
+ 运行vagrant up 启动 virtualbox 后，GUI会给出提示

        VT-x/AMD-V硬件加速在您的系统中不可用。您的64-位虚拟机将无法检测到 64-位处理器，从而无法启动。
+ 这是由于在BOIS中没有开启cpu虚拟化支持，重启F2或F10等进入BIOS设置Virtualization为Enable（我的Thinkpad是Security=>Virtualizatio设置为Enable）； 
+ 电脑重启后，再次vagrant up启动虚拟机还是有一些问题，当时也没有记录下来错误信息，只记得解决方案是使用vagrant destroy将虚拟机从磁盘中删除，然后使用vagrant up命令重新创建。

### 问题二 (2015.5.7更新)

vagrant启动报错The following SSH command responded with a non-zero exit status.


	D:\vagrant_web>vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	==> default: Clearing any previously set forwarded ports...
	==> default: Clearing any previously set network interfaces...
	==> default: Preparing network interfaces based on configuration...
	    default: Adapter 1: nat
	    default: Adapter 2: hostonly
	==> default: Forwarding ports...
	    default: 80 => 8080 (adapter 1)
	    default: 3000 => 3000 (adapter 1)
	    default: 22 => 2222 (adapter 1)
	==> default: Booting VM...
	==> default: Waiting for machine to boot. This may take a few minutes...
	    default: SSH address: 127.0.0.1:2222
	    default: SSH username: vagrant
	    default: SSH auth method: private key
	    default: Warning: Connection timeout. Retrying...
	==> default: Machine booted and ready!
	==> default: Checking for guest additions in VM...
	==> default: Configuring and enabling network interfaces...
	The following SSH command responded with a non-zero exit status.
	Vagrant assumes that this means the command failed!
	
	ARPCHECK=no /sbin/ifup eth1 2> /dev/null
	
	Stdout from the command:
	
	Device eth1 does not seem to be present, delaying initialization.
	
	Stderr from the command:

#### 解决方案 

虽然vagrant up启动报错，但是vagrant ssh还是能登陆虚拟机的，进入虚拟机后，执行如下命令

	sudo rm -f /etc/udev/rules.d/70-persistent-net.rules 

对， 问题就处在在持久网络设备udev规则（persistent network device udev rules）是被原VM设置好的，再用box生成新VM时，这些rules需要被更新。而这和Vagrantfile里对新VM设置private network的指令发生冲突。删除就好了。

vagrant reload 再次启动就OK。

以上问题完美解决，记录下来，避免忘记！

[Vagrant官网](https://www.vagrantup.com/) 文档齐全.
[segment安装使用方法](http://segmentfault.com/a/1190000002645737) 网友分享的使用说明，简单明了！



