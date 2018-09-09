FROM node:alpine

WORKDIR /app

ADD . /app

RUN cd /app/homework-uploader && \
    yarn install --production && \
    yarn run build && \
    cd /app/homework-uploader-manage && \
    yarn install --production && \
    yarn run build && \
    cd /app/homework-uploader-api && \
    yarn install --production && \
    echo "module.exports = {\
    database: {\
        type: 'sqlite',\
        url: 'data/db.sqlite'\
      }\
    };" > config.js && \
    yarn install -g forever && \
    forever start app.js && \
    cd /app && \
    yarn install --production

EXPOSE 80

CMD [ "node", "app.js" ]