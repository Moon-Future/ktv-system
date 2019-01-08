const Router = require('koa-router')
const router = new Router()
const query = require('../database/init')
const sendMessage = require('./sendMessage')
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
    const login = data.login
    if (!login) {
      const result = await query(`SELECT * FROM vip WHERE phone = ?`, [phone])
      if (result.length !== 0) {
        ctx.body = {code: 500, message: `手机号 ${phone} 已注册`}
        return
      }
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
    const sendResult = await sendMessage(phone, verifyCode)
    if (sendResult.code == 0) {
      ctx.body = {code: 200, message: '发送成功'}
    } else {
      ctx.body = {code: 500, message: sendResult.message}
    }
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
    await query(`INSERT INTO vip (phone, createTime) VALUES ( ?, ? )`, [phone, createTime])
    ctx.body = {code: 200, message: '注册成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/loginVip', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const phone = data.phone
    const verifyCode = data.verifyCode
    const createTime = new Date().getTime()
    if (!verifyCodeMap[phone] || verifyCodeMap[phone].verifyCode !== verifyCode) {
      ctx.body = {code: 500, message: '验证码错误'}
      return
    }
    let result = await query(`SELECT * FROM vip WHERE phone = ? AND off != 1`, [phone])
    if (result.length === 0) {
      await query(`INSERT INTO vip (phone, status, createTime) VALUES ( ?, ?, ? )`, [phone, 1, createTime])
      result = await query(`SELECT * FROM vip WHERE phone = ? AND off != 1`, [phone])
    } else {
      if (result[0].status == '1') {
        clearTimeout(verifyCodeMap[phone].intervalTime)
        delete verifyCodeMap[phone]
        ctx.body = {code: 500, message: '已登陆，请先注销'}
        return 
      }
    }
    await query(`UPDATE vip SET status = ? WHERE phone = ? AND off != 1`, [1, phone])
    clearTimeout(verifyCodeMap[phone].intervalTime)
    delete verifyCodeMap[phone]
    ctx.body = {code: 200, message: result}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/logoutVip', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const phone = data.phone
    await query(`UPDATE vip SET status = ? WHERE phone = ? AND off != 1`, [0, phone])
    ctx.body = {code: 200}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getVip', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const phone = data.phone
    let result = []
    let temp
    let count
    if (phone == undefined || phone == '') {
      const countResult = await query(`SELECT COUNT(*) as count FROM vip WHERE off != 1`)
      count = countResult[0].count
      temp = await query(`SELECT v.phone, v.balance, v.createTime, v.record, o.totalPrice, o.discount, o.createTime as consumeTime
        FROM vip as v 
        LEFT JOIN roomorder as o on o.vip = v.phone
        WHERE v.off != 1
        ORDER BY v.createTime ASC`)
    } else {
      temp = await query(`SELECT v.phone, v.balance, v.createTime, v.record, o.totalPrice, o.discount, o.createTime as consumeTime
        FROM vip as v 
        LEFT JOIN roomorder as o on o.vip = ?
        WHERE v.phone = ? AND v.off != 1
        ORDER BY v.createTime ASC`, [phone, phone])
      count = 1
    }
    let phoneMap = {}
    temp.forEach(ele => {
      if (phoneMap[ele.phone] == undefined) {
        phoneMap[ele.phone] = []
      }
      phoneMap[ele.phone].push(ele)
    });
    for (let key in phoneMap) {
      const phoneList = phoneMap[key]
      let recentConsumeTime = ''
      let recentConsumeMoney = 0
      let totalTime = 0
      let totalMoney = 0
      if (phoneList.length === 1 && !phoneList[0].totalPrice) {
        totalTime = 0
      } else {
        totalTime = phoneList.length
      }
      phoneList.sort((a, b) => {
        return b.consumeTime - a.consumeTime
      })
      recentConsumeTime = phoneList[0].consumeTime || ''
      recentConsumeMoney = Number(phoneList[0].totalPrice) - Number(phoneList[0].discount)
      phoneList.forEach(ele => {
        totalMoney += Number(ele.totalPrice) - Number(ele.discount)
      })
      let obj = phoneList[0]
      obj.recentConsumeTime = recentConsumeTime
      obj.recentConsumeMoney = recentConsumeMoney
      obj.totalTime = totalTime
      obj.totalMoney = totalMoney
      delete obj.consumeTime
      delete obj.discount
      delete obj.totalPrice
      result.push(obj)
    }
    result.sort((a, b) => {
      return a.createTime - b.createTime
    })
    ctx.body = {code: 200, message: result, count: count}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/recharge', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const phone = data.phone
    const rechargeMoney = data.rechargeMoney
    const giveMoney = data.giveMoney || 0
    const result = await query(`SELECT * FROM vip WHERE phone = '${phone}' AND off != 1`)
    if (result.length === 0) {
      ctx.body = {code: 500, message: '账户不存在'}
      return 
    }
    await query(`UPDATE vip SET balance = ?,
        record = ?
        WHERE phone = ? AND off != 1;
        INSERT into rechargerecord (phone, money, recharge, give, user, time) VALUES (?, ?, ?, ?, ?, ?)
      `, [
        Number(result[0].balance) + Number(rechargeMoney) + Number(giveMoney), Number(result[0].record + 1), phone,
        phone, Number(rechargeMoney) + Number(giveMoney), rechargeMoney, giveMoney, ctx.session.userInfo.name, new Date().getTime()
      ]
    )
    ctx.body = {code: 200, message: '充值成功'}
  } catch(err) {
    throw new Error(err)
  }
})

router.post('/getRechargeRecord', async (ctx) => {
  try {
    const data = ctx.request.body.data
    const phone = data.phone
    const result = await query(`SELECT * FROM rechargerecord WHERE phone = '${phone}' AND off != 1 ORDER BY time ASC`)
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