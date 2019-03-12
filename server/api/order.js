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
    if (!checkRoot(ctx, true)) { return false }

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
    await query(`INSERT INTO roomorder (nun, room, package, packageType, grpSelected, goods, qty, startTime, vip, totalPrice, discount, paymethod, user, createTime) VALUES 
      (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`, 
      [nun, ordInfo.room, packageId, packageType, grpSelected, goodsList.join(','), qtyList.join(','), data.startTime, ordInfo.vip, ordInfo.totalPrice, ordInfo.discount, ordInfo.payMethod, ordInfo.user, createTime])
    await query(`UPDATE room SET status = 1 WHERE no = ?`, [ordInfo.room])
    ctx.body = {code: 200, message: nun}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getOrder', async (ctx) => {
  try {
    if (!checkRoot(ctx, true)) { return false }

    const data = ctx.request.body.data
    let ordInfo = await query(`SELECT * FROM roomorder WHERE room = ? AND close != 1 AND off != 1`, [data.no])

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
        result[0].stockQty = stockQtyList[i]
        stockGoods.push(result[0])
      }
      ordInfo[0].stockGoods = stockGoods

      ordInfo[0].payMoney = ordInfo[0].payMoney ? ordInfo[0].payMoney.split(',') : []
      ordInfo[0].payMoney = ordInfo[0].payMoney.map(Number)
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
    if (!checkRoot(ctx, true)) { return false }
    
    const data = ctx.request.body.data
    const ordInfo = data.ordInfo
    let goodsMap = {}
    if (ordInfo.vip && ordInfo.payMethod == 5) {
      const vipInfo = await query(`SELECT * FROM vip WHERE phone = ? AND off != 1`, [ordInfo.vip])
      await query(`UPDATE vip SET balance = ?, status = ? WHERE phone = ? AND off != 1`, [Number(vipInfo[0].balance) - Number(ordInfo.totalPrice) - Number(ordInfo.discount || 0), 0, ordInfo.vip])
    }
    await query(`UPDATE roomorder SET close = 1, endTime = ? WHERE nun = ?`, [new Date().getTime(), ordInfo.nun])
    await query(`UPDATE room SET status = 0 WHERE no = ?`, [ordInfo.room])
    
    // 寄存商品使用
    const stockGoods = ordInfo.stockGoods || []
    for (let i = 0, len = stockGoods.length; i < len; i++) {
      const goods = stockGoods[i].goods
      const depositQty = stockGoods[i].depositQty
      const qty = stockGoods[i].qty
      const diffQty = Number(qty) - Number(depositQty)
      if (diffQty == 0) {
        await query(`DELETE FROM vipstock WHERE VIP = ? AND goods = ? AND off != 1`, [ordInfo.vip, goods])
      } else {
        await query(`UPDATE vipstock SET qty = ? WHERE VIP = ? AND goods = ? AND off != 1`, [diffQty, ordInfo.vip, goods])
      }
      if (goodsMap[goods]) {
        goodsMap[goods].qty += Number(depositQty)
      } else {
        goodsMap[goods] = {qty: Number(depositQty)}
      }
    }

    // 寄存商品
    const result = await query(`SELECT * FROM vipstock WHERE nun = ? AND vip = ? AND off != 1`, [ordInfo.nun, ordInfo.vip])
    for (let i = 0, len = result.length; i < len; i++) {
      const item = result[i]
      if (goodsMap[item.goods]) {
        goodsMap[item.goods].qty -= Number(item.qty)
      } else {
        goodsMap[item.goods] = {qty: -Number(item.qty)}
      }
      const exist = await query(`SELECT * FROM vipstock WHERE nun = '' AND vip = ? AND goods = ? AND off != 1`, [ordInfo.vip, item.goods])
      if (exist.length !== 0) {
        await query(`UPDATE vipstock SET qty = ? WHERE nun = '' AND vip = ? AND goods = ? AND off != 1`, [Number(exist[0].qty) + Number(item.qty), ordInfo.vip, item.goods])
        await query(`DELETE FROM vipstock WHERE nun = ? AND vip = ? AND goods = ? AND off != 1`, [ordInfo.nun, ordInfo.vip, item.goods])
      } else {
        await query(`UPDATE vipstock SET nun = '' WHERE nun = ? AND vip = ? AND goods = ? AND off != 1`, [ordInfo.nun, ordInfo.vip, item.goods])
      }
    }

    // 商品消耗
    const selectedGoods = ordInfo.goods || {}
    for (let key in selectedGoods) {
      if (goodsMap[key]) {
        goodsMap[key].qty += Number(selectedGoods[key].qty)
      } else {
        goodsMap[key] = {qty: Number(selectedGoods[key].qty)}
      }
    }

    const packageGoods = ordInfo.package.goods || []
    let grp = (ordInfo.package.grp || '').split(',')
    const grpSelected = (ordInfo.package.grpSelected || '') + ''
    grp.splice(grp.indexOf(grpSelected), 1)
    packageGoods.forEach(ele => {
      let goods = ele.goods + ''
      if (grp.indexOf(goods) === -1) {
        if (goodsMap[goods]) {
          goodsMap[goods].qty += Number(ele.qty)
        } else {
          goodsMap[goods] = {qty: Number(ele.qty)}
        }
      }
    })

    for (let key in goodsMap) {
      let result = await query(`SELECT * FROM goods WHERE id = ? AND off != 1`, [key])
      if (result.length !== 0) {
        await query(`UPDATE goods SET qty = ? WHERE id = ? AND off != 1`, [result[0].qty - goodsMap[key].qty, key])
      }
    }

    ctx.body = {code: 200, message: '结账成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/cancelOrder', async (ctx) => {
  try {
    if (!checkRoot(ctx, true)) { return false }
    
    const data = ctx.request.body.data
    const ordInfo = data.ordInfo
    await query(`DELETE FROM roomorder WHERE nun = ?`, [ordInfo.nun])
    await query(`UPDATE room SET status = 0 WHERE no = ?`, [ordInfo.room])
    if (ordInfo.vip) {
      await query(`UPDATE vip SET status = ? WHERE phone = ? AND off != 1`, [0, ordInfo.vip])
    }
    ctx.body = {code: 200, message: '结账成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deleteOrder', async (ctx) => {
  try {
    if (!checkRoot(ctx, true)) { return false }
    
    const data = ctx.request.body.data
    const ordInfo = data[0]
    let goodsMap = {}

    const payMethod = ordInfo.payMethod
     // 返回余额
    if (payMethod == 5) {
      const vipInfo = await query(`SELECT * FROM vip WHERE phone = ? AND off != 1`, [ordInfo.vip])
      if (vipInfo.length !== 0) {
        await query(`UPDATE vip SET balance = ? WHERE phone = ?`, [Number(vipInfo.balance) + Number(ordInfo.totalPrice) - Number(ordInfo.discount || 0)])
      }
    }
    // 寄存商品扣减
    if (ordInfo.depositGoods && ordInfo.depositGoods != '') {
      const depositGoods = (ordInfo.depositGoods || '').split(',')
      const depositQty = (ordInfo.depositQty || '').split(',')
      for (let i = 0, len = depositGoods.length; i < len; i++) {
        if (goodsMap[depositGoods[i]]) {
          goodsMap[depositGoods[i]].qty -= Number(depositQty[i])
        } else {
          goodsMap[depositGoods[i]] = {qty: -Number(depositQty[i])}
        }
        let exist = await query(`SELECT * FROM vipstock WHERE vip = ? AND goods = ? AND off != 1`, [ordInfo.vip, depositGoods[i]])
        let qty = Number(exist[0].qty) - Number(depositQty[i])
        if (qty <= 0) {
          await query(`DELETE FROM vipstock WHERE vip = ? AND goods = ? AND off != 1`, [ordInfo.vip, depositGoods[i]])
        } else {
          await query(`UPDATE vipstock SET qty = ? WHERE vip = ? AND goods = ? AND off != 1`, [qty, ordInfo.vip, depositGoods[i]])
        }
      }
    }
    
    // 寄存使用商品返回
    if (ordInfo.stockGoods && ordInfo.stockGoods != '') {
      const stockGoods = (ordInfo.stockGoods || '').split(',')
      const stockQty = (ordInfo.stockQty || '').split(',')
      for (let i = 0, len = stockGoods.length; i < len; i++) {
        if (goodsMap[stockGoods[i]]) {
          goodsMap[stockGoods[i]].qty += Number(stockQty[i])
        } else {
          goodsMap[stockGoods[i]] = {qty: Number(stockQty[i])}
        }
        let exist = await query(`SELECT * FROM vipstock WHERE vip = ? AND goods = ? AND off != 1`, [ordInfo.vip, stockGoods[i]])
        if (exist.length === 0) {
          await query(`INSERT INTO vipstock (nun, vip, goods, qty) VALUES (?, ?, ?, ?)`, ['', ordInfo.vip, stockGoods[i], stockQty[i]])
        } else {
          await query(`UPDATE vipstock SET qty = ? WHERE vip = ? AND goods = ? AND off != 1`, [Number(exist[0].qty) + Number(stockQty[i]), ordInfo.vip, stockGoods[i]])
        }
      }
    }

    // 商品库存
    const selectedGoods = ordInfo.goods || {}
    for (let key in selectedGoods) {
      if (goodsMap[key]) {
        goodsMap[key].qty += Number(selectedGoods[key].qty)
      } else {
        goodsMap[key] = {qty: Number(selectedGoods[key].qty)}
      }
    }

    const packageGoods = ordInfo.package.goods || []
    let grp = (ordInfo.package.grp || '').split(',')
    const grpSelected = (ordInfo.package.grpSelected || '') + ''
    grp.splice(grp.indexOf(grpSelected), 1)
    packageGoods.forEach(ele => {
      let goods = ele.goods + ''
      if (grp.indexOf(goods) === -1) {
        if (goodsMap[goods]) {
          goodsMap[goods].qty += Number(ele.qty)
        } else {
          goodsMap[goods] = {qty: Number(ele.qty)}
        }
      }
    })

    for (let key in goodsMap) {
      let result = await query(`SELECT * FROM goods WHERE id = ? AND off != 1`, [key])
      if (result.length !== 0) {
        await query(`UPDATE goods SET qty = ? WHERE id = ? AND off != 1`, [result[0].qty + goodsMap[key].qty, key])
      }
    }

    await query(`UPDATE roomorder SET off = 1 WHERE nun = ?`, [ordInfo.nun])

    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/updOrder', async (ctx) => {
  try {
    if (!checkRoot(ctx, true)) { return false }
    
    const data = ctx.request.body.data
    const ordInfo = data.ordInfo || {}
    const packageId = ordInfo.package && ordInfo.package.package || ''
    const packageType = ordInfo.package && ordInfo.package.type || ''
    const grpSelected = ordInfo.package && ordInfo.package.grpSelected || ''
    const goodsMap = ordInfo.goods || {}
    const stockGoods = ordInfo.stockGoods || []
    const depositGoods = ordInfo.depositGoods || []
    const payMethod = ordInfo.payMethod
    const payMoney = payMethod === 6 ? ordInfo.payMoney.join(',') : ''
    let goodsList = [], qtyList = []
    let stockGoodsList = [], stockQtyList = []
    let depositGoodsList = [], depositQtyList = []
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
    depositGoods.forEach(ele => {
      if (ele.depositQty != 0) {
        depositGoodsList.push(ele.goods)
        depositQtyList.push(ele.depositQty)
      }
    })

    await query(`UPDATE roomorder SET package = ?, packageType = ?, grpSelected = ?, goods = ?, qty = ?, stockGoods = ?, stockQty = ?, depositGoods = ?, depositQty = ?, 
      vip = ?, totalPrice = ?, discount = ?, payMethod = ?, payMoney = ? WHERE room = ? AND close != 1 AND off != 1`, 
      [packageId, packageType, grpSelected, goodsList.join(','), qtyList.join(','), stockGoodsList.join(','), stockQtyList.join(','), depositGoodsList.join(','), depositQtyList.join(','),
      ordInfo.vip, ordInfo.totalPrice, ordInfo.discount, payMethod, payMoney, ordInfo.room]
    )
    ctx.body = {code: 200, message: '更新成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getOrderHistory', async (ctx) => {
  try {
    if (!checkRoot(ctx, true)) { return false }

    const data = ctx.request.body.data
    const pageNo = data.pageNo || 1
    const pageSize = data.pageSize || 20
    let ordInfo
    if (data.type === 'report') {
      ordInfo = await query(`SELECT * FROM roomorder WHERE close = 1 AND off != 1 ORDER BY startTime DESC`)
    } else {
      ordInfo = await query(`SELECT * FROM roomorder WHERE close = 1 AND off != 1 ORDER BY createTime DESC LIMIT ?, ?`, [(pageNo - 1) * pageSize, pageSize])
    }

    let count = await query(`SELECT COUNT(*) as count FROM roomorder WHERE close = 1 AND off != 1`)
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

      const stockGoodsList = item.stockGoods ? item.stockGoods.split(',') : []
      const stockQtyList = item.stockQty ? item.stockQty.split(',') : []
      let stockGoods = []
      for (let i = 0, len = stockGoodsList.length; i < len; i++) {
        let result = await query(`SELECT g.id as goods, g.name as goodsm,
          u.id as unit, u.name as unitm FROM goods g, unit u WHERE u.id = g.unit AND g.id = ?`, [stockGoodsList[i]])
        result[0].stockQty = stockQtyList[i]
        stockGoods.push(result[0])
      }
      item.stockGoods = stockGoods

      const depositGoodsList = item.depositGoods ? item.depositGoods.split(',') : []
      const depositQtyList = item.depositQty ? item.depositQty.split(',') : []
      let depositGoods = []
      for (let i = 0, len = depositGoodsList.length; i < len; i++) {
        let result = await query(`SELECT g.id as goods, g.name as goodsm,
          u.id as unit, u.name as unitm FROM goods g, unit u WHERE u.id = g.unit AND g.id = ?`, [depositGoodsList[i]])
        result[0].depositQty = depositQtyList[i]
        depositGoods.push(result[0])
      }
      item.depositGoods = depositGoods

      item.payMoney = item.payMoney ? item.payMoney.split(',') : []
      item.payMoney = item.payMoney.map(Number)
      item.no = item.room
      delete item.packageType
      delete item.grpSelected
      delete item.qty
      delete item.stockQty
      delete item.depositQty
      result.push(item)
    }

    let message
    if (data.type === 'report') {
      message = {}
      message.orderList = result
      message.goodsList = await query(`SELECT g.id, g.name, g.picture, g.price, g.descr, 
        u.id as unit, u.name as unitm FROM goods g, unit u WHERE u.id = g.unit AND g.off != 1 ORDER BY g.createTime ASC`)
      message.packageList = await query(`SELECT DISTINCT uuid as uuid, name FROM package WHERE off != 1 ORDER BY createTime ASC`)
    } else {
      message = result
    }
    ctx.body = {code: 200, message: message, count: count.length === 0 ? 0 : count[0].count}
  } catch(err) {
    throw new Error(err)
  }
})

router.get('/handleData', async (ctx) => {
  try {
    const orderList = await query(`SELECT * FROM roomorder`)
    // 1: {icon: 'icon-big-Pay', title: '支付宝支付'},
    // 2: {icon: 'icon-weixinzhifu', title: '微信支付'},
    // 3: {icon: 'icon-cash_payment', title: '现金支付'},
    // 4: {icon: 'icon-zhifupingtai-yinlian', title: '刷卡支付'},
    // 5: {icon: 'icon-available', title: '余额支付'},
    // 6: {icon: 'icon-zuhe-pay', title: '组合支付', group: ''}

    // 1: {icon: 'icon-big-Pay', title: '支付宝支付'},
    // 2: {icon: 'icon-weixinzhifu', title: '微信支付'},
    // 3: {icon: 'icon-zhifupingtai-yinlian', title: '刷卡支付'},
    // 4: {icon: 'icon-cash_payment', title: '现金支付'},
    // 5: {icon: 'icon-available', title: '余额支付'}
    const keyMap = {
      1: 1,
      2: 2,
      3: 4,
      4: 3,
      5: 5,
      6: 6
    }
    for (let i = 0, len = orderList.length; i < len; i++) {
      let item = orderList[i]
      item.payMethod = keyMap[item.payMethod]
      await query(`UPDATE roomorder SET payMethod = ? WHERE nun = ?`, [item.payMethod, item.nun])
    }
    ctx.body = '数据处理。。。'
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router