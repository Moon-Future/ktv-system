<template>
  <div class="package-info">
    <base-table
      :tableOptions="tableOptions"
      @edit="edit"
      @transfer="transferChange"
      @changeGoods="changeGoods">
    </base-table>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    data() {
      return {
        options: {},
        tableOptions: {
          tableColumns: [
            {key: 'name', title: '名称'},
            {key: 'goods', title: '包含商品', render: (h, params) => {
              let array = []
              params.row.goods.forEach(ele => {
                array.push(h('Tag', {props: {color: 'primary'}}, `${ele.name}(${ele.qty}${ele.unitm})`))
              })
              return h('div', {}, array)
            }},
            {key: 'descr', title: '描述', render: (h, params) => {
              const descr = params.row.descr.split('\n')
              let array = []
              descr.forEach(ele => {
                array.push(h('span', {}, ele), h('br'))
              })
              return h('div', {}, array)
            }},
            {key: 'price', title: '价格', render: (h, params) => {
              return h('span', {}, params.row.price + ' 元')
            }}
          ],
          formArray: [
            {key: 'name', title: '名称', type: 'input'},
            {key: 'goods', title: '商品', type: 'checkbox', num: true, options: []},
            {key: 'group', title: '多选一', type: 'transfer'},
            {key1: 'price1', key2: 'price2', key3: 'type', title: '价格', type: 'checkboxInput'},
            {key: 'descr', title: '描述', type: 'textarea'}
          ],
          formData: {
            type: [], name: '', descr: '', price1: 0, price2: 0, goods: [], goodsQty: {}, group: []
          },
          transferData: [],
          ruleValidate: {
            name: [{required: true, message: '不得为空', trigger: 'blur'}],
            descr: [{required: true, message: '不得为空', trigger: 'blur'}],
            price1: [
              {required: true, message: '不得为空', trigger: 'blur'},
              {pattern: /^\d+(\.{0,1}\d{1,2}){0,1}$/, message: '必须为正数，最多两位小数', trigger: 'blur'}
            ]
          },
          addApi: 'insertPackage',
          updApi: 'updPackage',
          delApi: 'deletePackage',
          siftApi: 'getPackage'
        }
      }
    },
    methods: {
      transferChange({targetKeys}) {
        this.$set(this.tableOptions.formData, 'group', targetKeys)
      },
      changeGoods({transferData}) {
        this.tableOptions.transferData = transferData
      },
      getOptions() {
        return new Promise((resolve, reject) => {
          this.$http.post(apiUrl.getOptions, {
            data: {goods: true, roomType: true}
          }).then(res => {
            if (res.data.code === 200) {
              resolve(res.data.message)
            } else {
              reject()
            }
          })
        })
      },
      async edit({type, params = {}}) {
        if (!this.hasGet) {
          this.options = await this.getOptions()
          this.hasGet = true
          this.tableOptions.formArray.splice(1, 1, {key: 'goods', title: '商品', type: 'checkbox', num: true, options: this.options.goodsOptions})
          this.options.goodsOptions.forEach(ele => {
            this.tableOptions.formData['goodsQty'][ele.id] = 1
          })
        }
        if (type === 'add') {
          this.tableOptions.formData = {
            type: [], name: '', descr: '', price1: 0, price2: 0, goods: [], goodsQty: {}, group: []
          }
          this.options.goodsOptions.forEach(ele => {
            this.tableOptions.formData['goodsQty'][ele.id] = 1
          })
        } else if (type === 'upd') {
          const row = params.row
          let obj = {
            type: row.type + '', 
            name: row.name, 
            descr: row.descr,
            price: row.price + '', 
            goods: [],
            goodsQty: {},
            uuid: row.uuid,
            createTime: row.createTime
          }
          row.goods.forEach(ele => {
            obj.goods.push(ele.id)
            obj.goodsQty[ele.id] = ele.qty
          })
          this.options.goodsOptions.forEach(ele => {
            if (obj.goods.indexOf(ele.id) === -1) {
              obj.goodsQty[ele.id] = 1
            }
          })
          this.tableOptions.formData = obj
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
