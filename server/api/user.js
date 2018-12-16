const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const { rootCode } = require('../secret.js')

router.post('/register', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const name = data.name
    const account = data.account
    const password = data.password
    const root = data.root
    if (root != rootCode['1'] && root != rootCode['0']) {
      ctx.body = {code: 500, message: '注册码错误'}
      return
    }
    const result = await query(`SELECT * FROM user WHERE account = '${account}'`)
    if (result.length !== 0) {
      ctx.body = {code: 500, message: `用户 ${account} 已存在`}
      return
    }
    await query(`INSERT INTO user (name, account, password, root, createTime) VALUES ( '${name}', '${account}', '${password}', ${root == rootCode['1'] ? 1 : 0}, ${new Date().getTime()} )`)
    ctx.body = {code: 200, message: '注册成功'}
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/login', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const account = data.account
    const password = data.password
    const result = await query(`SELECT * FROM user WHERE account = '${account}'`)
    if (result.length === 0) {
      ctx.body = {code: 500, message: '用户不存在'}
    } else if(result[0].password !== password) {
      ctx.body = {code: 500, message: '密码错误'}
    } else {
      ctx.session.userInfo = {id: result[0].id, name: result[0].name, root: result[0].root}
      ctx.body = {code: 200, message: '登陆成功'}
    }
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/logout', async (ctx) => {
  try {
    ctx.session = null
    ctx.body = {code: 200, message: '已退出'}
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/getSession', async (ctx) => {
  try {
    const userInfo = ctx.session.userInfo
    if (userInfo) {
      ctx.body = {code: 200, message: userInfo}
    } else {
      ctx.body = {code: 500, message: '请先登陆'}
    }
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

module.exports = router