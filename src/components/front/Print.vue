<template>
  <div class="print-container">
    <div class="print-wrapper">
      <div class="bill-title">KTV消费账单</div>
      <ul class="ord-info">
        <li v-for="(ord, i) in ordList" :key="i">
          <span>{{ ord.title }}：</span>
          <span>{{ ordInfo[ord.key] | filterTime(ord.key) }}</span>
        </li>
      </ul>
      <ul class="goods-list">
        <li>
          <span>商品</span>
          <span>数量</span>
          <span>单价</span>
        </li>
        <li>
          <span>{{ packageSelected.packagem }}{{ packageSelected.type == undefined ? '' : packageSelected.type == '1' ? '(阳光档)' : '(黄金档)' }}</span>
          <span>{{ packageSelected.packagem ? 'x1' : '' }}</span>
          <span>{{ packageSelected.type == '1' ? packageSelected.price1 : packageSelected.price2 }}</span>
        </li>
        <li v-for="(goods, i) in packageGoods" :key="i">
          <span>{{ goods.goodsm }}</span>
          <span>x{{ goods.qty || 1 }}</span>
          <span>{{ 0 }}</span>
        </li>
        <li v-for="(good, i) in goodsSelected" :key="`${i}_${good.name}`">
          <span>{{ good.name }}</span>
          <span>x{{ good.qty || 1 }}</span>
          <span>{{ good.price }}</span>
        </li>
        <li v-for="(good, i) in ordInfo.stockGoods" :key="`${i}_stock_${good.goodsm}`">
          <span>{{ good.goodsm }}(寄存)</span>
          <span>x{{ good.depositQty }}</span>
          <span>{{ 0 }}</span>
        </li>
      </ul>
      <div class="account-wrapper">
        <div class="account-item" v-for="(item, i) in accountList" :key="i">
          <span>{{ item.title }}</span>
          <span :class="item.class" v-if="item.key == 'origin'">{{ ordInfo.totalPrice || 0 }} 元</span>
          <span :class="item.class" v-if="item.key == 'discount' && discountShow">{{ ordInfo.discount || 0 }} 元</span>
          <span :class="item.class" v-if="item.key == 'pay'">{{ (ordInfo.totalPrice - (ordInfo.discount || 0))  || 0}} 元</span>
          <span :class="item.class" v-if="item.key == 'paymethos'">
            <span>{{ payMethodMap[ordInfo.payMethod] && payMethodMap[ordInfo.payMethod].title}}</span>
            <icon-font v-show="payMethodMap[ordInfo.payMethod]" :icon="payMethodMap[ordInfo.payMethod] && payMethodMap[ordInfo.payMethod].icon" fontSize="12"></icon-font>
          </span>
          <span :class="item.class" v-if="item.key == 'user'">{{ ordInfo.user }}</span>
          <span :class="item.class" v-if="item.key == 'time'">{{ printTime | filterTime('startTime') }}</span>
        </div>
      </div>
      <div class="print-order">
        <Button v-show="btnShow" type="warning" @click="printOrder">打单</Button>
      </div>
    </div>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { dateFormat } from '@/common/js/util'
  import { mapGetters, mapMutations } from 'vuex'
  export default {
    props: {
      ordInfo: {
        type: Object,
        default() {
          return {}
        }
      },
      printTime: {
        type: Number,
        default: new Date().getTime()
      },
      btnShow: {
        type: Boolean,
        default: false
      }
    },
    data() {
      return {
        ordList: [
          {key: 'nun', title: '账单号'},
          {key: 'room', title: '包间号'},
          {key: 'startTime', title: '下单时间'},
          {key: 'vip', title: '会员'},
          {key: 'balance', title: '余额'}
        ],
        accountList: [
          {key: 'origin', title: '原价', class: 'money-origin'},
          {key: 'discount', title: '折扣', class: 'money-discount'},
          {key: 'pay', title: '应付金额', class: 'money-pay'},
          {key: 'paymethos', title: '付款方式', class: 'money-paymethos'},
          {key: 'user', title: '收银员', class: 'money-user'},
          {key: 'time', title: '打单时间', class: 'money-time'}
        ],
        radioDiscount: '1',
        payMethodMap: {
          1: {icon: 'icon-big-Pay', title: '支付宝支付'},
          2: {icon: 'icon-weixinzhifu', title: '微信支付'},
          3: {icon: 'icon-zhifupingtai-yinlian', title: '刷卡支付'},
          4: {icon: 'icon-cash_payment', title: '现金支付'},
          5: {icon: 'icon-available', title: '余额支付'}
        },
        discountShow: true
      }
    },
    computed: {
      packageSelected() {
        return this.ordInfo && this.ordInfo.package || {goods: []}
      },
      goodsSelected() {
        return this.ordInfo && this.ordInfo.goods || {}
      },
      packageGoods() {
        if (!this.packageSelected || !this.packageSelected.package) {
          return []
        }
        let array = []
        const grp = this.packageSelected.grp.split(',')
        const grpSelected = this.packageSelected.grpSelected
        if (grp.length === 0) {
          return []
        }
        this.packageSelected.goods.forEach(ele => {
          if (grp.indexOf(ele.goods + '') === -1) {
            array.push(ele)
          } else {
            if (ele.goods == grpSelected) {
              array.push(ele)
            }
          }
        })
        return array
      },
    },
    methods: {
      printOrder() {
        this.$emit('printOrder')
      }
    },
    filters: {
      filterTime(value, key) {
        if (key === 'startTime' && value) {
          return dateFormat(value, 'yyyy-MM-dd hh:mm')
        } 
        return value
      }
    },
    watch: {
      roomSelected() {
        this.discountMoney = this.ordInfo.discount || 0
      }
    },
    components: {
      IconFont
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';
  .print-container {
    display: flex;
    justify-content: center;
  }
  .print-wrapper {
    width: 10cm;
    border: 1px solid $color-gray;
    background: $color-white;
    left: 10px;
    right: 10px;
    top: 0px;
    bottom: 10px;
    padding: 20px 10px 10px 20px;
    font-size: 12px;
    overflow: auto;
    .bill-title {
      padding-bottom: 10px;
      font-size: 16px;
      text-align: center;
    }

    .goods-list, .ord-info {
      li {
        padding: 5px;
        display: flex;
        justify-content: space-between;
        &:first-child {
          span {
            font-weight: bold;
          }
        }
        span {
          flex: 1;
          line-height: 16px;
          text-align: right;
          &:first-child {
            text-align: left;
          }
        }
      }
    }

    .ord-info {
      margin: 10px 0;
      padding: 10px 0;
      border-top: 2px dashed $color-gray;
      border-bottom: 2px dashed $color-gray;
      span {
        font-weight: bold;
      }
      .order-vip {
        color: $color-blue;
        cursor: pointer;
        &:hover {
          text-decoration: underline;
        }
      }
      .order-vip-operate {
        color: $color-blue;
        cursor: pointer;
        padding: 0 5px;
        &:hover {
          text-decoration: underline;
        }
      }
    }

    .account-wrapper {
      margin-top: 10px;
      padding-top: 10px;
      border-top: 2px solid $color-gray;
      .account-item {
        padding: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        .money-origin {
          color: $color-blue;
          font-weight: bold;
        }
        .money-discount {
          color: $color-green;
          font-weight: bold;
        }
        .money-pay {
          color: $color-red;
          font-weight: bold;
        }
        .money-paymethos {
          cursor: pointer;
          span {
            margin-right: 5px;
            color: $color-blue;
          }
        }
      }
    }
    .print-order {
      button {
        width: 100%;
      }
    }
  }
</style>
