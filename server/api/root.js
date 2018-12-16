const checkRoot = function(ctx, user) {
  // if (user) {
  //   if (!ctx.session || !ctx.session.userInfo) {
  //     return {code: 500, message: '没有权限'}
  //   }
  // } else {
  //   if (!ctx.session || !ctx.session.userInfo || ctx.session.userInfo.root !== 1) {
  //     return {code: 500, message: '没有权限'}
  //   }
  // }
  return {code: 200}
}

module.exports = checkRoot