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
            {key: 'name', title: '名称'}
          ],
          formArray: [
            {key: 'name', title: '名称', type: 'input'}
          ],
          formData: {
            name: ''
          },
          ruleValidate: {
            name: [{required: true, message: '不得为空', trigger: 'blur'}]
          },
          width: 50,
          addApi: 'insertRoomType',
          updApi: 'updRoomType',
          delApi: 'deleteRoomType',
          siftApi: 'getRoomType'
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
