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
    let ordInfo = await query(`SELECT * FROM roomorder WHERE room = ? AND off != 1`, [data.no])

    if (ordInfo.length !== 0) {
      if (ordInfo[0].vip) {
        const vipInfo = await query(`SELECT balance FROM vip WHERE phone = ? AND off != 1`, [ordInfo[0].vip])
        ordInfo[0].balance = vipInfo[0].balance
      }
      let packageMap = {}
      const packageList = await query(`SELECT p.descr, p.name as packagem, p.uuid as package, p.type1, p.type2, p.price1, p.price2, p.qty, p.grp, g.id as goods, g.name as goodsm, u.name as unitm
        FROM package as p 
        LEFT JOIN goods as g on p.goods = g.id
        LEFT JOIN unit as u on g.unit = u.id
        WHERE p.uuid = ?`, [ordInfo[0].package])
      packageMap = {descr: packageList[0].descr, package: packageList[0].package, packagem: packageList[0].packagem, type: ordInfo[0].packageType, grpSelected: ordInfo[0].grpSelected,
        type1: packageList[0].type1, type2: packageList[0].type2, price1: packageList[0].price1, price2: packageList[0].price2, grp: packageList[0].grp || '', goods: []}
      packageList.forEach(ele => {
        if (ele.goods) {
          packageMap.goods.push({goods: ele.goods, goodsm: ele.goodsm, qty: ele.qty, unitm: ele.unitm})
        }
      })
      ordInfo[0].package = packageMap

      const goodsList = ordInfo[0].goods ? ordInfo[0].goods.split(',') : []
      const qtyList = ordInfo[0].qty ? ordInfo[0].qty.split(',') : []
      let goodsMap = {}
      for (let i = 0, len = goodsList.length; i < len; i++) {
        let result = await query(`SELECT g.id, g.name, g.picture, g.price, g.descr, g.vipDiscount, g.discount, g.qty, g.record,
          u.id as unit, u.name as unitm FROM goods g, unit u WHERE u.id = g.unit AND g.id = ?`, [goodsList[i]])

        goodsMap[goodsList[i]] = result[0]
        goodsMap[goodsList[i]].qty = qtyList[i]
      }
      ordInfo[0].goods = goodsMap

      const stockGoodsList = ordInfo[0].stockGoods ? ordInfo[0].stockGoods.split(',') : []
      const stockQtyList = ordInfo[0].stockQty ? ordInfo[0].stockQty.split(',') : []
      let stockGoods = []
      for (let i = 0, len = stockGoodsList.length; i < len; i++) {
        let result = await query(`SELECT g.id as goods, g.name as goodsm,
          u.id as unit, u.name as unitm FROM goods g, unit u WHERE u.id = g.unit AND g.id = ?`, [stockGoodsList[i]])
        result[0].depositQty = stockQtyList[i]
        stockGoods.push(result[0])
      }
      ordInfo[0].goods = goodsMap
      ordInfo[0].stockGoods = stockGoods

      ordInfo[0].no = ordInfo[0].room
      delete ordInfo[0].packageType
      delete ordInfo[0].grpSelected
      delete ordInfo[0].qty
      delete ordInfo[0].stockQty
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
    if (ordInfo.vip) {
      await query(`UPDATE vip SET balance = ?, status = ? WHERE phone = ? AND off != 1`, [Number(ordInfo.totalPrice) - Number(ordInfo.discount || 0), 0, ordInfo.vip])
    }
    await query(`UPDATE roomorder SET off = 1, endTime = ? WHERE nun = ?`, [new Date().getTime(), ordInfo.nun])
    await query(`UPDATE room SET status = 0 WHERE no = ?`, [ordInfo.room])
    
    const result = await query(`SELECT * FROM vipstock WHERE nun = ? AND vip = ? AND off != 1`, [ordInfo.nun, ordInfo.vip])
    for (let i = 0, len = result.length; i < len; i++) {
      const exist = await query(`SELECT * FROM vipstock WHERE nun = '' AND vip = ? AND goods = ? AND off != 1`, [ordInfo.vip, result[i].goods])
      if (exist.length !== 0) {
        await query(`UPDATE vipstock SET qty = ? WHERE nun = '' AND vip = ? AND goods = ? AND off != 1`, [Number(exist[0].qty) + Number(result[i].qty), ordInfo.vip, result[i].goods])
        await query(`DELETE FROM vipstock WHERE nun = ? AND vip = ? AND goods = ? AND off != 1`, [ordInfo.nun, ordInfo.vip, result[i].goods])
      } else {
        await query(`UPDATE vipstock SET nun = '' WHERE nun = ? AND vip = ? AND goods = ? AND off != 1`, [ordInfo.nun, ordInfo.vip, result[i].goods])
      }
    }

    ctx.body = {code: 200, message: '结账成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/cancelOrder', async (ctx) => {
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
    if (ordInfo.vip) {
      await query(`UPDATE vip SET status = ? WHERE phone = ? AND off != 1`, [0, ordInfo.vip])
    }
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
    const stockGoods = ordInfo.stockGoods || []
    let goodsList = [], qtyList = []
    let stockGoodsList = [], stockQtyList = []
    for (let key in goodsMap) {
      goodsList.push(goodsMap[key].id)
      qtyList.push(goodsMap[key].qty)
    }
    stockGoods.forEach(ele => {
      if (ele.depositQty != 0) {
        stockGoodsList.push(ele.goods)
        stockQtyList.push(ele.depositQty)
      }
    })

    await query(`UPDATE roomorder SET package = ?, packageType = ?, grpSelected = ?, goods = ?, qty = ?, stockGoods = ?, stockQty = ?, vip = ?, totalPrice = ?, discount = ?, paymethod = ? WHERE room = ? AND off != 1`, 
      [packageId, packageType, grpSelected, goodsList.join(','), qtyList.join(','), stockGoodsList.join(','), stockQtyList.join(','), ordInfo.vip, ordInfo.totalPrice, ordInfo.discount, ordInfo.payMethod, ordInfo.room]
    )
    ctx.body = {code: 200, message: '更新成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getOrderHistory', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }

    const data = ctx.request.body.data
    let ordInfo = await query(`SELECT * FROM roomorder WHERE off = 1 ORDER BY createTime DESC`)
    let count = await query(`SELECT COUNT(*) as count FROM roomorder WHERE off = 1`)
    let result = []

    for (let i = 0, len = ordInfo.length; i < len; i++) {
      var item = ordInfo[i]
      if (item.vip) {
        const vipInfo = await query(`SELECT balance FROM vip WHERE phone = ? AND off != 1`, [item.vip])
        item.balance = vipInfo[0].balance
      }
      let packageMap = {}
      const packageList = await query(`SELECT p.descr, p.name as packagem, p.uuid as package, p.type1, p.type2, p.price1, p.price2, p.qty, p.grp, g.id as goods, g.name as goodsm, u.name as unitm
        FROM package as p 
        LEFT JOIN goods as g on p.goods = g.id
        LEFT JOIN unit as u on g.unit = u.id
        WHERE p.uuid = ?`, [item.package])
      packageMap = {descr: packageList[0].descr, package: packageList[0].package, packagem: packageList[0].packagem, type: item.packageType, grpSelected: item.grpSelected,
        type1: packageList[0].type1, type2: packageList[0].type2, price1: packageList[0].price1, price2: packageList[0].price2, grp: packageList[0].grp || '', goods: []}
      packageList.forEach(ele => {
        if (ele.goods) {
          packageMap.goods.push({goods: ele.goods, goodsm: ele.goodsm, qty: ele.qty, unitm: ele.unitm})
        }
      })
      item.package = packageMap

      const goodsList = item.goods ? item.goods.split(',') : []
      const qtyList = item.qty ? item.qty.split(',') : []
      let goodsMap = {}
      for (let i = 0, len = goodsList.length; i < len; i++) {
        let result = await query(`SELECT * FROM goods WHERE id = ${goodsList[i]}`);
        goodsMap[goodsList[i]] = result[0]
        goodsMap[goodsList[i]].qty = qtyList[i]
      }
      item.goods = goodsMap

      item.no = item.room
      delete item.packageType
      delete item.grpSelected
      delete item.qty
      result.push(item)
    }
    ctx.body = {code: 200, message: result, count: count.length === 0 ? 0 : count[0].count}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router