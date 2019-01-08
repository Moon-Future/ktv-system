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
    
    const count = await query(`SELECT COUNT(*) as count FROM goods WHERE off != 1`)
    const goodsList = await query(`SELECT g.id, g.name, g.picture, g.price, g.descr, g.vipDiscount, g.discount, g.qty, g.record,
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

    // 查找当前以开单包间是否存在该商品
    let roomorder = await query(`SELECT * FROM roomorder WHERE goods LIKE '%?%' AND off != 1`, [goods.id])
    if (roomorder.length !== 0) {
      ctx.body = {code: 500, message: '已开单包间中存在该商品，暂时无法删除！'}
      return
    }

    // 查找当前以开单包间套餐中是否存在该商品
    let packageList = await query(`SELECT * FROM package WHERE goods = ?`, [goods.id])
    if (packageList.length !== 0) {
      for (let i = 0, len = packageList.length; i < len; i++) {
        let roomorder = await query(`SELECT * FROM roomorder WHERE package = ? AND off != 1`, [packageList[i].uuid])
        if (roomorder.length !== 0) {
          ctx.body = {code: 500, message: '已开单包间中所选套餐存在该商品，暂时无法删除！'}
          return
        }
      }
    }

    await query(`DELETE FROM package WHERE goods = ?`, [goods.id])
    packageList = await query(`SELECT * FROM package WHERE grp LIKE '%?%'`, [goods.id])
    for (let i = 0, len = packageList.length; i < len; i++) {
      let grp = packageList[i].grp.split(',')
      grp.splice(grp.indexOf(goods.id + ''), 1)
      grp = grp.join(',')
      await query(`UPDATE package SET grp = ?, updateTime = ? WHERE id = ?`, [grp, currentTime, packageList[i].id])
    }

    await query(`UPDATE goods SET off = 1, updateTime = ? WHERE id = ?`, [new Date().getTime(), goods.id])
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

router.post('/stockIn', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const params = data.params
    const qty = data.qty
    const currentTime = new Date().getTime()
    await query(`INSERT INTO goodsqty (goods, qty, user, time, createTime) VALUES (?, ?, ?, ?, ?)`, 
      [params.id, qty, ctx.session.userInfo.name, currentTime, currentTime])
    const result = await query(`SELECT * FROM goods WHERE id = ? AND off != 1`, [params.id])
    await query(`UPDATE goods SET qty = ? WHERE id = ?`, [Number(result[0].qty) + Number(qty), params.id])
    ctx.body = {code: 200, message: '入库成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getStock', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const id = data.id
    const result = await query(`SELECT q.id, q.goods, q.qty, q.user, q.time, g.name FROM goodsqty as q LEFT JOIN goods as g ON q.goods = g.id WHERE q.goods = ? AND q.off != 1 ORDER BY q.time ASC`, [id])
    ctx.body = {code: 200, message: result}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deleteStock', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const params = data.params
    await query(`UPDATE goodsqty SET off = 1 WHERE id = ?`, [params.id])
    const result = await query(`SELECT * FROM goods WHERE id = ? AND off != 1`, [params.goods])
    await query(`UPDATE goods SET qty = ?, record = ? WHERE id = ?`, [Number(result[0].qty) - Number(params.qty), Number(result[0].record) - 1, params.goods])
    ctx.body = {code: 200}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router