title: 面向服务架构的前后端分离方案
date: 2017-09-28 16:41:06
tags: nodejs 前后端分离 微服务

---

技术是为业务服务的，但是现代化的开发方式已经不仅仅关注业务代码本身。企业级的开发涉及到了更多的需求，比如：开发需求、代码管理协同、调试需求、共享需求、性能需求、部署需求等。

针对现阶段技我司术架构及人员配置，为了更好的协同工作，提升工作效率、迭代速度，满足以上各种需求，草拟出如下技术方案，目的是更好的服务业务，职责更明确清晰。

## 现有整体式应用程序面临的挑战

在整体式应用程序中，大部分逻辑都部署在一个集中化、单一的运行时环境或服务器中，并在其中运行。整体式应用程序通常很大，由一个大型团队或多个团队构建。采用此方法，各个团队需要花更多精力和统筹安排才能执行更改或部署。

整体式方法可能带来许多挑战，有以下四点：

 1. 庞大的应用程序代码库
庞大的代码库可能给希望熟悉代码的开发人员带来困扰，尤其是团队的新成员。庞大的应用程序代码库可能还会让应用程序开发过程中使用的开发环境工具和运行时容器不堪重负。最终，这会导致开发人员效率降低，可能会阻止对执行更改的尝试。
 2. 不频繁的更新
在典型的整体式应用程序中，大部分（几乎是全部）逻辑组件都部署在单一运行时容器中，并在其中运行。这意味着要更新对某个组件的一处细微更改，必须重新部署整个应用程序。另外，如果需要推广细微但关键的应用程序更改，则需要投入大量精力来对未更改的部分运行回归测试。这些挑战意味着整体式应用程序很难连续交付，这导致部署次数减少，对需要的更改的响应变慢。
 3. 依赖单一类型的技术
对于整体式模型，由于应用更改方面的挑战，以增量方式采用新技术或技术栈开发框架的新版本会变得很困难。最终，整体式架构应用程序通常必须一直使用这一种技术，这最终会阻碍应用程序跟上新的发展趋势。
 4. 可扩展性
可扩展性是整体式架构面临的最大挑战之一。。由于整体上的凝聚性，典型的整体式应用程序通常只能在扩展立方体的一个维度上扩展。随着生产环境收到更多请求，该应用程序通常采用的垂直扩展方式是添加更多资源供其使用，或者克隆到多个副本来进行响应。这种扩展方式低效且很耗资源。
当应用程序达到一定规模时，开发团队必须拆分为更小的团队，每个小团队专注于一个特定的功能区域，各团队彼此独立工作，而且通常位于不同地理位置。但是，由于应用程序的各部分间的自然凝聚性，需要各个团队协力执行更改和重新部署。
 
## 后端服务化

我司架构中，部分业务已经应用到了微服务架构，如订单中心。但是更多的业务如微信端商城还是存在严重的耦合，不仅仅是前后端的耦合，后端服务的耦合也到达了难以维护的状态，梳理开发这套业务对开发来讲简直就是噩梦，不小心踩到坑就炸了。。。

简单提下这块的概念，不做更多评判。毕竟微服务可使用各种编程语言，这里只针对我司Java技术栈。

> 微服务是相对较小的自主服务，每个服务都是相互独立开发和部署的，它们合作完成工作。每个服务都实现一种业务需求。

### 小型且专注于业务领域

微服务通常负责一个精细的工作单元，所以它在规模上相对较小。一条著名的指导原则是"两块披萨的团队规模"方案，意思是说，如果两块披萨不能将整个团队喂饱，那么这个开发微服务的团队可能太大了。微服务必须足够小，使得团队中的每个人都能理解该服务的整体设计和实现。另外，它的大小必须足以让团队在必要时轻松地维护或重写服务。

微服务的另一个重要特征是，每个服务专注负责一项精细的业务。

### 与技术中立

开发微服务的团队必须使用他们熟悉的技术。不要规定开发团队应该使用何种编程语言。让开发人员自由选择对任务最有意义的技术和执行任务的人。这种工作方式能够充分利用团队成员拥有的最佳技术和技能。微服务架构仍需要技术决策；举例而言，使用具象状态传输 (REST) 应用编程接口 (API) 访问更好一些，还是使用某种类型的排队来访问更好一些？但是，一般而言，您可以为微服务架构选择广泛范围内的任何技术。

### 松散耦合

松散耦合对基于微服务的系统至关重要。每个微服务都必须采用使其与其他服务的关联很小的方式来设计接口。这样，在更改一个服务并部署它时，就无需更改和重新部署系统的其他部分。

为了避免服务之间的耦合，必须了解导致紧密耦合的原因。紧密耦合的一个原因是通过 API 公开服务的内部实现。这种公开方式将服务的使用者与它的内部实现绑定在一起，从而导致更高的耦合度。在这种情况下，如果更改微服务的内部架构，可能还需要更改服务的使用者，否则就会破坏使用者。这可能会增加更改的成本，给实现更改带来潜在隐患，进而增加服务中的技术债务。必须避免任何导致公开服务的内部实现的方法，以确保微服务之间松散耦合。

必须避免一个服务内的实现过于分散，方法是将表示业务实体的相关属性、行为放在尽可能相近的地方。将相关属性放在一个微服务中；如果更改某个属性或行为，可以在一个位置更改它并快速部署该更改。否则，必须在不同部分中执行更改，然后同时一起部署这些散乱的部分；这会导致这些部门之间紧密耦合。

