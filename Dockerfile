FROM node:4.5.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

# Install dependences
RUN cd /usr/src/app \
	npm install --production

CMD [ "node" ]