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
          <span v-if="ord.key === 'vip' && ordInfo.room && !ordInfo[ord.key]" class="order-vip" @click="loginVip">登陆</span>
          <span v-else-if="ord.key === 'balance' && ordInfo.room && ordInfo['vip']">
            <span class="order-vip-operate" @click="logoutVip">注销</span>
            <span class="order-vip-operate" @click="modalRecharge = true">充值</span>
            {{ ordInfo[ord.key] }}
          </span>
          <span v-else>{{ ordInfo[ord.key] | filterTime(ord.key) }}</span>
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
      </ul>
      <div class="account-wrapper">
        <div class="account-item" v-for="(item, i) in accountList" :key="i">
          <span>{{ item.title }}</span>
          <span :class="item.class" v-if="item.key == 'origin'">{{ totalPrice }} 元</span>
          <span :class="item.class" v-if="item.key == 'discount'"><input v-model="discountMoney" @input="changeDiscount" @blur="discountBlur" /> 元</span>
          <span :class="item.class" v-if="item.key == 'pay'">{{ payPrice }} 元</span>
          <span :class="item.class" v-if="item.key == 'paymethos'" @click="openModal">
            <span>{{ payMethodMap[ordInfo.payMethod] && payMethodMap[ordInfo.payMethod].title || '选择支付方式' }}</span>
            <icon-font v-show="payMethodMap[ordInfo.payMethod]" :icon="payMethodMap[ordInfo.payMethod] && payMethodMap[ordInfo.payMethod].icon" fontSize="12"></icon-font>
          </span>
          <span :class="item.class" v-if="item.key == 'user'">{{ ordInfo.user || userInfo.name }}</span>
        </div>
      </div>
      <div class="button-wrapper">
        <Button type="primary" :disabled="ordInfo.status == 1" @click="placeOrder">{{ ordInfo.status == 1 ? '已开单' : '开单' }}</Button>
        <Button v-show="roomSelected.status == '1'" type="error" @click="cancelOrder">取消订单</Button>
        <Button v-show="roomSelected.status == '1'" type="warning" @click="printFlag = true">打单</Button>
        <Button v-show="roomSelected.status == '1'" type="success" @click="closeOrder">结账</Button>
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
    <Modal
      v-model="modalVip"
      title="会员登陆"
      :footer-hide="true">
      <Form ref="formVip" :model="vipFormData" :rules="ruleValidate" label-position="left" :label-width="60">
        <FormItem prop="phone" label="手机号">
          <i-input type="text" v-model="vipFormData.phone"></i-input>
        </FormItem>
        <FormItem prop="verifyCode" label="验证码">
          <i-input v-model="vipFormData.verifyCode">
            <Button slot="append" @click="sendVerifyCode">
              {{ verifyCodeBtn + (typeof verifyCodeBtn === 'number' ? ' s' : '')  }}
            </Button>
          </i-input>
        </FormItem>
      </Form>
      <div class="vip-button">
        <Button class="vip-cancel" @click="cancelVip">取消</Button>
        <Button type="primary" class="vip-ok" @click="okVip">确定</Button>
      </div>
    </Modal>
    <Modal
      v-model="modalRecharge"
      title="充值"
      :footer-hide="true">
      <i-input v-model="rechargeMoney" suffix="logo-yen" placeholder="输入充值金额"></i-input>
      <div class="recharge-button">
        <Button @click="cancelRecharge">取消</Button>
        <Button type="primary" class="recharge-ok" @click="okRecharge">确定</Button>
      </div>
    </Modal>
    <Modal
      v-model="printFlag"
      title="打印账单"
      fullscreen
      @on-ok="printOrder">
      <print-item ref="printWrapper" :ordInfo="ordInfo" :printTime="printTime"></print-item>
    </Modal>
    <!-- <print-item v-show="printFlag" ref="printWrapper" :ordInfo="ordInfo" :printTime="printTime"></print-item> -->
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import PrintItem from '@/components/front/Print'
  import { dateFormat } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters, mapMutations } from 'vuex'
  export default {
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
        modalVisible: false,
        payMethodMap: {
          1: {icon: 'icon-big-Pay', title: '支付宝支付'},
          2: {icon: 'icon-weixinzhifu', title: '微信支付'},
          3: {icon: 'icon-zhifupingtai-yinlian', title: '刷卡支付'},
          4: {icon: 'icon-cash_payment', title: '现金支付'},
          5: {icon: 'icon-available', title: '余额支付'}
        },
        modalVip: false,
        vipFormData: {phone: '', verifyCode: ''},
        ruleValidate: {
          phone: [
            {required: true, message: '不得为空', trigger: 'blur'},
            {pattern: /^1[34578]\d{9}$/, message: '手机号码有误', trigger: 'blur'}
          ],
          verifyCode: [{required: true, message: '不得为空', trigger: 'blur'}]
        },
        discountMoney: 0,
        verifyCodeBtn: '发送验证码',
        modalRecharge: false,
        rechargeMoney: '',
        printTime: new Date().getTime(),
        printFlag: false
      }
    },
    computed: {
      totalPrice() {
        let price = 0
        const packagePrice = this.packageSelected.type == '1' ? this.packageSelected.price1 : this.packageSelected.price2
        for (let key in this.goodsSelected) {
          price += Number(this.goodsSelected[key].price) * Number(this.goodsSelected[key].qty)
        }
        price += Number(packagePrice || 0)
        this.setOrdInfo({data: {totalPrice: price}})
        return price
      },
      payPrice() {
        return this.totalPrice - this.discountMoney
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
      ...mapGetters([
        'goodsSelected',
        'packageSelected',
        'roomSelected',
        'ordInfo',
        'userInfo'
      ])
    },
    methods: {
      printOrder() {
        this.printTime = new Date().getTime()
        this.$nextTick(() => {
          setTimeout(() => {
            const printHtml = this.$refs.printWrapper.$el.innerHTML
            const app = document.getElementById('app')
            const printPanel = document.getElementById('printPanel')
            app.style.display = 'none'
            printPanel.innerHTML = printHtml
            window.print()
            printPanel.innerHTML = ''
            app.style.display = 'block'
            this.printFlag = false
          }, 50)
        })
      },
      sendVerifyCode() {
        const phone = this.vipFormData.phone
        if (phone === '' || !/^1[34578]\d{9}$/.test(phone)) {
          this.$Message.error('手机号码有误')
          return
        }
        if (this.sending) {
          this.$Message.error('请稍后再发送')
          return
        }
        this.sending = true
        this.$http.post(apiUrl.sendVerifyCode, {
          data: {phone, login: true}
        }).then(res => {
          if (res.data.code === 200) {
            this.$Message.success(res.data.message)
            this.verifyCodeBtn = 60
            this.sendTimer = setInterval(() => {
              this.verifyCodeBtn -= 1
              if (this.verifyCodeBtn <= 0) {
                this.verifyCodeBtn = '发送验证码'
                this.sending = false
                clearInterval(this.sendTimer)
              }
            }, 1000)
          } else {
            this.sending = false
            this.$Message.error(res.data.message)
          }
        })
      },
      cancelVip() {
        this.modalVip = false
      },
      okVip() {
        this.$http.post(apiUrl.loginVip, {
          data: {phone: this.vipFormData.phone, verifyCode: this.vipFormData.verifyCode}
        }).then(res => {
          if (res.data.code === 200) {
            const vipInfo = res.data.message[0]
            this.setOrdInfo({data: {vip: vipInfo.phone, balance: vipInfo.balance}})
            this.modalVip = false
            this.updateOrder()
          } else {
            this.$Message.error(res.data.message)
          }
        })
      },
      loginVip() {
        if (!this.ordInfo.nun) {
          this.$Message.error('请先开单')
          return
        }
        this.vipFormData = {phone: '', verifyCode: ''}
        this.verifyCodeBtn = '发送验证码'
        this.sending = false
        clearInterval(this.sendTimer)
        this.modalVip = true
      },
      logoutVip() {
        this.$Modal.confirm({
          title: '退出会员登陆',
          content: '<h1>确认退出会员登陆？</h1>',
          onOk: () => {
            this.setOrdInfo({data: {vip:'', balance:''}})
            this.updateOrder()
            this.$http.post(apiUrl.logoutVip, {
              data: {phone: this.ordInfo.vip}
            })
          }
        })
      },
      okRecharge() {
        if (this.loading) {
          this.$Message.error('正在提交，请稍等')
          return
        }
        if (this.rechargeMoney == '' || this.rechargeMoney == '0' || !/^\d*$/.test(this.rechargeMoney)) {
          this.$Message.error('请填写正确的金额')
          return
        }
        this.loading = true
        this.$http.post(apiUrl.recharge, {
          data: {phone: this.ordInfo.vip, rechargeMoney: this.rechargeMoney}
        }).then(res => {
          if (res.data.code === 200) {
            this.$Message.success(res.data.message)
            this.setOrdInfo({data: {vip:this.ordInfo.vip, balance:Number(this.ordInfo.balance) + Number(this.rechargeMoney)}})
            this.rechargeMoney = ''
            this.modalRecharge = false
          } else {
            this.$Message.error(res.data.message)
          }
          this.loading = false
        }).catch(() => {
          this.loading = false
        })
      },
      cancelRecharge() {
        this.modalRecharge = false
        this.rechargeMoney = ''
      },
      changeDiscount() {
        this.discountMoney = (this.discountMoney + '').replace(/[^0-9]/, '')
        if (this.discountMoney[0] == '0') {
          this.discountMoney = this.discountMoney.substr(1)
        }
        if (this.discountMoney > this.totalPrice) {
          this.discountMoney = this.totalPrice
        }
      },
      discountBlur() {
        this.setOrdInfo({data: {discount: this.discountMoney}})
        this.updateOrder()
      },
      placeOrder() {
        if (!this.ordInfo.room || !this.ordInfo.package) {
          this.$Message.error('请先选择包间和套餐')
          return
        }
        const startTime = new Date().getTime()
        this.$http.post(apiUrl.insertOrder, {
          data: {ordInfo: this.ordInfo, startTime}
        }).then(res => {
          if (res.data.code === 200) {
            this.setOrdInfo({data: {nun: res.data.message, status: 1, user: this.userInfo.name}, roomSelected: 'place'})
          }
        })
      },
      closeOrder() {
        if (this.roomSelected.status != 1) {
          this.$Message.error('请先开单')
          return
        }
        if (!this.ordInfo.payMethod) {
          this.$Message.error('请选择支付方式')
          return
        }
        this.$Modal.confirm({
          title: '结账',
          content: '<h1>确认结账</h1>',
          onOk: () => {
            this.$http.post(apiUrl.closeOrder, {
              data: {ordInfo: this.ordInfo}
            }).then(res => {
              this.setOrdInfo({data: {room: this.ordInfo.room, status: 0}, type: 'ordInfo', roomSelected: 'close'})
            })
          },
        })
      },
      cancelOrder() {
        this.$Modal.confirm({
          title: '取消订单',
          content: '<h1>确认取消订单</h1>',
          onOk: () => {
            this.$http.post(apiUrl.cancelOrder, {
              data: {ordInfo: this.ordInfo}
            }).then(res => {
              this.setOrdInfo({data: {room: this.ordInfo.room, status: 0}, type: 'ordInfo', roomSelected: 'close'})
            })
          },
        })
      },
      updateOrder() {
        if (this.roomSelected.status != '1') {
          return
        }
        this.$http.post(apiUrl.updOrder, {
          data: {ordInfo: this.ordInfo}
        }).then(res => {
          
        })
      },
      openModal() {
        this.modalVisible = true
      },
      selectPayMethod(item, key) {
        if (key == '5') {
          if (!this.ordInfo.vip) {
            this.$Message.error('请先登陆会员')
            return 
          } else if(this.ordInfo.balance < this.totalPrice) {
            this.$Message.error('会员余额不足')
            return
          }
        }
        this.modalVisible = false
        this.setOrdInfo({data: {payMethod: key}})
        this.updateOrder()
      },
      ...mapMutations({
        setOrdInfo: 'SET_ORDINFO'
      })
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
      IconFont,
      PrintItem
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
  .vip-button {
    text-align: right;
    .vip-ok {
      margin-left: 10px;
    }
  }
  .recharge-button {
    text-align: right;
    margin-top: 10px;
    .recharge-ok {
      margin-left: 10px;
    }
  }
</style>
