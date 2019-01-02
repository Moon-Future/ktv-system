<template>
  <div class="vip-container">
    <base-table
      :tableOptions="tableOptions"
      @edit="edit">
    </base-table>
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
            {key: 'recentConsumeTime', title: '最近消费时间'},
            {key: 'recentConsumeMoney', title: '最近消费金额'},
            {key: 'totalTime', title: '累计消费次数'},
            {key: 'totalMoney', title: '累计消费金额'},
            {key: 'time', title: '充值记录'},
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
          width: 60,
          addApi: 'registerVip',
          updApi: 'updVip',
          delApi: 'deleteVip',
          siftApi: 'getVip'
        }
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
      }
    },
    components: {
      BaseTable
    }
  }
</script>

<style lang="scss" scoped>

</style>
