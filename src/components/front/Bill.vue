<template>
  <div class="bill-container">
    <div class="bill-icon">
      <icon-font icon="icon-zhijia" fontSize="80"></icon-font>
    </div>
    <div class="bill-wrapper">
      <div class="bill-title">亿民汇KTV 消费账单</div>
      <ul class="ord-info">
        <li v-for="(ord, i) in ordList" :key="i">
          <span>{{ ord.title }}：</span>
          <span v-if="ord.key === 'vip' && ordInfo.room && !ordInfo[ord.key]" class="order-vip" @click="loginVip">登陆</span>
          <span v-else-if="ord.key === 'balance' && ordInfo.room && ordInfo['vip']">
            <span class="order-vip-operate" @click="openDepositModal">寄取</span>
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
        <li v-for="(good, i) in ordInfo.stockGoods" :key="`${i}_stock_${good.goodsm}`">
          <span>{{ good.goodsm }}(寄存)</span>
          <span>x{{ good.depositQty }}</span>
          <span>{{ 0 }}</span>
        </li>
      </ul>
      <div class="account-wrapper">
        <div class="account-item" v-for="(item, i) in accountList" :key="i">
          <span>{{ item.title }}</span>
          <span :class="item.class" v-if="item.key == 'origin'">{{ totalPrice }} 元</span>
          <span :class="item.class" v-if="item.key == 'discount'"><input v-model="discountMoney" @input="changeDiscount" @blur="discountBlur" /> 元</span>
          <span :class="item.class" v-if="item.key == 'pay'">{{ payPrice }} 元</span>
          <span :class="item.class" v-if="item.key == 'paymethos'" @click="modalVisible = true">
            <span>{{ payMethodMap[ordInfo.payMethod] && payMethodMap[ordInfo.payMethod].title || '选择支付方式' }}</span>
            <icon-font v-show="payMethodMap[ordInfo.payMethod]" :icon="payMethodMap[ordInfo.payMethod] && payMethodMap[ordInfo.payMethod].icon" fontSize="12"></icon-font>
          </span>
          <span :class="item.class" v-if="item.key == 'user'">{{ ordInfo.user || userInfo.name }}</span>
        </div>
      </div>
      <div class="button-wrapper">
        <Button type="primary" :disabled="ordInfo.nun !== undefined" @click="placeOrder">{{ ordInfo.nun  !== undefined ? '已开单' : '开单' }}</Button>
        <Button v-show="roomSelected.status == '1'" type="error" @click="cancelOrder">取消订单</Button>
        <Button v-show="roomSelected.status == '1'" type="warning" @click="openPrintModal">打单</Button>
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
        <Button class="vip-cancel" @click="modalVip = false">取消</Button>
        <Button type="primary" class="vip-ok" @click="okVip">确定</Button>
      </div>
    </Modal>
    <Modal
      v-model="modalRecharge"
      title="充值"
      :footer-hide="true">
      <Form :model="rechargeForm" :label-width="80">
        <FormItem label="充值金额">
          <Input v-model="rechargeForm.rechargeMoney" suffix="logo-yen" placeholder="输入充值金额" />
        </FormItem>
        <FormItem label="赠送金额">
          <Input v-model="rechargeForm.giveMoney" suffix="logo-yen" placeholder="输入赠送金额" />
        </FormItem>
      </Form>
      <div class="modal-button">
        <Button @click="cancelRecharge">取消</Button>
        <Button type="primary" @click="okRecharge">确定</Button>
      </div>
    </Modal>
    <Modal
      v-model="printFlag"
      title="打印账单"
      fullscreen>
      <print-item ref="printWrapper" :ordInfo="printOrdInfo" :printTime="printTime"></print-item>
      <div class="drawer-footer" slot="footer" v-show="printFlag">
        <Button @click="printFlag = false">取消</Button>
        <Button type="primary" @click="printOrder">确认</Button>
      </div>
    </Modal>
    <Modal
      v-model="depositFlag"
      title="会员商品寄取"
      :footer-hide="true">
      <RadioGroup v-model="depositTakeTab" type="button" size="small" style="margin-bottom:10px">
        <Radio label="deposit">寄存</Radio>
        <Radio label="take">取用</Radio>
      </RadioGroup>
      <Table
        :columns="depositTakeTab === 'deposit' ? allGoodsColumns : takeGoodsColumns" 
        :data="depositTakeTab === 'deposit' ? allGoodsData : takeGoodsData" 
        border
        size="small"
        @on-selection-change="depositTakeSelect"></Table>
      <div class="modal-button">
        <Button @click="depositFlag = false">取消</Button>
        <Button type="primary" @click="depositSubmit">确定</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import PrintItem from '@/components/front/Print'
  import { dateFormat, deepClone } from '@/common/js/util'
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
        rechargeForm: {rechargeMoney: '', giveMoney: ''},
        printTime: new Date().getTime(),
        printFlag: false,
        printOrdInfo: {},
        depositMap: {},
        depositFlag: false,
        depositTakeTab: 'deposit',
        depositList: [],
        takeList: [],
        takeGoodsData: [],
        allGoodsColumns: [
          {type: 'selection', width: 50, align: 'center'},
          {key: 'goodsm', title: '商品'},
          {key: 'qty', title: '数量'},
          {key: 'depositQty', title: '寄存', render: (h, params) => {
            const self = this
            return h('InputNumber', {
              props: {min: 0, max: Number(params.row.qty), value: params.row.depositQty},
              on: {
                input(val) {
                  self.$set(self.allGoodsData[params.index], 'depositQty', val)
                  self.depositList.forEach(ele => {
                    if (ele.goods === params.row.goods) {
                      ele.depositQty = val
                    }
                  })
                }
              }
            })
          }}
        ],
        takeGoodsColumns: [
          {type: 'selection', width: 50, align: 'center'},
          {key: 'goodsm', title: '商品'},
          {key: 'qty', title: '数量'},
          {key: 'depositQty', title: '取用', render: (h, params) => {
            const self = this
            return h('InputNumber', {
              props: {min: 0, max: Number(params.row.qty), value: params.row.depositQty},
              on: {
                input(val) {
                  self.$set(self.takeGoodsData[params.index], 'depositQty', val)
                  self.takeList.forEach(ele => {
                    if (ele.goods === params.row.goods) {
                      ele.depositQty = val
                    }
                  })
                }
              }
            })
          }}
        ]
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
        if (this.ordInfo.nun && this.packageSelected.package) {
          this.setOrdInfo({data: {totalPrice: price}})
        }
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
      allGoodsData() {
        let goodsList = deepClone(this.packageGoods)
        for (let key in this.goodsSelected) {
          const item = this.goodsSelected[key]
          const obj = {goods: item.id, goodsm: item.name, qty: item.qty, unitm: item.unitm}
          goodsList.push(obj)
        }
        goodsList.forEach(ele => {
          ele.depositQty = 0
          if (this.depositMap && this.depositMap[ele.goods]) {
            ele._checked = true
            ele.depositQty = Number(this.depositMap[ele.goods].depositQty)
          }
        })
        return goodsList
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
      openPrintModal() {
        this.printFlag = true
        this.printOrdInfo = deepClone(this.ordInfo)
      },
      printOrder() {
        this.printTime = new Date().getTime()
        this.printFlag = false
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
        if (this.rechargeForm.rechargeMoney == '' || this.rechargeForm.rechargeMoney == '0' || !/^\d*$/.test(this.rechargeForm.rechargeMoney) ||
          (this.rechargeForm.giveMoney != '' &&  !/^\d*$/.test(this.rechargeForm.rechargeMoney)) ) {
          this.$Message.error('请填写正确的金额')
          return
        }
        this.loading = true
        this.$http.post(apiUrl.recharge, {
          data: {phone: this.ordInfo.vip, rechargeMoney: this.rechargeForm.rechargeMoney, giveMoney: this.rechargeForm.giveMoney}
        }).then(res => {
          if (res.data.code === 200) {
            this.$Message.success(res.data.message)
            this.setOrdInfo({data: {vip:this.ordInfo.vip, balance:Number(this.row.balance) + Number(this.rechargeForm.rechargeMoney) + Number(this.rechargeForm.giveMoney)}})
            this.rechargeForm = {rechargeMoney: '', giveMoney: ''}
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
        this.rechargeForm = {rechargeMoney: '', giveMoney: ''}
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
        this.discountMoney = this.discountMoney == '' ? 0 : this.discountMoney
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
            this.setOrdInfo({data: {nun: res.data.message, user: this.userInfo.name, startTime}, roomSelected: 'place'})
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
            this.printOrdInfo = deepClone(this.ordInfo)
            this.$http.post(apiUrl.closeOrder, {
              data: {ordInfo: this.ordInfo}
            }).then(res => {
              this.setOrdInfo({data: {room: this.ordInfo.room}, type: 'ordInfo', roomSelected: 'close'})
              this.discountMoney = 0
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
              this.setOrdInfo({data: {room: this.ordInfo.room}, type: 'ordInfo', roomSelected: 'close'})
              this.discountMoney = 0
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
      openDepositModal() {
        this.depositFlag = true
        this.$http.post(apiUrl.getDeposit, {
          data: {vip: this.ordInfo.vip, nun: this.ordInfo.nun}
        }).then(res => {
          if (res.data.code === 200) {
            const depositData = res.data.message.depositData
            const takeData = res.data.message.takeData
            let takeMap = {}
            this.depositMap = {}
            this.depositList = []
            depositData.forEach(ele => {
              this.depositMap[ele.goods] = ele
            })
            if (this.ordInfo.stockGoods) {
              this.ordInfo.stockGoods.forEach(ele => {
                takeMap[ele.goods] = ele
              })
            }
            takeData.forEach(ele => {
              ele.qty = Number(ele.depositQty)
              ele.depositQty = 0
              if (takeMap[ele.goods]) {
                ele.depositQty = Number(takeMap[ele.goods].depositQty)
                ele._checked = true
              }
            })
            this.allGoodsData.forEach(ele => {
              if (this.depositMap[ele.goods]) {
                this.depositList.push(ele)
              }
            })
            this.takeGoodsData = takeData
          }
        })
      },
      depositSubmit() {
        if (this.depositTakeTab === 'deposit') {  // 寄存
          this.$http.post(apiUrl.deposit, {
            data: {vip: this.ordInfo.vip, nun: this.ordInfo.nun, goodsList: this.depositList}
          }).then(res => {
            if (res.data.code === 200) {
              this.depositFlag = false
              this.$Message.success('寄存成功')
              this.setOrdInfo({data: deepClone(this.depositList), type: 'depositGoods'})
              this.updateOrder()
            }
          })
        } else {  // 取用
          console.log('takeList', this.takeList)
          this.setOrdInfo({data: deepClone(this.takeList), type: 'stockGoods'})
          this.updateOrder()
          this.depositFlag = false
          console.log('ordInfo', this.ordInfo)
        }
      },
      depositTakeSelect(selection) {
        let goodsList = []
        selection.forEach(ele => {
          goodsList.push(ele.goods)
        })
        if (this.depositTakeTab === 'deposit') {
          this.allGoodsData.forEach(ele => {
            if (goodsList.indexOf(ele.goods) === -1) {
              delete ele._checked
            }
          })
          this.depositList = deepClone(selection)
        } else {
          this.takeGoodsData.forEach(ele => {
            if (goodsList.indexOf(ele.goods) === -1) {
              delete ele._checked
            } else {
              ele._checked = true
            }
          })
          this.takeList = deepClone(selection)
        }
        
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
    top: -18px;
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
  .modal-button {
    text-align: right;
    margin-top: 10px;
    button:first-child {
      margin-right: 10px;
    }
  }
  .drawer-footer{
    display: flex;
    button {
      width: 50%;
    }
  }
</style>
