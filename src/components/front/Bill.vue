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
          <span>{{ packageSelected.name }}</span>
          <span>{{ packageSelected.name ? 'x1' : '' }}</span>
          <span>{{ packageSelected.price }}</span>
        </li>
        <li v-for="(good, i) in goodsSelectedList" :key="i">
          <span>{{ good.name }}</span>
          <span>x{{ good.qty || 1 }}</span>
          <span>{{ good.price }}</span>
        </li>
      </ul>
      <div class="account-wrapper">
        <div class="account-item" v-for="(item, i) in accountList" :key="i">
          <span>{{ item.title }}</span>
          <span :class="item.class" v-if="i === 0 || i === 2">{{ totalPrice }} 元</span>
        </div>
      </div>
      <div class="payment-wrapper">
          <Button type="success">结账</Button>
      </div>
    </div>
    <Modal
      title="提示"
      v-model="dialogVisible">
      <div>
        <Radio v-model="radioDiscount" label="9">9折</Radio>
        <Radio v-model="radioDiscount" label="8">8折</Radio>
      </div>
    </Modal>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { mapGetters } from 'vuex'
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
        dialogVisible: false,
        radioDiscount: '1'
      }
    },
    computed: {
      totalPrice() {
        let price = 0
        this.goodsSelectedList.forEach(ele => {
          price += Number(ele.price)
        })
        return price
      },
      ...mapGetters([
        'goodsSelectedList',
        'packageSelected',
        'roomSelected',
        'ordInfo'
      ])
    },
    methods: {
      openDiscount() {
        this.dialogVisible = true
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
        .money-origin {
          color: $color-blue;
          font-weight: bold;
        }
        .money-discount {
          color: $color-green;
          font-weight: bold;
          text-decoration: underline;
          cursor: pointer;
        }
        .money-pay {
          color: $color-origin;
          font-weight: bold;
        }
        .money-paymethos {
          text-decoration: underline;
          cursor: pointer;
        }
      }
    }
    .payment-wrapper {
      margin-top: 30px;
      button {
        width: 100%;
      }
    }
  }
</style>
