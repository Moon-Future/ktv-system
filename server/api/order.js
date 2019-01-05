const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')

function createNun() {
  const r1 = parseInt(Math.random() * 10)
  const r2 = parseInt(Math.random() * 10)
  const currentTime = new Date().getTime()
  return (r1+'') + (r2+'') + (currentTime+'')
}

router.post('/insertOrder', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    const data = ctx.request.body.data
    const nun = createNun()
    const createTime = new Date().getTime()
    const ordInfo = data.ordInfo || {}
    const packageId = ordInfo.package && ordInfo.package.package || ''
    const packageType = ordInfo.package && ordInfo.package.type || ''
    const grpSelected = ordInfo.package && ordInfo.package.grpSelected || ''
    const goodsMap = ordInfo.goods || {}
    let goodsList = [], qtyList = []
    for (let key in goodsMap) {
      goodsList.push(goodsMap[key].id)
      qtyList.push(goodsMap[key].qty)
    }
    await query(`INSERT INTO roomorder (nun, room, status, package, packageType, grpSelected, goods, qty, startTime, vip, totalPrice, discount, paymethod, user, createTime) VALUES 
      (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`, 
      [nun, ordInfo.room, 1, packageId, packageType, grpSelected, goodsList.join(','), qtyList.join(','), data.startTime, ordInfo.vip, ordInfo.totalPrice, ordInfo.discount, ordInfo.payMethod, ordInfo.user, createTime])
    await query(`UPDATE room SET status = 1 WHERE no = ?`, [ordInfo.room])
    ctx.body = {code: 200, message: nun}
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
    const ordInfo = await query(`SELECT * FROM roomorder WHERE room = ? AND off != 1`, [data.no])
    if (ordInfo.length !== 0) {
      let packageMap = {}
      const packageList = await query(`SELECT p.descr, p.name as packagem, p.uuid as package, p.type1, p.type2, p.price1, p.price2, p.qty, p.grp, g.id as goods, g.name as goodsm, u.name as unitm
        FROM package as p 
        LEFT JOIN goods as g on p.goods = g.id
        LEFT JOIN unit as u on g.unit = u.id
        WHERE p.uuid = ?`, [ordInfo[0].package])
      packageMap = {descr: packageList[0].descr, package: packageList[0].package, packagem: packageList[0].packagem, type: ordInfo[0].packageType, grpSelected: ordInfo[0].grpSelected,
        type1: packageList[0].type1, type2: packageList[0].type2, price1: packageList[0].price1, price2: packageList[0].price2, grp: packageList[0].grp, goods: []}
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
      delete ordInfo[0].packageType
      delete ordInfo[0].grpSelected
      delete ordInfo[0].qty
    }
    ctx.body = {code: 200, message: ordInfo}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/closeOrder', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const ordInfo = data.ordInfo
    await query(`UPDATE roomorder SET off = 1 WHERE nun = ?`, [ordInfo.nun])
    await query(`UPDATE room SET status = 0 WHERE no = ?`, [ordInfo.room])
    ctx.body = {code: 200, message: '结账成功'}
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
    const ordInfo = data.ordInfo || {}
    const packageId = ordInfo.package && ordInfo.package.package || ''
    const packageType = ordInfo.package && ordInfo.package.type || ''
    const grpSelected = ordInfo.package && ordInfo.package.grpSelected || ''
    const goodsMap = ordInfo.goods || {}
    let goodsList = [], qtyList = []
    for (let key in goodsMap) {
      goodsList.push(goodsMap[key].id)
      qtyList.push(goodsMap[key].qty)
    }

    await query(`UPDATE roomorder SET package = ?, packageType = ?, grpSelected = ?, goods = ?, qty = ?, vip = ?, totalPrice = ?, discount = ?, paymethod = ? WHERE room = ? AND off != 1`, 
      [packageId, packageType, grpSelected, goodsList.join(','), qtyList.join(','), ordInfo.vip, ordInfo.totalPrice, ordInfo.discount, ordInfo.payMethod, ordInfo.room]
    )
    ctx.body = {code: 200, message: '更新成功'}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router