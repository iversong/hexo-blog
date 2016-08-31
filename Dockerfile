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
	&& npm install

CMD [ "node" ]