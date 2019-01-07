const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')

router.post('/insertGoods', async (ctx) => {
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
      const goods = await query(`SELECT * FROM goods WHERE name = '${item.name}' AND off != 1`)
      if (goods.length !== 0) {
        result.push(item.name)
        continue
      }
      await query(`INSERT INTO goods (name, price, unit, descr, vipDiscount, discount, createTime) VALUES 
        ('${item.name}', ${item.price}, ${item.unit}, '${item.descr}', ${item.vipDiscount ? 1 : 0}, ${item.vipDiscount ? item.discount : null}, ${currentTime})`)
    }
    if (result.length === 0) {
      ctx.body = {code: 200, message: '新增成功'}
    } else {
      ctx.body = {code: 200, message: `商品 ${result.join(', ')} 已存在`, repeat: true}
    }
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getGoods', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const pageNo = data && data.pageNo || 1
    const pageSize = data && data.pageSize || 10
    const count = await query(`SELECT COUNT(*) as count FROM goods WHERE off != 1`)
    const goodsList = await query(`SELECT g.id, g.name, g.picture, g.price, g.descr, g.vipDiscount, g.discount,
      u.id as unit, u.name as unitm FROM goods g, unit u WHERE u.id = g.unit AND g.off != 1 ORDER BY g.createTime ASC`)
    goodsList.forEach(ele => {
      ele.vipDiscount = ele.vipDiscount === 1
    })
    ctx.body = {code: 200, message: goodsList, count: count[0].count}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deleteGoods', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const goods = data[0]
    const currentTime = new Date().getTime()

    await query(`DELETE FROM package WHERE goods = ?`, [goods.id])

    const packageList = await query(`SELECT * FROM package WHERE grp LIKE '%?%'`, [goods.id])
    for (let i = 0, len = packageList.length; i < len; i++) {
      let grp = packageList[i].grp.split(',')
      grp.splice(grp.indexOf(goods.id + ''), 1)
      grp = grp.join(',')
      await query(`UPDATE package SET grp = ?, updateTime = ? WHERE id = ?`, [grp, currentTime, packageList[i].id])
    }

    await query(`UPDATE goods SET off = 1, updateTime = ? WHERE id = ?`, [goods.id, new Date().getTime()])
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/updGoods', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const check = await query(`SELECT * FROM goods WHERE name = '${data.name}' AND off != 1`)
    if (check.length !== 0 && check[0].id != data.id) {
      ctx.body = {code: 500, message: `商品 ${data.name} 已存在`}
      return
    }
    await query(`UPDATE goods SET name = '${data.name}', price = ${data.price}, unit = ${data.unit}, descr = '${data.descr}',
      vipDiscount = ${data.vipDiscount ? 1 : 0}, discount = ${data.vipDiscount ? data.discount : null}, updateTime = ${new Date().getTime()} WHERE id = ${data.id}`)
    const result = await query(`SELECT * FROM goods WHERE off != 1 AND id = ${data.id}`)
    ctx.body = {code: 200, message: '更新成功', result: result}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router