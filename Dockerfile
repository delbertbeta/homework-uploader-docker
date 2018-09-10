FROM node:alpine

WORKDIR /app

ADD . /app

RUN npm install -g cnpm && \
    cd /app/homework-uploader && \
    cnpm install && \
    cnpm run build && \
    cd /app/homework-uploader-manage && \
    cnpm install && \
    cnpm run build && \
    cd /app/homework-uploader-api && \
    cnpm install && \
    echo "module.exports = {\
    database: {\
        type: 'sqlite',\
        url: 'data/db.sqlite'\
      }\
    };" > config.js && \
    cnpm install -g forever && \
    cd /app && \
    cnpm install

EXPOSE 80

CMD [ "node", "app.js" ]
