const Koa = require('koa')
const session = require('koa-session')
const app = new Koa()
const bodyParser = require('koa-bodyparser')
const cors = require('koa2-cors')
const fs = require('fs')
const path = require('path')
const static = require('koa-static')
const router = require('./router')

const CONFIG = {
  key: 'koa:sess',
  maxAge: 0,
  autoCommit: true,
  overwrite: true,
  httpOnly: true,
  signed: true,
  rolling: false,
  renew: false
}
app.keys = ['login secret']
app.use(session(CONFIG, app));

const distPath = path.join(__dirname, '../dist')
const exists = fs.existsSync(distPath)
if (!exists) {
  fs.mkdirSync(distPath)
}

app.use(static(path.join(__dirname, '../dist')))
app.use(bodyParser())
app.use(cors())
app.use(router.routes()).use(router.allowedMethods())
app.listen(8889, () => {
  console.log('listen at port 8889...')
})