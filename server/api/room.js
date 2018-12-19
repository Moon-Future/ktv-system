const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')

router.post('/insertRoomType', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }

    const data = ctx.request.body.data
    let result = []
    for (let i = 0 , len = data.length; i < len; i++) {
      const item = data[i]
      const currentTime = new Date().getTime()
      const roomtype = await query(`SELECT * FROM roomtype WHERE name = '${item.name}' AND off != 1`)
      if (roomtype.length !== 0) {
        result.push(item.name)
        continue
      }
      await query(`INSERT INTO roomtype (name, createTime) VALUES ('${item.name}', ${currentTime})`)
    }
    if (result.length === 0) {
      ctx.body = {code: 200, message: '新增成功'}
    } else {
      ctx.body = {code: 200, message: `包间类型 ${result.join(', ')} 已存在`, repeat: true}
    }
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getRoomType', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const pageNo = data && data.pageNo || 1
    const pageSize = data && data.pageSize || 10
    const count = await query(`SELECT COUNT(*) as count FROM roomtype WHERE off != 1`)
    const roomTypeList = await query(`SELECT * FROM roomtype WHERE off != 1 ORDER BY createTime ASC LIMIT ${(pageNo - 1) * pageSize}, ${pageSize}`)
    ctx.body = {code: 200, message: roomTypeList, count: count[0].count}
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