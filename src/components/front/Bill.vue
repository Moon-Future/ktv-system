<template>
  <div class="bill-container">
    <div class="bill-icon">
      <icon-font icon="icon-zhijia" fontSize="80"></icon-font>
    </div>
    <div class="bill-wrapper">
      <div class="bill-title">KTV消费账单</div>
      <ul class="ord-info">
        <li v-for="(ord, i) in ordList" :key="i">
          <span>{{ ord.title }}：</span>
          <span>{{ ord.value }}</span>
        </li>
      </ul>
      <ul class="goods-list">
        <li>
          <span>商品</span>
          <span>数量</span>
          <span>单价</span>
        </li>
        <li>
          <span>{{ packageSelected.packagem }}</span>
          <span>{{ packageSelected.packagem ? 'x1' : '' }}</span>
          <span>{{ packageSelected.price }}</span>
        </li>
        <li v-for="(goods, i) in packageSelected.goods" :key="i">
          <span>{{ goods.goodsm }}</span>
          <span>x{{ goods.qty || 1 }}</span>
          <span>{{ 0 }}</span>
        </li>
        <li v-for="(good, i) in goodsSelected" :key="`${i}_${good.name}`">
          <span>{{ good.name }}</span>
          <span>x{{ good.qty || 1 }}</span>
          <span>{{ good.price }}</span>
        </li>
      </ul>
      <div class="account-wrapper">
        <div class="account-item" v-for="(item, i) in accountList" :key="i">
          <span>{{ item.title }}</span>
          <span :class="item.class" v-if="item.key == 'origin' || item.key == 'pay'">{{ totalPrice }} 元</span>
          <span :class="item.class" v-if="item.key == 'discount'"><input /> 元</span>
          <span :class="item.class" v-if="item.key == 'paymethos'" @click="openModal">
            <span>{{ payMethodMap[ordInfo.payMethod] && payMethodMap[ordInfo.payMethod].title || '选择支付方式' }}</span>
            <icon-font v-show="payMethodMap[ordInfo.payMethod]" :icon="payMethodMap[ordInfo.payMethod] && payMethodMap[ordInfo.payMethod].icon" fontSize="12"></icon-font>
          </span>
        </div>
      </div>
      <div class="button-wrapper">
        <Button type="primary" :disabled="ordInfo.status == 1" @click="placeOrder">{{ ordInfo.status == 1 ? '已开单' : '开单' }}</Button>
        <Button type="success">结账</Button>
      </div>
    </div>
    <Modal
      v-model="modalVisible"
      :footer-hide="true"
      title="选择支付方式">
      <div class="payment-wrapper">
        <div class="payment-item" v-for="(item, i) in payMethodMap" :key="i" @click="selectPayMethod(item, i)">
          <icon-font :icon="item.icon" fontSize="64"></icon-font>
          <span>{{ item.title }}</span>
        </div>
      </div>
    </Modal>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters, mapMutations } from 'vuex'
  export default {
    data() {
      return {
        ordList: [
          {key: '', title: '账单号', value: 'YYH8726617'},
          {key: '', title: '包间号', value: 1},
          {key: '', title: '下单时间', value: '2018-12-14 20:00'},
          {key: '', title: '会员', value: '15888888888'},
          {key: '', title: '余额', value: '8008'}
        ],
        accountList: [
          {key: 'origin', title: '原价', class: 'money-origin'},
          {key: 'discount', title: '折扣', class: 'money-discount'},
          {key: 'pay', title: '应付金额', class: 'money-pay'},
          {key: 'paymethos', title: '付款方式', class: 'money-paymethos'},
          {key: 'psn', title: '收银员', class: 'money-psn'},
          {key: 'time', title: '打单时间', class: 'money-time'}
        ],
        radioDiscount: '1',
        modalVisible: false,
        payMethodMap: {
          1: {icon: 'icon-big-Pay', title: '支付宝支付'},
          2: {icon: 'icon-weixinzhifu', title: '微信支付'},
          3: {icon: 'icon-zhifupingtai-yinlian', title: '刷卡支付'},
          4: {icon: 'icon-cash_payment', title: '现金支付'}
        }
      }
    },
    computed: {
      totalPrice() {
        let price = 0
        for (let key in this.goodsSelected) {
          price += Number(this.goodsSelected[key].price) * Number(this.goodsSelected[key].qty)
        }
        price += Number(this.packageSelected.price || 0)
        return price
      },
      ...mapGetters([
        'goodsSelected',
        'packageSelected',
        'roomSelected',
        'ordInfo'
      ])
    },
    methods: {
      placeOrder() {
        console.log(this.ordInfo)
        // const startTime = new Date().getTime()
        // this.$http.post(apiUrl.insertOrder, {
        //   data: {ordInfo: this.ordInfo, startTime}
        // }).then(res => {

        // })
      },
      openModal() {
        this.modalVisible = true
      },
      selectPayMethod(item, key) {
        this.modalVisible = false
        this.setOrdInfo({data: key, type: 'payMethod'})
      },
      ...mapMutations({
        setOrdInfo: 'SET_ORDINFO'
      })
    },
    wacth: {
      roomSelected() {

      }
    },
    components: {
      IconFont
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';
  .bill-container {
    height: 100%;
    background: $color-shalloworigin;
    padding: 10px;
    box-sizing: border-box;
    border-radius: 5px;
    position: relative;
  }
  .bill-icon {
    position: relative;
    z-index: 10;
    top: -38px;
  }
  .bill-wrapper {
    width: 10cm;
    background: $color-white;
    position: absolute;
    left: 10px;
    right: 10px;
    top: 50px;
    bottom: 10px;
    padding: 40px 10px 10px 10px;
    font-size: 12px;
    overflow: auto;
    .bill-title {
      padding-bottom: 10px;
      font-size: 16px;
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
          text-overflow: ellipsis;
          overflow: hidden;
          word-break: keep-all;
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
        input {
          width: 30px;
          border: none;
          outline: none;
          border-bottom: 1px solid $color-black;
          text-align: center;
        }
        .money-origin {
          color: $color-blue;
          font-weight: bold;
        }
        .money-discount {
          color: $color-green;
          font-weight: bold;
        }
        .money-pay {
          color: $color-origin;
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
    .button-wrapper {
      margin-top: 30px;
      button {
        width: 100%;
        margin-bottom: 10px;
      }
    }
  }
  .payment-wrapper {
    display: flex;
    justify-content: space-around;
    .payment-item {
      display: flex;
      flex-flow: column;
      align-items: center;
      cursor: pointer;
      &:hover {
        span {
          font-weight: bold;
        }
      }
    }
  }
</style>
