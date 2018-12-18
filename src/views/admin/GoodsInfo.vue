<template>
  <div class="room-info">
    <base-table
      :tableOptions="tableOptions"
      @changeSwitch="changeSwitch"
      @edit="edit">
    </base-table>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import apiUrl from '@/serviceAPI.config.js'
  const validateDiscount = (rule, value, callback) => {
    if (!/^\d+(\.{0,1}\d{1,2}){0,1}$/.test(value) || value < 0 || value > 1) {
      callback(new Error('只能为 0 ~ 1 的数字且最多两位小数'));
    } else {
      callback();
    }
  }
  export default {
    data() {
      return {
        tableOptions: {
          tableColumns: [
            {key: 'name', title: '名称'},
            {key: 'price', title: '单价'},
            {key: 'unitm', title: '单位'},
            {key: 'descr', title: '描述'},
            {
              key: 'vipDiscount',
              title: '会员折扣',
              render: (h, params) => {
                return h('i-switch', {
                  props: {disabled: 'disabled', value: params.row.vipDiscount}
                })
              }
            },
            {key: 'discount', title: '折扣'}
          ],
          formArray: [
            {key: 'name', title: '名称', type: 'input'},
            {key: 'price', title: '价格', type: 'input'},
            {key: 'unit', title: '单位', type: 'select', options: []},
            {key: 'descr', title: '描述', type: 'textarea'},
            {key: 'vipDiscount', title: '开启会员折扣', type: 'switch'},
            {key: 'discount', title: '会员折扣', type: 'input', hide: true}
          ],
          formData: {
            name: '', picture: '', price: '', vipDiscount: false, discount: '', unit: '', descr: ''
          },
          ruleValidate: {
            name: [{required: true, message: '不得为空', trigger: 'blur'}],
            // unit: [{required: true, message: '请选择一个单位', trigger: 'blur'}],
            price: [
              {required: true, message: '不得为空', trigger: 'blur'},
              {pattern: /^\d+(\.{0,1}\d{1,2}){0,1}$/, message: '必须为正数，最多两位小数', trigger: 'blur'}
            ],
            discount: [
              {validator: validateDiscount, trigger: 'blur'}
            ]
          },
          width: 90,
          addApi: 'insertGoods',
          updApi: 'updGoods',
          delApi: 'deleteGoods',
          siftApi: 'getGoods'
        }
      }
    },
    created() {
      this.getUnit()
    },
    methods: {
      getUnit(params = {}) {
        this.$http.post(apiUrl.getUnit, {
          data: params
        }).then(res => {
          if (res.data.code === 200) {
            let options = res.data.message
            options.forEach(ele => {
              ele.value = ele.id
              ele.label = ele.name
            })
            this.tableOptions.formArray.splice(2, 1, {key: 'unit', title: '单位', type: 'select', options})
          }
        })
      },
      changeSwitch(status) {
        if (status) {
          this.tableOptions.formArray.splice(5, 1, {key: 'discount', title: '会员折扣', type: 'input'})
        } else {
          this.tableOptions.formArray.splice(5, 1, {key: 'discount', title: '会员折扣', type: 'input', hide: true})
          this.tableOptions.formData.discount = ''
        }
      },
      edit({type, params = {}}) {
        if (type === 'add') {
          this.tableOptions.formData = {
            name: '', picture: '', price: '', vipDiscount: false, discount: '', unit: '', descr: ''
          }
          this.changeSwitch(false)
        } else if (type === 'upd') {
          this.tableOptions.formData = params.row
          if (params.row.vipDiscount) {
            this.changeSwitch(true)
          } else {
            this.changeSwitch(false)
          }
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
