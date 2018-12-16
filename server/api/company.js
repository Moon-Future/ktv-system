const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const checkRoot = require('./root')

router.post('/insertCompany', async (ctx) => {
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
      const company = await query(`SELECT * FROM company WHERE name = '${item.name}' AND off != 1`)
      if (company.length !== 0) {
        result.push(item.name)
        continue
      }
      await query(`INSERT INTO company (name, alias, createTime, template) VALUES ('${item.name}', '${item.alias}', ${currentTime}, ${item.template})`)
    }
    if (result.length === 0) {
      ctx.body = {code: 200, message: '新增成功'}
    } else {
      ctx.body = {code: 200, message: `公司 ${result.join(', ')} 已存在`, repeat: true}
    }
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/getCompany', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx, true)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }

    const data = ctx.request.body.data
    const pageNo = data && data.pageNo || 1
    const pageSize = data && data.pageSize || 10
    let company
    if (data && data.type === 0) {
      company = await query(`SELECT * FROM company WHERE type = 0 AND off != 1 ORDER BY createTime ASC`)
      ctx.body = {code: 200, message: company}
    } else {
      const count = await query(`SELECT COUNT(*) as count FROM company WHERE off != 1`)
      company = await query(`SELECT * FROM company WHERE off != 1 ORDER BY createTime ASC LIMIT ${(pageNo - 1) * pageSize}, ${pageSize}`)
      ctx.body = {code: 200, message: company, count: count[0].count}
    }
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/deleteCompany', async (ctx) => {
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
    await query(`UPDATE company SET off = 1, updateTime = ${new Date().getTime()} WHERE id IN ( ${ids.join()} )`)
    ctx.body = {code: 200, message: '删除成功'}
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

router.post('/updCompany', async (ctx) => {
  try {
    const checkResult = checkRoot(ctx)
    if (checkResult.code === 500) {
      ctx.body = checkResult
      return
    }
    
    const data = ctx.request.body.data
    const check = await query(`SELECT * FROM company WHERE name = '${data.name}' AND off != 1`)
    if (check.length !== 0 && check[0].id != data.id) {
      ctx.body = {code: 500, message: `公司 ${data.name} 已存在`}
      return
    }
    const upd = await query(`UPDATE company SET name = '${data.name}', alias = '${data.alias}', updateTime = ${new Date().getTime()}, template = ${data.template} WHERE id = ${data.id}`)
    const result = await query(`SELECT * FROM company WHERE off != 1 AND id = ${data.id}`)
    ctx.body = {code: 200, message: '更新成功', result: result}
  } catch(err) {
    ctx.body = {code: 500, message: err}
  }
})

module.exports = router