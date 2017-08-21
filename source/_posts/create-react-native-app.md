title: 使用create-react-native-app创建react native应用
date: 2017-08-21 15:51:26
tags: create-react-native-app react-native
---

早期版本的时候创建react native应用需要大量的配置，很多人从配置环境就放弃了，直到社区推出了脚手架工具[create-react-native-app](https://github.com/react-community/create-react-native-app)
让不同平台的开发者可以非常简单快速的创建一个react native应用，省去配置，专注业务。

此处省略如何创建应用的过程，说一下我遇到的问题及解决方式。

项目创建成功后 `npm start` , 然后控制台就卡住了 `Starting packager...`，这是由于墙内网络环境造成的，解决方式是断开你的网络链接，然后重新  `npm start`，完美解决。