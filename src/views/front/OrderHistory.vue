<template>
  <div class="history-container">
    <div class="table-wrapper">
      <base-table
        :stripe="false"
        :highlight="true"
        :tableOptions="tableOptions"
        @selectRow="selectRow">
      </base-table>
    </div>
    <div class="order-wrapper">
      <print ref="printWrapper" :ordInfo="ordInfo" :btnShow="btnShow" :printTime="printTime" @printOrder="printOrder"></print>
    </div>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import Print from '@/components/front/Print'
  import { dateFormat } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    name: 'ktv',
    data() {
      return {
        tableOptions: {
          tableColumns: [
            {key: 'room', title: '包间号'},
            {key: 'vip', title: '会员'},
            {key: 'startTime', title: '开始时间', render: (h, params) => {
              return h('span', dateFormat(params.row.startTime, 'yyyy-MM-dd hh:mm'))
            }},
            {key: 'endTime', title: '开始时间', render: (h, params) => {
              return h('span', dateFormat(params.row.endTime, 'yyyy-MM-dd hh:mm'))
            }},
            {key: 'time', title: '相对时间', render: (h, params) => {
              return h('Time', {props: {time: params.row.endTime}})
            }}
          ],
          orderHistory: true,
          siftApi: 'getOrderHistory',
          onlySift: true
        },
        ordInfo: {},
        btnShow: false,
        printTime: new Date().getTime()
      }
    },
    methods: {
      selectRow({currentRow}) {
        this.ordInfo = currentRow
        this.btnShow = true
        this.printTime = new Date().getTime()
      },
      printOrder() {
        this.printTime = new Date().getTime()
        this.btnShow = false
        this.$nextTick(() => {
          setTimeout(() => {
            const printHtml = this.$refs.printWrapper.$el.innerHTML
            const app = document.getElementById('app')
            const printPanel = document.getElementById('printPanel')
            app.style.display = 'none'
            printPanel.innerHTML = printHtml
            window.print()
            printPanel.innerHTML = ''
            app.style.display = 'block'
            this.btnShow = true
          }, 50)
        })
      }
    },
    components: {
      BaseTable,
      Print
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .history-container {
    display: flex;
    .table-wrapper {
      width: 70%;
    }
    .order-wrapper {
      width: 30%;
    }
  }
</style>

