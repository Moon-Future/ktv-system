<template>
  <div class="package-info">
    <base-table
      :tableOptions="tableOptions">
    </base-table>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  export default {
    data() {
      return {
        tableOptions: {
          formArray: [
            {key: 'name', title: '名称', type: 'input'},
            {key: 'no', title: '编号', type: 'input'},
            {key: 'descr', title: '描述', type: 'textarea'},
            {key: 'price', title: '资费', type: 'input'},
            {key: 'package', title: '套餐', type: 'checkbox'}
          ],
          formData: {
            name: '', no: '', descr: '', price: '', package: ''
          },
          tableData: [
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
          ],
          tableColumns: [
            {key: 'name', title: '名称'},
            {key: 'content', title: '内容'},
            {key: 'descr', title: '描述'},
            {key: 'price', title: '总价'}
          ]
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
