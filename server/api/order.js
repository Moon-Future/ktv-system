const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')

router.post('/insertOrder', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    const data = ctx.request.body.data
    ctx.body = {code: 200, message: '新增成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getOrder', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const order = await query(`SELECT * FROM roomorder WHERE room = '${data.no}' AND off = 0`)
    ctx.body = {code: 200, message: order}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deleteUnit', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    let ids = []
    data.forEach(ele => {
      ids.push(ele.id)
    })
    await query(`UPDATE unit SET off = 1, updateTime = ${new Date().getTime()} WHERE id IN ( ${ids.join()} )`)
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/updUnit', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const check = await query(`SELECT * FROM unit WHERE name = '${data.name}' AND off != 1`)
    if (check.length !== 0 && check[0].id != data.id) {
      ctx.body = {code: 500, message: `单位 ${data.name} 已存在`}
      return
    }
    await query(`UPDATE unit SET name = '${data.name}', sign = '${data.sign}', updateTime = ${new Date().getTime()} WHERE id = ${data.id}`)
    const result = await query(`SELECT * FROM unit WHERE off != 1 AND id = ${data.id}`)
    ctx.body = {code: 200, message: '更新成功', result: result}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router