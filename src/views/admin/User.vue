<template>
  <div class="vip-container">
    <base-table
      :tableOptions="tableOptions">
    </base-table>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import { dateFormat } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    data() {
      return {
        tableOptions: {
          tableColumns: [
            {key: 'name', title: '姓名'},
            {key: 'account', title: '账号'},
            {key: 'type', title: '职责', render: (h, params) => {
              return h('span', params.row.type == '0' ? '收银员' : '管理员')
            }}
          ],
          user: true,
          width: 60,
          delApi: 'deleteUser',
          siftApi: 'getUser',
          onlySift: true
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
