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
          siftField: [
            {prop: 'name', label: '名称'},
            {prop: 'unitPrice', label: '单价'},
            {prop: 'unit', label: '单位'}
          ],
          addField: [
            {prop: 'name', label: '名称', type: 'input'},
            {prop: 'no', label: '编号', type: 'input'},
            {prop: 'descr', label: '描述', type: 'textarea'},
          ],
          siftData: [
            {name: '香烟', unitPrice: '20 元', unit: '包'},
            {name: '香烟', unitPrice: '20 元', unit: '包'},
            {name: '香烟', unitPrice: '20 元', unit: '包'},
            {name: '香烟', unitPrice: '20 元', unit: '包'},
            {name: '香烟', unitPrice: '20 元', unit: '包'},
          ],
          addData: {name: '', no: '', descr: '', expense: '', package: []}
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
