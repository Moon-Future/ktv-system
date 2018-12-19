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
  import apiUrl from '@/serviceAPI.config.js'
import { resolve, reject } from 'q';
  export default {
    data() {
      return {
        hasGet: false,
        options: {},
        tableOptions: {
          tableColumns: [
            {key: 'name', title: '名称'},
            {key: 'content', title: '内容'},
            {key: 'descr', title: '描述'},
            {key: 'price', title: '总价'}
          ],
          formArray: [
            {key: 'type', title: '类型', type: 'radio', options: [{label:'1', name:'阳光挡'}, {label:'2', name:'黄金档'}]},
            {key: 'name', title: '名称', type: 'input'},
            {key: 'goods', title: '商品', type: 'packCheckbox', options: []},
            {key: 'room', title: '包间', type: 'switchSelect', key2: 'roomType', hide2: true, options: []},
            {key: 'time', title: '欢唱', type: 'input'},
            {key: 'price', title: '价格', type: 'input'},
            {key: 'descr', title: '描述', type: 'textarea'}
          ],
          formData: {
            type: '1', name: '', descr: '', price: '', goods: '', room: '', time: '', roomType: '', goodsQty: {}
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
          siftApi: 'getUnit'
        }
      }
    },
    methods: {
      getOptions() {
        return new Promise((resolve, reject) => {
          this.$http.post(apiUrl.getOptions, {
            data: {goods: true, roomType: true}
          })
            .then(res => {
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
          this.tableOptions.formData.roomType = ''
        }
      },
      async edit({type, params = {}}) {
        if (!this.hasGet) {
          this.options = await this.getOptions()
          this.hasGet = true
          this.tableOptions.formArray.splice(2, 1, {key: 'goods', title: '商品', type: 'checkbox', options: this.options.goodsOptions})
          this.tableOptions.formArray.splice(3, 1, {key: 'room', title: '包间', type: 'switchSelect', key2: 'roomType', hide2: true, options: this.options.roomTypeOptions})
          this.options.goodsOptions.forEach(ele => {
            this.tableOptions.formData['goodsQty'][ele.id] = 1
          })
        }
        if (type === 'add') {
          
        } else if (type === 'upd') {

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
