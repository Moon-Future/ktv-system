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
          tableColumns: [
            {key: 'name', title: '名称'},
            {key: 'content', title: '内容'},
            {key: 'descr', title: '描述'},
            {key: 'price', title: '总价'}
          ],
          siftApi: 'getUnit'
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
