import * as types from './mutation-types'
import Vue from 'vue'
import { stat } from 'fs';

const mutations = {
  [types.SET_ROOM_SELECTED](state, roomSelected) {
    state.roomSelected = roomSelected
  },
  [types.SET_ORDINFO](state, opts) {
    const data = opts.data
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
      default:
        for (let key in data) {
          Vue.set(state.ordInfo, key, data[key])
        }
        break;
    }
    if (opts.roomSelected == 'place') {
      Vue.set(state.roomSelected, 'status', '1')
    } else if (opts.roomSelected == 'close') {
      Vue.set(state.roomSelected, 'status', '0')
    }

  },

  [types.SET_USERINGO](state, userInfo) {
    state.userInfo = userInfo
  },
}

export default mutations