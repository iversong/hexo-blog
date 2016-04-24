title: VPS一键测试脚本bench.sh
date: 2016-04-24 10:33:08
tags: vps 运维
---

> 大家新买了VPS，免不了需要测试一下新VPS的性能，以前测试比较繁琐，显示结果也不直观。今天发现[秋水逸冰][1]的一键测试脚本bench.sh，特别转发过来。

经过几个版本的演化，一键测试脚本 bench.sh 已经几乎全面适用于各种 Linux 发行版的网络（下行）和 IO 测试。并将测试结果以较为美观的方式显示出来。

**总结一下 bench.sh 特点：**

 1. 显示当前测试的各种系统信息；
 2. 取自世界多处的知名数据中心的测试点，下载测试比较全面； 
 3. 支持 IPv6 下载测速； 
 4. IO测试三次，并显示平均值。
 
tips：配合 unixbench.sh 脚本测试，即可全面测试 VPS 的性能。

**使用方法：**

    命令1：
    wget -qO- bench.sh | bash
    或者
    curl -Lso- bench.sh | bash
    
    命令2：
    wget -qO- 86.re/bench.sh | bash
    或者
    curl -so- 86.re/bench.sh | bash

<!-- more -->

**备注：**
bench.sh 既是脚本名，同时又是域名。所以不要怀疑我写错了或者你看错了。

**下载地址：**
https://github.com/teddysun/across/blob/master/bench.sh

最后放几张测试图片。

**BandwagonHost Los Angel**
![BandwagonHost Los Angel][2]

**DigitalOcean Singapore**
![DigitalOcean Singapore][3]

**Ramnode Seattle**
![Ramnode Seattle][4]

**Xvmlabs Los Angel**
![Xvmlabs Los Angel][5]

原文链接：[一键测试脚本bench.sh][6]


  [1]: https://teddysun.com/
  [2]: http://7fvkfx.com1.z0.glb.clouddn.com/speedtest_bwg.png
  [3]: http://7fvkfx.com1.z0.glb.clouddn.com/speedtest_do_sg.png
  [4]: http://7fvkfx.com1.z0.glb.clouddn.com/speedtest_do_sg.png
  [5]: http://7fvkfx.com1.z0.glb.clouddn.com/speedtest_xvmlabs.png
  [6]: https://teddysun.com/444.html
