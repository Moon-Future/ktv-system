const request = require('request')

const axios = require('axios')

function getRandom(start, end, size) {
  let allRandms = []
  size = size ? (size > end - start ? end - start : size) : 1
  for (let i = start; i <= end; i++) {
    allRandms.push(i)
  }
  allRandms.sort(() => {
    return 0.5 - Math.random()
  })
  return size == 1 ? allRandms[0] : allRandms.slice(0, size)
}

function dateFormat(date, format) {
  date = typeof date === 'number' ? new Date(date) : date
  let o = {
    'M+': date.getMonth() + 1,
    'd+': date.getDate(),
    'h+': date.getHours(),
    'm+': date.getMinutes(),
    's+': date.getSeconds()
  }
  if(/(y+)/i.test(format)){
    format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length))
  }
  for(let k in o){
    if(new RegExp('(' + k + ')').test(format)){
      format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length))
    }
  }
  return format
}

function ajax(url, flag = false) {
  return new Promise((resolve, reject) => {
    request(url, (err, res, body) => {
      if (err) {
        throw new Error(err)
      }
      try {
        console.log(body)
        body = flag ? body : JSON.parse(body)
        resolve(body)
      } catch(e) {
        reject({code: 500})
      }
    })
  })
}

/**
 * Created by lanouhn on 18/1/15.
 */
// var qs = require("querystring");
// var sha1 = require("sha1");
// var Appkey = "5e1b6580692f39d409384078fb0d176f";
// var Appsecret = "4d2dfa5b6f44";
// var Nonce = "ktv";
// var time = new Date();
// var CurTime = time.getTime();
// var CheckSum = sha1(Appsecret + Nonce + CurTime);
// var account;
// var post_data = {
//     templateid: 3902159,
//     mobile: '15920055057',
//     codeLen: '223567'
// };
// //这是需要提交的数据
// var content = qs.stringify(post_data);
// var proxy_url = 'https://api.netease.im/sms/sendcode.action?' + content;
// var options = {
//   url: proxy_url,
//   method: 'POST',
//   headers: {
//     'AppKey': Appkey,
//     'Nonce' : Nonce,
//     'CurTime': CurTime,
//     'CheckSum': CheckSum,
//     'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
//   }
// };
// function callback(error, response, body) {
//   account = JSON.parse(body)
//   console.log(account);
//   console.log(account.obj);
//   // return account
    
// }
// // console.log(account);
// request(options, callback);

// axios({
//   url: 'https://api.netease.im/sms/sendtemplate.action',
//   method: 'post',
//   headers: {
//     'AppKey': Appkey,
//     'Nonce' : Nonce,
//     'CurTime': CurTime,
//     'CheckSum': CheckSum,
//     'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
//   }
// }).then(res => {
//   console.log('res', res)
// })

module.exports = {
  ajax,
  getRandom,
  dateFormat
}