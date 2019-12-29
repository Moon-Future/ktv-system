import * as types from './mutation-types'
// import Vue from 'vue'
import { deepClone } from '@/common/js/util'

const mutations = {
  [types.SET_ROOM_SELECTED](state, roomSelected) {
    state.roomSelected = roomSelected
  },
  [types.SET_ORDINFO](state, opts) {
    const data = deepClone(opts.data)
    const type = opts.type

    switch(type) {
      case 'ordInfo': 
        state.ordInfo = data;
        break;
      case 'packageMap': 
        Vue.set(state.ordInfo, 'package', data)
        break;
      case 'goods': 
        const flag = opts.flag
        if (!state.ordInfo.goods) {
          Vue.set(state.ordInfo, 'goods', {})
        }
        if (state.ordInfo.goods[data.id] && !flag) {
          Vue.delete(state.ordInfo.goods, data.id)
        } else {
          Vue.set(state.ordInfo.goods, data.id, data)
        }
        break;
      case 'stockGoods': 
        let stockGoods = []
        data.forEach(ele => {
          if (ele.depositQty != 0) {
            stockGoods.push(ele)
          }
        });
        Vue.set(state.ordInfo, 'stockGoods', stockGoods)
        break;
      case 'depositGoods': 
        let depositGoods = []
        data.forEach(ele => {
          if (ele.depositQty != 0) {
            depositGoods.push(ele)
          }
        });
        Vue.set(state.ordInfo, 'depositGoods', depositGoods)
        break;
      default:
        for (let key in data) {
          Vue.set(state.ordInfo, key, data[key])
        }
        break;
    }
    if (opts.roomSelected == 'place') {
      // const room = deepClone(state.roomSelected)
      // room.status = 1
      // state.roomSelected = room
      Vue.set(state.roomSelected, 'status', 1)
    } else if (opts.roomSelected == 'close') {
      // const room = deepClone(state.roomSelected)
      // room.status = 0
      // state.roomSelected = room
      Vue.set(state.roomSelected, 'status', 0)
    }

  },

  [types.SET_USERINGO](state, userInfo) {
    state.userInfo = userInfo
  },

  [types.SET_MOBILE_FLAG](state, flag) {
    state.mobileFlag = flag
  },

  [types.SET_MOBILE_BILL_SHOW](state, status) {
    state.mobileBillShow = status
  }
}

export default mutations