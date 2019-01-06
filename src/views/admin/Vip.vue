<template>
  <div class="vip-container">
    <base-table
      :tableOptions="tableOptions"
      @edit="edit"
      @recharge="recharge">
    </base-table>
    <Modal
      v-model="modalFlag"
      title="充值"
      :footer-hide="true">
      <i-input v-model="rechargeMoney" suffix="logo-yen" placeholder="输入充值金额"></i-input>
      <div class="modal-button">
        <Button class="modal-cancel" @click="cancel">取消</Button>
        <Button type="primary" class="modal-ok" @click="ok">确定</Button>
      </div>
    </Modal>
    <Modal
      v-model="recordFlag"
      :title="recordTitle"
      :footer-hide="true">
      <Table :columns="recordColumns" :data="recordData" max-height="500" border size="small"></Table>
    </Modal>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import { dateFormat } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    data() {
      return {
        tableOptions: {
          tableColumns: [
            {key: 'phone', title: '手机号'},
            {key: 'balance', title: '余额', render: (h, params) => {
              return h('span', {}, params.row.balance + ' 元')
            }},
            {key: 'recentConsumeTime', title: '最近消费时间', render: (h, params) => {
              return h('span', params.row.recentConsumeTime ? dateFormat(params.row.recentConsumeTime, 'yyyy-MM-dd hh:mm') : '暂无消费')
            }},
            {key: 'recentConsumeMoney', title: '最近消费金额', render: (h, params) => {
              return h('span', params.row.recentConsumeMoney + ' 元')
            }},
            {key: 'totalTime', title: '累计消费次数', render: (h, params) => {
              return h('span', params.row.totalTime + ' 次')
            }},
            {key: 'totalMoney', title: '累计消费金额', render: (h, params) => {
              return h('span', params.row.totalMoney + ' 元')
            }},
            {key: 'record', title: '充值记录', render: (h, params) => {
              return h('span', {
                class: {'record-time': true},
                on: {
                  click: () => {
                    this.recordDetail(params)
                  }
                }
              }, params.row.record + ' 次')
            }},
            {key: 'createTime', title: '注册时间', render: (h, params) => {
              return h('span', {}, dateFormat(params.row.createTime, 'yyyy-MM-dd hh:mm'))
            }}
          ],
          formArray: [
            {key: 'phone', title: '手机号', type: 'input'},
            {key: 'verifyCode', title: '验证码', type: 'input', verifyCode: true}
          ],
          formData: {
            phone: '', verifyCode: ''
          },
          ruleValidate: {
            phone: [
              {required: true, message: '不得为空', trigger: 'blur'},
              {pattern: /^1[34578]\d{9}$/, message: '手机号码有误', trigger: 'blur'}
            ],
            verifyCode: [{required: true, message: '不得为空', trigger: 'blur'}]
          },
          vip: true,
          width: 60,
          addApi: 'registerVip',
          updApi: 'updVip',
          delApi: 'deleteVip',
          siftApi: 'getVip',
          searchFlag: true
        },
        modalFlag: false,
        rechargeMoney: '',
        loading: false,
        row: {},
        recordData: [],
        recordFlag: false,
        recordTitle: '充值记录',
        recordColumns: [
          {key: 'money', title: '充值金额(元)'},
          {key: 'time', title: '充值日期'}
        ]
      }
    },
    methods: {
      edit({type, params = {}}) {
        if (type === 'add') {
          this.tableOptions.formData = {
            phone: '', verifyCode: ''
          }
        } else if (type === 'upd') {
          this.tableOptions.formData = params.row
        }
      },
      recharge({params}) {
        this.row = params.row
        this.modalFlag = true
      },
      ok() {
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
          data: {phone: this.row.phone, rechargeMoney: this.rechargeMoney}
        }).then(res => {
          if (res.data.code === 200) {
            this.$Message.success(res.data.message)
            this.row.balance = Number(this.row.balance) + Number(this.rechargeMoney)
            this.row.record = Number(this.row.record) + 1
            this.rechargeMoney = ''
            this.modalFlag = false
          } else {
            this.$Message.error(res.data.message)
          }
          this.loading = false
        }).catch(() => {
          this.loading = false
        })
      },
      cancel() {
        this.modalFlag = false
        this.rechargeMoney = ''
      },
      recordDetail(params) {
        this.recordTitle = params.row.phone + ' 充值记录'
        this.recordFlag = true
        this.$http.post(apiUrl.getRechargeRecord, {
          data: {phone: params.row.phone}
        }).then(res => {
          if (res.data.code === 200) {
            this.recordData = res.data.message
            this.recordData.forEach(ele => {
              ele.time = dateFormat(ele.time, 'yyyy-MM-dd hh:mm')
            })
          }
        }).catch(() => {

        })
      }
    },
    components: {
      BaseTable
    }
  }
</script>

<style lang="scss" scoped>

  .modal-button {
    text-align: right;
    margin-top: 10px;
    .modal-ok {
      margin-left: 10px;
    }
  }
</style>
