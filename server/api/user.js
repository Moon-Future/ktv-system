const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')
const { rootCode } = require('../secret.js')

router.post('/register', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const account = data.account
    const password = data.password
    const type = data.userType
    const code = data.code
    const name = data.name
    if (code != rootCode[type] && code != rootCode[type]) {
      ctx.body = {code: 500, message: '注册码错误'}
      return
    }
    const result = await query(`SELECT * FROM user WHERE account = ? AND off != 1`, [account])
    if (result.length !== 0) {
      ctx.body = {code: 500, message: `用户 ${account} 已存在`}
      return
    }
    await query(`INSERT INTO user (name, account, password, type, root, createTime) VALUES ( ?, ?, ?, ?, ?, ? )`, [name, account, password, type, type, new Date().getTime()])
    ctx.body = {code: 200, message: '注册成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/login', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const account = data.account
    const password = data.password
    const result = await query(`SELECT * FROM user WHERE account = ? AND off != 1`, [account])
    if (result.length === 0) {
      ctx.body = {code: 500, message: '用户不存在'}
    } else if(result[0].password !== password) {
      ctx.body = {code: 500, message: '密码错误'}
    } else {
      let userInfo = result[0]
      delete userInfo.password
      ctx.session.userInfo = userInfo
      ctx.body = {code: 200, message: '登陆成功', userInfo: userInfo}
    }
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/logout', async (ctx) => {
  try {
    ctx.session = null
    ctx.body = {code: 200, message: '已退出'}
  } catch(err) {
    throw new Error(err)
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
    throw new Error(err)
  }
})

router.post('/getUser', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const result = await query(`SELECT * FROM user WHERE off != 1`)
    ctx.body = {code: 200, message: result}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deleteUser', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }
      
    const data = ctx.request.body.data
    if (data[0].root == 1) {
      ctx.body = {code: 500, message: '无法删除'}
      return
    }
    await query(`UPDATE user SET off = 1 WHERE id = ?`, [data[0].id])
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router