const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')
const uuidv1 = require('uuid/v1')

router.post('/insertPackage', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }

    const data = ctx.request.body.data
    for (let i = 0 , len = data.length; i < len; i++) {
      const item = data[i]
      const createTime = new Date().getTime()
      const type1 = item.type.indexOf('1') === -1 ? 0 : 1
      const price1 = item.price1
      const type2 = item.type.indexOf('2') === -1 ? 0 : 1
      const price2 = item.price2
      const uuid = uuidv1()
      const goods = item.goods

      if (goods.length === 0) {
        await query(`INSERT INTO package (uuid, name, type1, type2, price1, price2, descr, createTime) VALUES
        (?, ?, ?, ?, ?, ?, ?, ?)`, 
        [uuid, item.name, type1, type2, price1, price2, item.descr, createTime])
      } else {
        for (let i = 0, len = goods.length; i < len; i++) {
          const qty = item.goodsQty[goods[i]]
          await query(`INSERT INTO package (uuid, name, goods, qty, grp, type1, type2, price1, price2, descr, createTime) VALUES
            (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`, 
            [uuid, item.name, goods[i], qty, item.group.join(','), type1, type2, price1, price2, item.descr, createTime])
        }
      }
    }
    ctx.body = {code: 200, message: '新增成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getPackage', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const count = await query(`SELECT COUNT(DISTINCT uuid) as count FROM package WHERE off != 1`)
    const result = await query(`SELECT DISTINCT uuid as uuid, p.createTime, p.name, p.type1, p.price1, p.type2, p.price2, p.descr, p.grp, p.qty, g.id as goods, g.name as goodsm, u.name as unitm 
      FROM package as p 
      LEFT JOIN goods as g on p.goods = g.id 
      LEFT JOIN unit as u on g.unit = u.id 
      WHERE p.off != 1
      ORDER BY p.createTime ASC`)
    let packageList = []
    let uuidMap = {}
    result.forEach(ele => {
      if (uuidMap[ele.uuid] === undefined) {
        ele.goods = ele.goods != null && ele.goods != '' ? [{id: ele.goods, name: ele.goodsm, unitm: ele.unitm, qty: ele.qty}] : []
        delete ele.qty
        delete ele.goodsm
        delete ele.unitm
        packageList.push(ele)
        uuidMap[ele.uuid] = packageList.length - 1
      } else {
        if (ele.goods != null && ele.goods != '') {
          packageList[uuidMap[ele.uuid]].goods.push({id: ele.goods, name: ele.goodsm, unitm: ele.unitm, qty: ele.qty})
        }
      }
    })
    ctx.body = {code: 200, message: packageList, count: count[0].count}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deletePackage', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }
    
    const data = ctx.request.body.data
    const uuid = data[0].uuid

    let roomorder = await query(`SELECT * FROM roomorder WHERE package = ? AND off != 1`, [uuid])
    if (roomorder.length !== 0) {
      ctx.body = {code: 500, message: '已开单包间中存在该套餐，暂时无法删除！'}
      return
    }

    await query(`DELETE FROM package WHERE uuid = ?`, [uuid])
    await query(`DELETE FROM room WHERE package = ?`, [uuid])
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/updPackage', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }
    
    const data = ctx.request.body.data
    const uuid = data.uuid
    await query(`DELETE FROM package WHERE uuid = '${uuid}'`)

    const item = data
    const createTime = item.createTime
    const updateTime = new Date().getTime()
    const type1 = item.type.indexOf('1') === -1 ? 0 : 1
    const price1 = item.price1
    const type2 = item.type.indexOf('2') === -1 ? 0 : 1
    const price2 = item.price2
    const goods = item.goods
    if (goods.length === 0) {
      await query(`INSERT INTO package (uuid, name, type1, type2, price1, price2, descr, createTime, updateTime) VALUES
      (?, ?, ?, ?, ?, ?, ?, ?, ?)`, 
      [uuid, item.name, type1, type2, price1, price2, item.descr, createTime, updateTime])
    } else {
      for (let i = 0, len = goods.length; i < len; i++) {
        const qty = item.goodsQty[goods[i]]
        await query(`INSERT INTO package (uuid, name, goods, qty, grp, type1, type2, price1, price2, descr, createTime, updateTime) VALUES
          (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`, 
          [uuid, item.name, goods[i], qty, item.group.join(','), type1, type2, price1, price2, item.descr, createTime, updateTime])
      }
    }
    ctx.body = {code: 200, message: '更新成功'}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router