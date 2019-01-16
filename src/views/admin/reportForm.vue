<template>
  <div class="report-container">
    <div class="condition-wrapper">
      <Button type="primary" size="small">今天</Button>
      <Button size="small">昨天</Button>
      <Button size="small">最近一周</Button>
      <Button size="small">最近一月</Button>
      <Button size="small">最近一年</Button>
    </div>
    <div class="today-wrapper">
      
    </div>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import { dateFormat } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    data() {
      return {
        reportData: {}
      }
    },
    created() {

    },
    methods: {
      getReportData() {

      }
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .condition-wrapper {
    display: flex;
    button {
      margin-right: 20px;
    }
  }
</style>
