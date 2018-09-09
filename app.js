const express = require('express');
const proxy = require('http-proxy-middleware');

const app = express();

app.use('/', express.static('homework-uploader/dist'));

app.use('/admin', express.static('homework-uploader-manage/dist'));

app.use('/api', proxy({
    target: '127.0.0.1:4000',
    changeOrigin: true,
    cookieDomainRewrite: true
}))

app.listen(80, () => {
    console.log("App is running on http://localhost:80");
})