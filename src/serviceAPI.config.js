const apiUrl = {
  insertGoods: '/api/goods/insertGoods',
  getGoods: '/api/goods/getGoods',
  deleteGoods: '/api/goods/deleteGoods',
  updGoods: '/api/goods/updGoods',

  insertUnit: '/api/unit/insertUnit',
  getUnit: '/api/unit/getUnit',
  deleteUnit: '/api/unit/deleteUnit',
  updUnit: '/api/unit/updUnit',

  insertRoomType: '/api/room/insertRoomType',
  getRoomType: '/api/room/getRoomType',
  deleteRoomType: '/api/room/deleteRoomType',
  updRoomType: '/api/room/updRoomType',
  insertRoomInfo: '/api/room/insertRoomInfo',
  getRoomInfo: '/api/room/getRoomInfo',
  deleteRoomInfo: '/api/room/deleteRoomInfo',
  updRoomInfo: '/api/room/updRoomInfo',

  getOptions: '/api/option/getOptions',

  insertSupply: '/api/supply/insertSupply',
  getSupply: '/api/supply/getSupply',
  deleteSupply: '/api/supply/deleteSupply',
  updSupply: '/api/supply/updSupply',

  insertInventoryIn: '//api/inventory/insertInventoryIn',
  deleteInventoryIn: '//api/inventory/deleteInventoryIn',
  updInventoryIn: '//api/inventory/updInventoryIn',
  getInventoryList: '//api/inventory/getInventoryList',
  getInventoryOut: '//api/inventory/getInventoryOut',

  saveDelivery: '/api/delivery/saveDelivery',
  getDeliveryHistory: '/api/delivery/getDeliveryHistory',
  deleteDelivery: '/api/delivery/deleteDelivery',

  register: '/api/user/register',
  login: '/api/user/login',
  logout: '/api/user/logout',
  getSession: '/api/user/getSession',

  insertOrder: '/api/order/insertOrder',
  getOrder: '/api/order/getOrder',
  getOrderHistory: '/api/order/getOrderHistory',
  updOrder: '/api/order/updOrder'
}

module.exports = apiUrl