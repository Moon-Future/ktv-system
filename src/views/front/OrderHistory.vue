<template>
  <div class="history-container" :class="mobileFlag ? 'mobileFlag-history-container' : ''">
    <div class="table-wrapper">
      <base-table
        :stripe="false"
        :highlight="true"
        :tableOptions="tableOptions"
        :pageFlag="pageFlag"
        :mobileFlag="mobileFlag"
        @selectRow="selectRow"
        @delete="deleteRow">
      </base-table>
    </div>
    <div class="order-wrapper" v-show="!mobileFlag || mobileBillShow === 2">
      <div class="top-title">
        <h2>占位</h2>
      </div>
      <print ref="printWrapper" :ordInfo="ordInfo" :btnShow="btnShow" :printTime="printTime" @printOrder="printOrder"></print>
    </div>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import Print from '@/components/front/Print'
  import { dateFormat } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters } from 'vuex'
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
            {key: 'endTime', title: '结束时间', render: (h, params) => {
              return h('span', dateFormat(params.row.endTime, 'yyyy-MM-dd hh:mm'))
            }},
            {key: 'time', title: '相对时间', render: (h, params) => {
              return h('Time', {props: {time: params.row.endTime}})
            }}
          ],
          orderHistory: true,
          siftApi: 'getOrderHistory',
          delApi: 'deleteOrder',
          onlySift: true
        },
        pageFlag: true,
        ordInfo: {},
        btnShow: false,
        printTime: new Date().getTime()
      }
    },
    computed: {
      ...mapGetters(['mobileFlag', 'mobileBillShow'])
    },
    methods: {
      selectRow({currentRow}) {
        this.ordInfo = currentRow
        this.btnShow = true
        this.printTime = new Date().getTime()
      },
      deleteRow({row}) {
        if (row.nun === this.ordInfo.nun) {
          this.ordInfo = {}
          this.btnShow = false
        }
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
      width: 68%;
      margin-right: 1%;
    }
    .order-wrapper {
      width: 30%;
    }
  }

  .mobileFlag-history-container {
    .table-wrapper {
      width: 100%;
    }
    .order-wrapper {
      width: 100%;
      position: fixed;
      top: 63px;
      bottom: 0;
      overflow: auto;
    }
  }

  .top-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 14px;
    margin-bottom: 10px;
    padding: 10px 0 0 10px;
    font-size: 16px;
    h2 {
      visibility: hidden;
    }
  }
</style>

