const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const { rootCode } = require('../secret.js')
let verifyCodeMap = {}

function createVerifyCode(count = 6) {
  let verifyCode = ''
  for (let i = 0; i < count; i++) {
    verifyCode += Math.floor(Math.random()*10)
  }
  return verifyCode
}

function clearVerifyCode(phone) {
  verifyCodeMap[phone] && clearTimeout(verifyCodeMap[phone].timeoutTime)
  verifyCodeMap.timeoutTime = setTimeout(() => {
    delete verifyCodeMap[phone]
  }, 500000)
}

function countVerifyCode(phone) {
  verifyCodeMap[phone].intervalTime = setInterval(function() {
    verifyCodeMap[phone].count += 1
    if (verifyCodeMap[phone].count >= 60) {
      clearTimeout(verifyCodeMap[phone].intervalTime)
    }
  }, 1000)
}

router.post('/sendVerifyCode', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const phone = data.phone
    const result = await query(`SELECT * FROM vip WHERE phone = '${phone}'`)
    if (result.length !== 0) {
      ctx.body = {code: 500, message: `手机号 ${phone} 已注册`}
      return
    }
    if (verifyCodeMap[phone] && verifyCodeMap[phone].count < 60) {
      ctx.body = {code: 500, message: '请稍后再发送'}
      return
    }
    const verifyCode = createVerifyCode()
    verifyCodeMap[phone] = {verifyCode}
    verifyCodeMap[phone].count = 0
    countVerifyCode(phone)
    clearVerifyCode(phone)
    console.log('verifyCode', verifyCode)
    ctx.body = {code: 200, message: '发送成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/registerVip', async (ctx) => {
  try {
    const data = ctx.request.body.data[0]
    const phone = data.phone
    const verifyCode = data.verifyCode
    const createTime = new Date().getTime()
    console.log(verifyCodeMap[phone].verifyCode, verifyCode)
    if (!verifyCodeMap[phone] || verifyCodeMap[phone].verifyCode !== verifyCode) {
      ctx.body = {code: 500, message: '验证码错误'}
      return
    }
    await query(`INSERT INTO vip (phone, createTime) VALUES ( '${phone}', '${createTime}' )`)
    ctx.body = {code: 200, message: '注册成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getVip', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const result = await query(`SELECT * FROM vip WHERE off != 1`)
    ctx.body = {code: 200, message: result}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/logout', async (ctx) => {
  try {
    ctx.session = null
    ctx.body = {code: 200, message: '已退出'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/recharge', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const phone = data.phone
    const rechargeMoney = data.rechargeMoney
    const result = await query(`SELECT * FROM vip WHERE phone = '${phone}' AND off != 1`)
    if (result.length === 0) {
      ctx.body = {code: 500, message: '账户不存在'}
      return 
    }
    await query(`UPDATE vip SET balance = ${Number(result[0].balance + Number(rechargeMoney))},
      record = ${Number(result[0].record + 1)}
      WHERE phone = '${phone}' AND off != 1;
      INSERT into rechargerecord (phone, money, time) VALUES ('${phone}', ${rechargeMoney}, ${new Date().getTime()})
    `)
    
    ctx.body = {code: 200, message: '充值成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getRechargeRecord', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const phone = data.phone
    const result = await query(`SELECT * FROM rechargerecord WHERE phone = '${phone}' AND off != 1`)
    ctx.body = {code: 200, message: result}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getSession', async (ctx) => {
  try {
    const userInfo = ctx.session.userInfo
    if (userInfo) {
      ctx.body = {code: 200, message: userInfo}
    } else {
      ctx.body = {code: 500, message: '请先登陆'}
    }
  } catch(err) {
    throw new Error(err)
  }
})

module.exports = router