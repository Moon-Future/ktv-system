<template>
  <div class="room-info">
    <base-table
      ref="baseTable"
      :tableOptions="tableOptions"
      @edit="edit">
    </base-table>
    <Modal
      v-model="recordFlag"
      :title="recordTitle"
      width="800"
      :footer-hide="true">
      <Table :columns="recordColumns" :data="recordData" max-height="500" border size="small"></Table>
    </Modal>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import { dateFormat } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
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
            {key: 'price', title: '单价', render: (h, params) => {
              return h('span', {}, params.row.price + ' 元')
            }},
            {key: 'unitm', title: '单位'},
            {key: 'descr', title: '描述'},
            {key: 'qty', title: '库存'},
            {key: 'record', title: '入库记录', render: (h, params) => {
              return h('span', {
                class: {'record-time': true},
                on: {
                  click: () => {
                    this.params = params
                    this.recordDetail(params)
                  }
                }
              }, params.row.record + ' 次')
            }},
          ],
          formArray: [
            {key: 'name', title: '名称', type: 'input'},
            {key: 'price', title: '价格', type: 'input'},
            {key: 'unit', title: '单位', type: 'select', options: []},
            {key: 'descr', title: '描述', type: 'textarea'},
          ],
          formData: {
            name: '', picture: '', price: '', vipDiscount: false, discount: '', unit: '', descr: ''
          },
          ruleValidate: {
            name: [{required: true, message: '不得为空', trigger: 'blur'}],
            unit: [{required: true, message: '不得为空', trigger: 'blur'}],
            price: [
              {required: true, message: '不得为空', trigger: 'blur'},
              {pattern: /^\d+(\.{0,1}\d{1,2}){0,1}$/, message: '必须为正数，最多两位小数', trigger: 'blur'}
            ],
            discount: [
              {validator: validateDiscount, trigger: 'blur'}
            ]
          },
          width: 50,
          goods: true,
          addApi: 'insertGoods',
          updApi: 'updGoods',
          delApi: 'deleteGoods',
          siftApi: 'getGoods'
        },
        recordFlag: false,
        recordTitle: '入库记录',
        recordColumns: [
          {key: 'name', title: '名称'},
          {key: 'qty', title: '入库数量'},
          {key: 'time', title: '入库日期', render: (h, params) => {
            return h('span', params.row.time)
          }},
          {key: 'user', title: '操作人员'},
          {key: 'operate', title: '操作', render: (h, params) => {
            return h('span', {
              class: {'operate-item' : true},
              on: {
                click: () => {
                  this.deleteStock(params)
                }
              }
            }, '删除')
          }},
        ],
        recordData: [],
        params: ''
      }
    },
    methods: {
      getUnit(params = {}) {
        return new Promise((resolve, reject) => {
          this.$http.post(apiUrl.getUnit, {
            data: params
          }).then(res => {
            if (res.data.code === 200) {
              let options = res.data.message
              options.forEach(ele => {
                ele.value = ele.id + ''
                ele.label = ele.name
              })
              this.tableOptions.formArray.splice(2, 1, {key: 'unit', title: '单位', type: 'select', options})
              resolve()
            } else {
              reject()
            }
          })
        })
      },
      recordDetail(params) {
        this.recordTitle = params.row.name + ' 入库记录'
        this.recordFlag = true
        if (params.row.record == 0) {
          this.recordData = []
          return
        }
        this.$http.post(apiUrl.getStock, {
          data: {id: params.row.id}
        }).then(res => {
          if (res.data.code === 200) {
            this.recordData = res.data.message
            this.recordData.forEach(ele => {
              ele.time = dateFormat(ele.time, 'yyyy-MM-dd hh:mm')
            })
          }
        })
      },
      deleteStock(params) {
        this.$Modal.confirm({
          title: '确认删除',
          onOk: () => {
            this.$http.post(apiUrl.deleteStock, {
              data: {params: params.row}
            }).then(res => {
              this.recordData.splice(params.index, 1)
              this.$set(this.params.row, 'record', this.params.row.record - 1)
              this.$set(this.params.row, 'qty', this.params.row.qty - params.row.qty)
            })
          }
        })
      },
      async edit({type, params = {}}) {
        if (!this.hasGet) {
          await this.getUnit()
          this.hasGet = true
        }
        if (type === 'add') {
          this.tableOptions.formData = {
            name: '', picture: '', price: '', vipDiscount: false, discount: '', unit: '', descr: ''
          }
        } else if (type === 'upd') {
          this.tableOptions.formData = params.row
          this.tableOptions.formData.price = this.tableOptions.formData.price + ''
          this.tableOptions.formData.unit = this.tableOptions.formData.unit + ''
        }
      },
    },
    components: {
      BaseTable
    }
  }
</script>

<style lang="scss" scoped>

</style>
