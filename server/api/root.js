const rootCode = {
  0: '收银员，前台收银，后台不可看',
  1: '管理员，后台添加数据，前台收银',
  2: '用户，前台可看不可操作，后台不可看',
  3: '开源，前后台可看，但不可操作'
}

const checkRoot = function(ctx, user) {
  if (!ctx.session || !ctx.session.userInfo) {
    ctx.body = {code: 500, message: '没有权限，请先登录'}
    return false
  }
  if (ctx.session.userInfo.root !== 1) {
    ctx.body = {code: 500, message: '没有权限'}
    return false
  }
  return true
}

module.exports = checkRoot