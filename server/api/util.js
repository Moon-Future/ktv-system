const request = require('request')

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

module.exports = {
  getRandom,
  dateFormat
}