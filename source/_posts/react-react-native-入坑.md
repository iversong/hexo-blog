title: react react-native 入坑
date: 2017-08-11 10:48:46
tags: react react-native
---
很早之前就接触react，学习了阮一峰老师的教程，算是入门小白，一直没有实战的机会。刚好最近公司的后台数据可视化项目选型用到，算是正式入坑了，两周时间用下来体验很爽，符合其[简单直观，符合习惯]的开发理念。

react本身只是个view层库，API不是很多，jsx也很容易上手，了解其函数式编程思想，组件化，组件声明周期等核心，更多是搭配其它库（路由react-router,状态管理Redux）等全家桶做前端开发。我做的数据可视化项目是基于蚂蚁金服团队的[dva](https://github.com/dvajs/dva)和[ant-design](https://ant.design/)，dva是基于 redux、redux-saga、react-router@2.x轻薄封装的框架，简化了概念，很清晰的基于单项数据流的数据驱动模型。虽然没有直接上手Redux，核心理念应该一致，无非就是如何组织结构和约束开发及习惯的问题。

接下来会基于Facebook react团队提供的工具折腾一段时间，react-native、react-vr还是挺好玩的，已经踩到一些坑了，会陆续记录下来踩坑经历。

嗯，学无止境，这样才不会空虚。