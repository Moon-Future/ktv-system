const Router = require('koa-router')
const product = require('./api/product')
const unit = require('./api/unit')
const company = require('./api/company')
const supply = require('./api/supply')
const order = require('./api/order')
const delivery = require('./api/delivery')
const inventory = require('./api/inventory')
const user = require('./api/user')
const router = new Router({
  prefix: '/api'
})

router.use('/product', product.routes())
router.use('/unit', unit.routes())
router.use('/company', company.routes())
router.use('/supply', supply.routes())
router.use('/order', order.routes())
router.use('/delivery', delivery.routes())
router.use('/inventory', inventory.routes())
router.use('/user', user.routes())

module.exports = router