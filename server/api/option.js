const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')

router.post('/getOptions', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }

    const data = ctx.request.body.data
    let result = {}
    if (data.unit) {
      const unitList = await query(`SELECT * FROM unit WHERE off != 1`)
      unitList.forEach(ele => {
        ele.value = ele.id + ''
        ele.label = ele.name
      });
      result.unitOptions = unitList
    }
    if (data.roomType) {
      const roomTypeList = await query(`SELECT * FROM roomtype WHERE off != 1`)
      roomTypeList.forEach(ele => {
        ele.value = ele.id + ''
        ele.label = ele.name
      });
      result.roomTypeOptions = roomTypeList
    }
    if (data.goods) {
      const goodsList = await query(`SELECT * FROM goods WHERE off != 1`)
      goodsList.forEach(ele => {
        ele.value = ele.id + ''
        ele.label = ele.name
      });
      result.goodsOptions = goodsList
    }
    ctx.body = {code: 200, message: result}
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router