每个微服务必须有自己的源代码管理存储，以及用于构建和部署的交付管道。这样即可在必要时部署每个服务，而不需要与其他服务的所有者进行协调。如果您有两个服务，而且始终在一次部署中一起发布这两个服务，这可能表明两个服务最好合并为一个服务，而且必须对当前服务执行更多分解工作。松散耦合还支持更频繁、更快速的部署，最终提高应用程序对其用户需求的响应能力。

### 容易观察

微服务架构要求您能够可视化系统中所有服务的健康状态，以及它们之间的连接。这使您能快速找到并响应可能发生的问题。实现可视化的工具包含一种全面的日志机制，能够记录日志，存储日志，并使日志容易搜索，以便执行更有效的分析。

向系统中配置和添加的新服务越多，让这些服务变得可观察就会越难。因为在添加更多动态部分时，微服务架构会增加复杂性，所以观察设计必须明确，使可视化的日志和监视数据能为分析提供有帮助的信息。所以服务治理、配置管理、日志监控追踪系统需要完善可控。


## 前端工程化

现在已经是2017年Q4了，前端经历了各种框架的百花齐放，前后端协作也有了更清晰的方式。传统基于后端View层刀耕火种的方式已经不适用于现代化、移动优先的APP应用。前端的需求和职责变得越来越多，前端工程化势在必行。

### 开发规范

 - 技术选型和统一的代码规范。
 - 前端资源的处理。（资源定位、内容嵌入、依赖声明等）
 - css预处理器使用
 - mock数据平台

### 共享需求（业务沉淀）

对于公司而言，快速高效地实现业务是终极目标，这对前后端来说都是挑战。在前端团队中，能够形成基础组件库和业务组件库是一种必然需求。

所以在设计前端项目架构的时候，一定要考虑业务的组件化和可共享性。有人说开发通用组件是造轮子，其实造出符合自己的轮子何尝不是一种领悟。共享需求主要有四种：基础代码共享、通用工具方法共享、基础交互组件共享以及业务组件共享。

### 性能需求

优化方向是减少HTTP请求数量，缓存利用，页面结构：

 - js/css脚本合并压缩
 - 压缩图片和使用图片Sprite技术
 - 移除重复脚本
 - 减少dom操作
 - 使用cdn
 - 将CSS和JS放到外部文件中引用，CSS放头，JS放尾

这些过程都可以在前端工程的构建过程中使用 FIS、Grunt/Gulp、webpack 等构建工具实现。

### 部署需求

前端工程通常是由多人维护的，所以会用代码管理工具来管理源码，然后将开发流程和部署流程与 git 结合起来。多人分支协作流程：用 git flow 来管理代码分支。

静态资源的脚本可以结合构建过程及Jenkins部署过程上传cdn，然后替换页面资源，需要自行实现部署脚本。


## 前后端分离
 
说到前端工程化，不得不提前后端分离架构。这里的分离不是狭义上基于浏览器的前后端分离，也就是 Web 端通过 ajax 调用接口，使用 JS 把数据渲染到页面上。我们说的分离是**面向服务架构**的开发方式，团队开发中的沟通成本以及职责明确特别重要。而前后端分离的意义主要在于解耦，解耦后前后端职责划分更明确，前端能做的事也越来越多。

### 如何前后端分离

**怎么做前后端分离?大方向就是**

后端专注于：后端控制层(Restful API) & 服务层 & 数据访问层;
前端专注于：前端控制层(Nodejs) & 视图层

**分离模式**

 1. 项目设计阶段，前后端架构负责人将项目整体进行分析，讨论并确定API风格、职责分配、开发协助模式，确定人员配备;设计确定后，前后端人员共同制定开发接口。
 2. 项目开发阶段，前后端分离是各自分工，协同敏捷开发，后端提供Restful API，并给出详细文档说明，前端人员进行页面渲染前台的任务是发送API请(GET,PUT,POST,DELETE等)获取数据(json，xml)后渲染页面。
 3. 项目测试阶段，API完成之前，前端人员会使用mock server进行模拟测试，后端人员采用junit进行API单元测试，不用互相等待;API完成之后，前后端再对接测试一下就可以了，当然并不是所有的接口都可以提前定义，有一些是在开发过程中进行调整的。
 4. 项目部署阶段，利用nginx 做反向代理，即Java + nodejs + nginx 方式进行。

**模式图解：**

后端控制层基于HTTP协议给前端提供Restful API，前端用node包一层HTTP请求，输出JSON或HTML。这种模式性能上会有些许损耗，但是对于分离的意义和价值来讲微不足道。如果后端基于RPC协议提供接口，这里的性能损耗可以忽略不计。

![架构图][1]

![架构图][2]


## 参考资源

 - [微服务][4]
 - [关于微服务和 Java 需要知道的 5 件事][5]


  [1]: http://mmbiz.qpic.cn/mmbiz_png/TCHicQEF6XKCR2kSZWUbbeYXU3e1uJbNQV4LlMApy8ydbia2okMm2DdyibfFZjtzYZy3dv0AXZnVMY5XfgFsibXzOQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1
  [2]: http://7xaw6e.com1.z0.glb.clouddn.com/wp-content/uploads/2015/07/05/20150705_5598e40704303.png
  [3]: http://7fvkfx.com1.z0.glb.clouddn.com/QQ%E6%88%AA%E5%9B%BE20170922155211.png
  [4]: https://www.ibm.com/developerworks/cn/java/j-cn-java-and-microservice-1st/index.html
  [5]: https://www.ibm.com/developerworks/cn/java/j-cn-java-and-microservice-5-reason/index.html