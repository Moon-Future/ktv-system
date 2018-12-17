<template>
  <div class="room-info">
    <base-table
      :tableOptions="tableOptions"
      @edit="edit">
    </base-table>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  export default {
    data() {
      return {
        tableOptions: {
          tableColumns: [
            {key: 'name', title: '名称'},
            {key: 'sign', title: '符号'}
          ],
          formArray: [
            {key: 'name', title: '名称', type: 'input'},
            {key: 'sign', title: '符号', type: 'input'}
          ],
          formData: {
            name: '', sign: ''
          },
          ruleValidate: {
            name: [{required: true, message: '*号为必填项', trigger: 'blur'}]
          },
          addApi: 'insertUnit',
          updApi: 'updUnit',
          delApi: 'deleteUnit',
          siftApi: 'getUnit'
        }
      }
    },
    methods: {
      edit({type, params = {}}) {
        if (type === 'add') {
          this.tableOptions.formData = {
            name: '', sign: ''
          }
        } else if (type === 'upd') {
          this.tableOptions.formData = params.row
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
