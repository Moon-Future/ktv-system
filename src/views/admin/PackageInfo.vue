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
  import { packageType } from '@/common/js/const'
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
              let radios = []
              let grp = params.row.grp &&  params.row.grp.split(',') || []
              params.row.goods.forEach(ele => {
                if (grp.indexOf(ele.id + '') === -1) {
                  array.push(h('Tag', {props: {color: 'primary'}}, `${ele.name}(${ele.qty}${ele.unitm})`))
                } else {
                  radios.push(h('Radio', {props: {label:ele.id}}, `${ele.name}(${ele.qty}${ele.unitm})`))
                }
              })
              array.push(h('RadioGroup', radios))
              return h('div', {}, array)
            }},
            {key: 'descr', title: '描述', render: (h, params) => {
              const descr = params.row.descr.split('\n')
              let array = []
              descr.forEach(ele => {
                array.push(h('span', {}, ele), h('br'))
              })
              return h('div', {style: {'line-height': '20px'}}, array)
            }},
            {key: 'price', title: '价格', render: (h, params) => {
              const row = params.row
              let array = []
              let array1 = []
              let array2 = []
              if (row.type1 == '1') {
                array.push(h('Tag', {props: {color: 'purple'}}, `阳光档 ${row.price1} 元`))
              }
              if (row.type2 == '1') {
                array.push(h('Tag', {props: {color: 'volcano'}}, `黄金档 ${row.price2} 元`))
              }
              return h('div', {}, array)
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
            name: '', descr: '', type: [], price1: 0, price2: 0, goods: [], goodsQty: {}, group: []
          },
          transferData: [],
          ruleValidate: {
            name: [{required: true, message: '不得为空', trigger: 'blur'}],
            descr: [{required: true, message: '不得为空', trigger: 'blur'}]
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
          this.$set(this.tableOptions.formArray[1], 'options', this.options.goodsOptions)
          this.options.goodsOptions.forEach(ele => {
            this.tableOptions.formData['goodsQty'][ele.id] = 1
          })
        }
        this.tableOptions.transferData = []
        if (type === 'add') {
          this.tableOptions.formData = {
            name: '', descr: '', type: [], price1: 0, price2: 0, goods: [], goodsQty: {}, group: []
          }
          this.options.goodsOptions.forEach(ele => {
            this.tableOptions.formData['goodsQty'][ele.id] = 1
          })
        } else if (type === 'upd') {
          const row = params.row
          let type = []
          if (row.type1 != 0) {
            type.push('1')
          }
          if (row.type2 != 0) {
            type.push('2')
          }
          let obj = {
            name: row.name,
            descr: row.descr,
            type: type,
            price1: row.price1,
            price2: row.price2,
            goods: [],
            goodsQty: {},
            group: row.grp && row.grp.split(',') || [],
            uuid: row.uuid,
            createTime: row.createTime
          }
          row.goods.forEach(ele => {
            obj.goods.push(ele.id)
            obj.goodsQty[ele.id] = ele.qty
            this.tableOptions.transferData.push({key:ele.id + '', label:ele.name})
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
