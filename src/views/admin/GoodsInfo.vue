<template>
  <div class="room-info">
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
            // {name: '香烟', unitPrice: '20 元', unit: '包'},
            // {name: '香烟', unitPrice: '20 元', unit: '包'},
            // {name: '香烟', unitPrice: '20 元', unit: '包'},
            // {name: '香烟', unitPrice: '20 元', unit: '包'},
            // {name: '香烟', unitPrice: '20 元', unit: '包'},
          ],
          tableColumns: [
            {key: 'name', title: '名称'},
            {key: 'unitPrice', title: '单价'},
            {key: 'unit', title: '单位'}
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
