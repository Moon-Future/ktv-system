export const goodsSelected = state => state.ordInfo && state.ordInfo.goods || {}

export const packageSelected = state => state.ordInfo && state.ordInfo.package || {goods: []}

export const roomSelected = state => state.roomSelected

export const ordInfo = state => state.ordInfo