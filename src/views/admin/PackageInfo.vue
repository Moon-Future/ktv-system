<template>
  <div class="package-info">
    <base-table
      :tableOptions="tableOptions"
      @changeSwitch="changeSwitch"
      @edit="edit">
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
            {key: 'type', title: '类型', render: (h, params) => {
              return h('span', {}, params.row.type === 1 ? '阳光档' : '黄金档')
            }},
            {key: 'name', title: '名称'},
            {key: 'goods', title: '包含商品', render: (h, params) => {
              let array = []
              params.row.goods.forEach(ele => {
                array.push(h('Tag', {props: {color: 'primary'}}, `${ele.name}(${ele.qty}${ele.unitm})`))
              })
              return h('div', {}, array)
            }},
            {key: 'room', title: '包间', render: (h, params) => {
              const row = params.row
              if (row.room) {
                return h('Tag', {props: {color: 'success'}}, row.roomTypem)
              } else {
                return h('Tag', {props: {color: 'warning'}}, '不含包间')
              }
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
            {key: 'type', title: '类型', type: 'radio', options: [{label:'1', name:'阳光档'}, {label:'2', name:'黄金档'}]},
            {key: 'name', title: '名称', type: 'input'},
            {key: 'goods', title: '商品', type: 'checkbox', num: true, options: []},
            {key: 'room', title: '包间', type: 'switchSelect', key2: 'roomType', hide2: true, options: []},
            {key: 'price', title: '价格', type: 'input'},
            {key: 'descr', title: '描述', type: 'textarea'}
          ],
          formData: {
            type: '1', name: '', descr: '', price: '', goods: [], room: false, time: '', roomType: '', goodsQty: {}
          },
          ruleValidate: {
            name: [{required: true, message: '不得为空', trigger: 'blur'}],
            descr: [{required: true, message: '不得为空', trigger: 'blur'}],
            price: [
              {required: true, message: '不得为空', trigger: 'blur'},
              {pattern: /^\d+(\.{0,1}\d{1,2}){0,1}$/, message: '必须为正数，最多两位小数', trigger: 'blur'}
            ],
            roomType: [{required: true, message: '不得为空', trigger: 'blur'}]
          },
          addApi: 'insertPackage',
          updApi: 'updPackage',
          delApi: 'deletePackage',
          siftApi: 'getPackage'
        }
      }
    },
    methods: {
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
      changeSwitch(status) {
        if (status) {
          this.tableOptions.formArray.splice(3, 1, {key: 'room', title: '包间', type: 'switchSelect', key2: 'roomType', options: this.options.roomTypeOptions})
        } else {
          this.tableOptions.formArray.splice(3, 1, {key: 'room', title: '包间', type: 'switchSelect', key2: 'roomType', hide2: true, options: this.options.roomTypeOptions})
        }
      },
      async edit({type, params = {}}) {
        if (!this.hasGet) {
          this.options = await this.getOptions()
          this.hasGet = true
          this.tableOptions.formArray.splice(2, 1, {key: 'goods', title: '商品', type: 'checkbox', num: true, options: this.options.goodsOptions})
          this.tableOptions.formArray.splice(3, 1, {key: 'room', title: '包间', type: 'switchSelect', key2: 'roomType', hide2: true, options: this.options.roomTypeOptions})
          this.options.goodsOptions.forEach(ele => {
            this.tableOptions.formData['goodsQty'][ele.id] = 1
          })
        }
        if (type === 'add') {
          this.tableOptions.formData = {
            type: '1', name: '', descr: '', price: '', goods: [], room: false, time: '', roomType: '', goodsQty: {}
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
            room: row.room ? true : false, 
            roomType: row.roomType + '',
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
        this.changeSwitch(this.tableOptions.formData.room)
      }
    },
    components: {
      BaseTable
    }
  }
</script>

<style lang="scss" scoped>

</style>
