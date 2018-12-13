<template>
  <div class="bill-container">
    <div class="bill-icon">
      <icon-font icon="icon-zhijia-copy" fontSize="80"></icon-font>
    </div>
    <div class="bill-wrapper">
      <div class="bill-title">账单</div>
      <ul class="goods-list">
        <li v-for="(good, i) in goods" :key="i">
          <span>{{ good.name }}</span>
          <span>x{{ good.qty }}</span>
          <span>{{ good.amntunt }}</span>
        </li>
      </ul>
      <div class="account-wrapper">
        <div class="account-money">
          <span>原价</span>
          <span class="money-origin">{{ 2000 }} 元</span>
        </div>
        <div class="account-money">
          <span>折扣</span>
          <span class="money-discount" @click="openDiscount">无</span>
        </div>
        <div class="account-money">
          <span>应付金额：</span>
          <span class="money-pay">{{ 2000 }} 元</span>
        </div>
      </div>
      <div class="payment-wrapper">
          <el-button type="success" size="medium">结账</el-button>
      </div>
    </div>
    <el-dialog
      title="提示"
      :visible.sync="dialogVisible"
      :modal-append-to-body="false"
      width="30%">
      <div>
        <el-radio v-model="radioDiscount" label="9">9折</el-radio>
        <el-radio v-model="radioDiscount" label="8">8折</el-radio>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  export default {
    data() {
      return {
        goods: [
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25},
          {name: '啤酒', qty: 2, amntunt: 25}
        ],
        dialogVisible: false,
        radioDiscount: '1'
      }
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
    top: -15px;
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
    .bill-title {
      border-bottom: 1px solid $color-gray;
      padding-bottom: 10px;
    }
    .goods-list {
      max-height: 50%;
      overflow: auto;
      li {
        padding: 5px;
        display: flex;
        justify-content: space-between;
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
    .account-wrapper {
      border-top: 1px solid $color-gray;
      padding-top: 10px;
      margin-top: 10px;
      .account-money {
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
