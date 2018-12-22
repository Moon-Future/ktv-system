const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')
const uuidv1 = require('uuid/v1')

router.post('/insertPackage', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }

    const data = ctx.request.body.data
    for (let i = 0 , len = data.length; i < len; i++) {
      const item = data[i]
      const currentTime = new Date().getTime()
      const goodsArray = item.goods
      const qtyMap = item.goodsQty
      const uuid = uuidv1()
      if (goodsArray.length === 0) {
        await query(`INSERT INTO package (uuid, type, name, room, roomType, price, descr, createTime) VALUES
          ('${uuid}', ${item.type}, '${item.name}', ${item.room ? 1 : 0}, ${item.room ? item.roomType : null}, ${item.price}, '${item.descr}', ${currentTime})`)
      } else {
        for (let j = 0; j < goodsArray.length; j++) {
          const goods = goodsArray[j]
          const qty = qtyMap[goods]
          await query(`INSERT INTO package (uuid, type, name, goods, qty, room, roomType, price, descr, createTime) VALUES
            ('${uuid}', ${item.type}, '${item.name}', ${goods}, ${qty}, ${item.room ? 1 : 0}, ${item.room ? item.roomType : null}, ${item.price}, '${item.descr}', ${currentTime})`)
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
    const result = await query(`SELECT DISTINCT uuid as uuid, p.createTime, p.type, p.name, p.room, p.roomType, r.name as roomTypem, p.price, p.descr, p.qty, g.id as goods, g.name as goodsm, u.name as unitm 
      FROM package as p 
      LEFT JOIN roomtype as r on p.roomType = r.id 
      LEFT JOIN goods as g on p.goods = g.id 
      LEFT JOIN unit as u on g.unit = u.id 
      WHERE p.off != 1
      ORDER BY p.createTime ASC`)
    let packageList = []
    let uuidMap = {}
    result.forEach(ele => {
      if (uuidMap[ele.uuid] === undefined) {
        ele.goods = [{id: ele.goods, name: ele.goodsm, unitm: ele.unitm, qty: ele.qty}]
        packageList.push(ele)
        uuidMap[ele.uuid] = packageList.length - 1
      } else {
        packageList[uuidMap[ele.uuid]].goods.push({id: ele.goods, name: ele.goodsm, unitm: ele.unitm, qty: ele.qty})
      }
    })
    ctx.body = {code: 200, message: packageList, count: count[0].count}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deletePackage', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const uuid = data[0].uuid
    await query(`DELETE FROM package WHERE uuid = '${uuid}'`)
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/updPackage', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const uuid = data.uuid
    await query(`DELETE FROM package WHERE uuid = '${uuid}'`)

    const item = data
    const createTime = item.createTime
    const updateTime = new Date().getTime()
    const goodsArray = item.goods
    const qtyMap = item.goodsQty
    if (goodsArray.length === 0) {
      await query(`INSERT INTO package (uuid, type, name, room, roomType, price, descr, createTime, updateTime) VALUES
        ('${uuid}', ${item.type}, '${item.name}', ${item.room ? 1 : 0}, ${item.room ? item.roomType : null}, ${item.price}, '${item.descr}', ${createTime}, ${updateTime})`)
    } else {
      for (let j = 0; j < goodsArray.length; j++) {
        const goods = goodsArray[j]
        const qty = qtyMap[goods]
        await query(`INSERT INTO package (uuid, type, name, goods, qty, room, roomType, price, descr, createTime, updateTime) VALUES
          ('${uuid}', ${item.type}, '${item.name}', ${goods}, ${qty}, ${item.room ? 1 : 0}, ${item.room ? item.roomType : null}, ${item.price}, '${item.descr}', ${createTime}, ${updateTime})`)
      }
    }
    ctx.body = {code: 200, message: '更新成功'}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router