const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')
const uuidv1 = require('uuid/v1')

router.post('/insertRoomType', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }

    const data = ctx.request.body.data
    let result = []
    for (let i = 0 , len = data.length; i < len; i++) {
      const item = data[i]
      const currentTime = new Date().getTime()
      const roomtype = await query(`SELECT * FROM roomtype WHERE name = ? AND off != 1`, [item.name])
      if (roomtype.length !== 0) {
        result.push(item.name)
        continue
      }
      await query(`INSERT INTO roomtype (name, createTime) VALUES (?, ?)`, [item.name, currentTime])
    }
    if (result.length === 0) {
      ctx.body = {code: 200, message: '新增成功'}
    } else {
      ctx.body = {code: 200, message: `房间类型 ${result.join(', ')} 已存在`, repeat: true}
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
    const roomTypeList = await query(`SELECT * FROM roomtype WHERE off != 1 ORDER BY createTime ASC`)
    ctx.body = {code: 200, message: roomTypeList, count: count[0].count}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deleteRoomType', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }
    
    const data = ctx.request.body.data
    let ids = []
    data.forEach(ele => {
      ids.push(ele.id)
    })
    await query(`UPDATE roomtype SET off = 1, updateTime = ? WHERE id IN ( ? )`, [new Date().getTime(), ids.join()])
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/updRoomType', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }
    
    const data = ctx.request.body.data
    const check = await query(`SELECT * FROM roomtype WHERE name = ? AND off != 1`, [data.name])
    if (check.length !== 0 && check[0].id != data.id) {
      ctx.body = {code: 500, message: `房间类型 ${data.name} 已存在`}
      return
    }
    await query(`UPDATE roomtype SET name = ?, updateTime = ? WHERE id = ?`, [data.name, new Date().getTime(), data.id])
    const result = await query(`SELECT * FROM roomtype WHERE off != 1 AND id = ?`, [data.id])
    ctx.body = {code: 200, message: '更新成功', result: result}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/insertRoomInfo', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }

    const data = ctx.request.body.data
    let result = []
    for (let i = 0 , len = data.length; i < len; i++) {
      const item = data[i]
      const currentTime = new Date().getTime()
      const package = item.package.length === 0 ? [''] : item.package
      const position = item.position || ''
      const uuid = uuidv1()
      let roomInfo
      if (position == '') {
        roomInfo = await query(`SELECT * FROM room WHERE no = ? AND off != 1`, [item.no])
      } else {
        roomInfo = await query(`SELECT * FROM room WHERE no = ? or position = ? AND off != 1`, [item.no, position])
      }
      if (roomInfo.length !== 0) {
        result.push(item.no)
        continue
      }

      for (let j = 0; j < package.length; j++) {
        await query(`INSERT INTO room (uuid, roomType, name, no, package, descr, position, createTime) VALUES 
          (?, ?, ?, ?, ?, ?, ?, ?)`,
          [uuid, item.roomType, item.name, item.no, package[j], item.descr, position, currentTime]
        )
      }
    }
    if (result.length === 0) {
      ctx.body = {code: 200, message: '新增成功'}
    } else {
      ctx.body = {code: 500, message: '房间编号或位置已存在', repeat: true}
    }
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getRoomInfo', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const count = await query(`SELECT COUNT(DISTINCT uuid) as count FROM room WHERE off != 1`)
    const result = await query(`SELECT DISTINCT r.uuid as uuid, r.createTime, r.name, r.no, r.roomType, r.descr, r.package, r.status, r.position,
      t.name as roomTypem, p.name as packagem, p.type1, p.type2, p.price1, p.price2, p.descr as descrPackage, p.qty, p.grp,
      p.goods, g.name as goodsm, u.name as unitm
      FROM room as r 
      LEFT JOIN roomtype as t on r.roomType = t.id 
      LEFT JOIN package as p on r.package = p.uuid
      LEFT JOIN goods as g on p.goods = g.id
      LEFT JOIN unit as u on g.unit = u.id
      WHERE r.off != 1
      ORDER BY r.createTime ASC`)
    let roomInfoList = []
    let packageGoodsMap = {}
    let roomPackageMap = {}
    let uuidMap = {}
    result.forEach(ele => {
      if (ele.package) {
        packageGoodsMap[ele.uuid + '_' + ele.package] = packageGoodsMap[ele.uuid + '_' + ele.package] || []
        if (ele.goods) {
          packageGoodsMap[ele.uuid + '_' + ele.package].push({goods: ele.goods, goodsm: ele.goodsm, qty: ele.qty, unitm: ele.unitm})
        }
      }
    })
    result.forEach(ele => {
      if (roomPackageMap[ele.uuid] === undefined) {
        roomPackageMap[ele.uuid] = {key: [ele.package], value: []}
        if (ele.package) {
          roomPackageMap[ele.uuid].value.push({package: ele.package, packagem: ele.packagem, grp: ele.grp, type1: ele.type1, type2: ele.type2, price1: ele.price1, price2: ele.price2, descr: ele.descrPackage, goods: packageGoodsMap[ele.uuid + '_' + ele.package]});
        }
      } else {
        if (roomPackageMap[ele.uuid].key.indexOf(ele.package) === -1) {
          roomPackageMap[ele.uuid].key.push(ele.package)
          if (ele.package) {
            roomPackageMap[ele.uuid].value.push({package: ele.package, packagem: ele.packagem, grp: ele.grp, type1: ele.type1, type2: ele.type2, price1: ele.price1, price2: ele.price2, descr: ele.descrPackage, goods: packageGoodsMap[ele.uuid + '_' + ele.package]});
          }
        }
      }
    })
    result.forEach(ele => {
      if (uuidMap[ele.uuid] === undefined) {
        ele.package = roomPackageMap[ele.uuid].value
        delete ele.packagem
        delete ele.goods
        delete ele.goodsm
        delete ele.descrPackage
        delete ele.qty
        delete ele.unitm
        delete ele.price1
        delete ele.price2
        delete ele.type1
        delete ele.type2
        delete ele.grp
        roomInfoList.push(ele)
        uuidMap[ele.uuid] = true
      }
    })
    ctx.body = {code: 200, message: roomInfoList, count: count[0].count}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/deleteRoomInfo', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }
    
    const data = ctx.request.body.data
    let uuids = []
    data.forEach(ele => {
      uuids.push(ele.uuid)
    })
    await query(`DELETE FROM room WHERE uuid IN ( ? )`, [uuids.join()])
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/updRoomInfo', async (ctx) => {
  try {
    if (!checkRoot(ctx)) { return false }
    
    const data = ctx.request.body.data
    const currentTime = new Date().getTime()
    const position = data.position || ''
    let roomInfo
    if (position == '') {
      roomInfo = await query(`SELECT * FROM room WHERE no = ? AND off != 1`, [data.no])
    } else {
      roomInfo = await query(`SELECT * FROM room WHERE no = ? or position = ? AND off != 1`, [data.no, position])
    }
    for (let i = 0, len = roomInfo.length; i < len; i++) {
      if (roomInfo[i].uuid != data.uuid) {
        ctx.body = {code: 500, message: '房间编号或位置已存在'}
        return
      }
    }
    const package = data.package.length === 0 ? [''] : data.package
    await query(`DELETE FROM room WHERE uuid = '${data.uuid}'`)
    for (let i = 0; i < package.length; i++) {
      await query(`INSERT INTO room (uuid, roomType, name, no, package, descr, position, createTime, updateTime) VALUES 
        (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [data.uuid, data.roomType, data.name, data.no, package[i], data.descr, position, data.createTime, currentTime]
      )
    }
    ctx.body = {code: 200, message: '更新成功'}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router