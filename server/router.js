const Router = require('koa-router')
const goods = require('./api/goods')
const unit = require('./api/unit')
const room = require('./api/room')
const package = require('./api/package')
const option = require('./api/option')
const user = require('./api/user')
const router = new Router({
  prefix: '/api'
})

router.use('/goods', goods.routes())
router.use('/unit', unit.routes())
router.use('/room', room.routes())
router.use('/package', package.routes())
router.use('/option', option.routes())
router.use('/user', user.routes())

module.exports = router