title: Docker学习之路(一)
date: 2016-08-30 16:26:34
tags: docker
---

最近在玩Docker，折腾了两天基本入门了，并实践了一下把自己的博客Docker化，虽然很简单，但是容器跑起来还是感觉很兴奋。

## 为什么要玩Docker

早就听闻Docker大名，却一直充满敬畏。最近在搞一些前端自动化构建的事情，就想着学一下Docker，在容器中实现应用的环境、依赖统一，自动化构建以及持续集成。

## 入门指南

关于Docker安装和入门这里不再赘述了，[官方文档](https://docs.docker.com/)，当然了如果你想找中文资料，这里给你推荐[Docker — 从入门到实践](https://yeasy.gitbooks.io/docker_practice/content/)。

## 博客Docker化实践

> 目标：基于nodejs的基础镜像，把我的博客应用docker化。

写在前面：由于我的博客是用hexo的，所以docker化无非是把博客包装一下放到容器中，最终在容器中执行generate 和 deploy。

### 1.通过Dockerfile产生应用镜像

	# 使用nodejs基础镜像
	FROM node:4.5.0

	# Maintainer: 镜像作者
	MAINTAINER Iversong songliangking@email.com

	# 配置默认放置 App 的目录
	RUN mkdir -p /usr/src/app
	COPY . /usr/src/app
	WORKDIR /usr/src/app

	# 安装依赖
	RUN npm install -g hexo-cli \
		&& npm install \
		&& hexo generate

	# 启动容器自动运行博客
	CMD [ "hexo", "server" ]

### 2.构建镜像

有了Dockerfile以后，就可以通过下面的命令构建镜像并命名为docker-hexo-blog

	docker build -t docker-hexo-blog

### 3.从镜像启动容器

	docker run docker-hexo-blog


以上配置仅演示了一个应用如何docker化，当然了我的博客在镜像构建中集成了生成和部署功能，并使用daocloud的构建功能，以后写完博客的markdown提交github，daocloud就会自动构建镜像并且部署博客，是不是很赞^_^.
