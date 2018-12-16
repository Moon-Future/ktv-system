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
            {prop: 'no', label: '编号'},
            {prop: 'descr', label: '描述'},
            {prop: 'expense', label: '资费'},
            {prop: 'package', label: '套餐'}
          ],
          addField: [
            {prop: 'name', label: '名称', type: 'input'},
            {prop: 'no', label: '编号', type: 'input'},
            {prop: 'descr', label: '描述', type: 'textarea'},
            {prop: 'expense', label: '资费', type: 'input'},
            {prop: 'package', label: '套餐', type: 'checkbox'}
          ],
          siftData: [
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
            {name: '大包', no: '1', descr: '一堆描述', package: '套餐一'},
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
