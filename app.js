const express = require('express');
const proxy = require('http-proxy-middleware');
const exec = require('child_process').exec;

const app = express();

exec('cd /app/homework-uploader-api && forever start app.js');

app.use('/', express.static('homework-uploader'));

app.use('/admin', express.static('homework-uploader-manage'));

app.use('/api', proxy({
    target: 'http://127.0.0.1:4000',
    changeOrigin: true,
    cookieDomainRewrite: true
}))

app.listen(80, () => {
    console.log("App is running on http://localhost:80");
})
