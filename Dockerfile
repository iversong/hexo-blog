FROM node:4.5.0

RUN mkdir -p /usr/src/app

COPY . /usr/src/app
WORKDIR /usr/src/app

# Install dependences
RUN npm install -g hexo-cli \
	&& npm install

CMD [ "node" ]