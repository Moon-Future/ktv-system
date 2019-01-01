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
    const createTime = new Date().getTime()
    const ordInfo = data.ordInfo || {}
    const packageId = ordInfo.package && ordInfo.package.package || ''
    const goodsMap = ordInfo.goods || {}
    let goodsList = [], qtyList = []
    for (let key in goodsMap) {
      goodsList.push(goodsMap[key].id)
      qtyList.push(goodsMap[key].qty)
    }
    await query(`INSERT INTO roomorder (room, status, package, goods, qty, startTime, cust, createTime) VALUES 
      ('${ordInfo.no}', 1, '${packageId}', '${goodsList.join(',')}', '${qtyList.join(',')}', ${data.startTime}, '${ordInfo.cust || ''}', ${createTime})`)
    await query(`UPDATE room SET status = 1 WHERE no = '${ordInfo.no}'`)
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
    const ordInfo = await query(`SELECT * FROM roomorder WHERE room = '${data.no}' AND off = 0`)
    if (ordInfo.length !== 0) {
      let packageMap = {}
      const packageList = await query(`SELECT p.descr, p.name as packagem, p.uuid as package, p.price, p.qty, g.id as goods, g.name as goodsm, u.name as unitm
        FROM package as p 
        LEFT JOIN goods as g on p.goods = g.id
        LEFT JOIN unit as u on g.unit = u.id
        WHERE p.uuid = '${ordInfo[0].package}'`)
      packageMap = {descr: packageList[0].descr, package: packageList[0].package, packagem: packageList[0].packagem, price: packageList[0].price, goods: []}
      packageList.forEach(ele => {
        packageMap.goods.push({goods: ele.goods, goodsm: ele.goodsm, qty: ele.qty, unitm: ele.unitm})
      })
      ordInfo[0].package = packageMap

      const goodsList = ordInfo[0].goods ? ordInfo[0].goods.split(',') : []
      const qtyList = ordInfo[0].qty ? ordInfo[0].qty.split(',') : []
      let goodsMap = {}
      for (let i = 0, len = goodsList.length; i < len; i++) {
        let result = await query(`SELECT * FROM goods WHERE id = ${goodsList[i]}`);
        goodsMap[goodsList[i]] = result[0]
        goodsMap[goodsList[i]].qty = qtyList[i]
      }
      ordInfo[0].goods = goodsMap

      ordInfo[0].no = ordInfo[0].room
    }
    ctx.body = {code: 200, message: ordInfo}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deleteOrder', async (ctx) => {
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

router.post('/updOrder', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const ordInfo = data.ordInfo
    const type = data.type
    if (type === 'package') {
      await query(`UPDATE roomorder SET package = '${ordInfo.package.package}' WHERE off != 1 AND room = '${ordInfo.no}'`)
    } else if (type === 'goods') {
      const goodsMap = ordInfo.goods || {}
      let goodsList = [], qtyList = []
      for (let key in goodsMap) {
        goodsList.push(goodsMap[key].id)
        qtyList.push(goodsMap[key].qty)
      }
      await query(`UPDATE roomorder SET goods = '${goodsList.join(',')}', qty = '${qtyList.join(',')}' WHERE off != 1 AND room = '${ordInfo.no}'`)
    }
    ctx.body = {code: 200, message: '更新成功'}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router