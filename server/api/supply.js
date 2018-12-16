const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')

router.post('/insertSupply', async (ctx) => {
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
      const supply = await query(`SELECT * FROM supply WHERE cust = ${item.cust} AND prd = ${item.prd} AND off != 1`)
      if (supply.length !== 0) {
        result.push(item.nun)
        continue
      }
      await query(`INSERT INTO supply (cust, prd, nun, createTime) VALUES (${item.cust}, ${item.prd}, '${item.nun}', ${currentTime})`)
    }
    if (result.length === 0) {
      ctx.body = {code: 200, message: '新增成功'}
    } else {
      ctx.body = {code: 200, message: `编码 ${result.join(', ')} 所在行已存在`, repeat: true}
    }
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/getSupply', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx, true)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const pageNo = data && data.pageNo || 1
    const pageSize = data && data.pageSize || 10
    let supplyList
    let count
    let number
    if (data) {
      if (data.pageNo) {
        count = await query(`SELECT COUNT(*) as count FROM supply WHERE off != 1`)
        supplyList = await query(
          `
          SELECT s.id, s.nun, c.name as custm, p.name as prdm, p.model, u.name as unitm 
          FROM supply s, company c, product p, unit u 
          WHERE s.cust = c.id AND s.prd = p.id AND p.unit = u.id
          AND s.off != 1 ORDER BY s.createTime ASC LIMIT ${(pageNo - 1) * pageSize}, ${pageSize}
          `
        )
        ctx.body = {code: 200, message: supplyList, count: count[0].count}
      } else if (data.customerId) {
        const customerId = data.customerId
        supplyList = await query(
          `
          SELECT s.id, s.nun, c.name as custm, c.id as cust, p.name as prdm, p.model, p.id as prd, u.name as unitm, u.id as unit
          FROM supply s, company c, product p, unit u 
          WHERE s.cust = ${customerId} AND s.cust = c.id AND s.prd = p.id AND p.unit = u.id
          AND s.off != 1 ORDER BY s.createTime ASC
          `
        )
        number = await query(`SELECT * FROM counter WHERE type = 'delivery' AND cust = ${customerId}`)
        if (number.length === 0) {
          await query(`INSERT INTO counter (number, cust, type, time) VALUES (0, ${customerId}, 'delivery', ${new Date().getTime()})`)
          number = await query(`SELECT * FROM counter WHERE type = 'delivery' AND cust = ${customerId}`)
        } else {
          // 下个月重置为0
          const time = new Date(number[0].time)
          const currentTime = new Date()
          if (currentTime.getFullYear() + '_' + (currentTime.getMonth() + 1) !== time.getFullYear() + '_' + (time.getMonth() + 1)) {
            number[0].number = 0
          }
        }
        ctx.body = {code: 200, message: {supplyList, number}}
      }
    } else {
      supplyList = await query(
        `
        SELECT s.id, s.nun, c.name as custm, c.id as cust, p.name as prdm, p.id as prd, p.model, u.name as unitm 
        FROM supply s, company c, product p, unit u 
        WHERE s.cust = c.id AND s.prd = p.id AND p.unit = u.id
        AND s.off != 1 ORDER BY s.createTime ASC
        `
      )
      ctx.body = {code: 200, message: supplyList}
    }
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/deleteSupply', async (ctx) => {
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
    await query(`UPDATE supply SET off = 1, updateTime = ${new Date().getTime()} WHERE id IN ( ${ids.join()} )`)
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/updSupply', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const check = await query(`SELECT * FROM supply WHERE cust = ${data.cust} AND prd = ${data.prd} AND off != 1`)
    if (check.length !== 0 && check[0].id != data.id) {
      ctx.body = {code: 500, message: '已存在相同数据'}
      return
    }
    const upd = await query(`UPDATE supply SET cust = ${data.cust}, prd = ${data.prd}, nun = '${data.nun}', updateTime = ${new Date().getTime()} WHERE id = ${data.id}`)
    const result = await query(
        `
        SELECT s.id, s.nun, c.name as custm, p.name as prdm, p.model, u.name as unitm
        FROM supply s, company c, product p, unit u 
        WHERE s.cust = c.id AND s.prd = p.id AND p.unit = u.id
        AND c.off != 1 AND s.id = ${data.id}
        `
      )
    ctx.body = {code: 200, message: '更新成功', result: result}
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/getOptions', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const customer = await query(`SELECT * FROM company WHERE type = 0 AND off != 1`)
    const product = await query(`SELECT * FROM product WHERE off != 1`)
    let result = {customer, product}
    ctx.body = {code: 200, message: result}
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

module.exports = router