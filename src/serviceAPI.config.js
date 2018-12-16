const apiUrl = {
  insertProduct: '/api/product/insertProduct',
  getProduct: '/api/product/getProduct',
  deleteProduct: '/api/product/deleteProduct',
  updProduct: '/api/product/updProduct',

  insertUnit: '/api/unit/insertUnit',
  getUnit: '/api/unit/getUnit',
  deleteUnit: '/api/unit/deleteUnit',
  updUnit: '/api/unit/updUnit',

  insertCompany: '/api/company/insertCompany',
  getCompany: '/api/company/getCompany',
  deleteCompany: '/api/company/deleteCompany',
  updCompany: '/api/company/updCompany',

  getOptions: '/api/supply/getOptions',
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