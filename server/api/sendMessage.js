const axios = require('axios')
const { apikey } = require('../secret')

function sendMessage(phone, code) {
  return new Promise((resolve, reject) => {
    axios({
      url: 'https://sms.yunpian.com/v2/sms/single_send.json',
      method: 'post',
      params: {
        apikey,
        mobile: phone,
        text: `【亿民汇KTV】尊敬的会员，您的验证码：${code}，请于1分钟内填写，如非本人操作，请忽略本短信。`
      }
    }).then(res => {
      resolve(res.data)
    }).catch(err => {
      reject('发送失败')
    })
  })
}

module.exports = sendMessage