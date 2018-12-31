import * as types from './mutation-types'

const mutations = {
  [types.SET_GOODS_SELECTED](state, opts) {
    const roomNo = opts.no
    const goods = opts.data
    const flag = opts.flag
    if (flag) {
      Array.isArray(goods) === true ? state.goodsSelectedList = goods : state.goodsSelectedList.push(goods)
    } else {
      for (let i = 0, len = state.goodsSelectedList.length; i < len; i++) {
        if (goods.id === state.goodsSelectedList[i].id) {
          state.goodsSelectedList.splice(i, 1)
          break;
        }
      }
    }
  },
  [types.SET_PACKAGE_SELECTED](state, packageSelected) {
    state.packageSelected = packageSelected
  },
  [types.SET_ROOM_SELECTED](state, roomSelected) {
    state.roomSelected = roomSelected
  },
  [types.SET_ORDINFO](state, opts) {
    const ordInfo = opts.ordInfo
    state.ordInfo = ordInfo
  }
}

export default mutations