<template>
  <div class="report-container">
    <div class="condition-wrapper">
      <Button type="primary" size="small" @click="getReportData('today')">今天</Button>
      <Button size="small" @click="getReportData('yesterday')">昨天</Button>
      <Button size="small" @click="getReportData('week')">最近一周</Button>
      <Button size="small" @click="getReportData('month')">最近一月</Button>
      <Button size="small" @click="getReportData('quarter')">最近三月</Button>
      <Button size="small" @click="getReportData('year')">最近一年</Button>
      <DatePicker type="daterange" placement="bottom-end" placeholder="选择日期" style="width: 200px;font-size: 14px" @on-change="getReportData"></DatePicker>
    </div>
    <div class="report-wrapper">
      <div class="total-wrapper">
        <div class="item-num" v-for="(item, i) in totalList" :key="i">
          <h1>{{ item.title }}</h1>
          <div class="num-wrapper">
            <span>{{ totalData[item.key] }}</span>
            <span>{{ item.unitm }}</span>
          </div>
        </div>
      </div>
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
        reportData: []
      }
    },
    computed: {
      totalData() {
        let data = {}
        data.total = this.reportData.length
        data.price = 0
        this.reportData.forEach(item => {
          data.price += Number(item.totalPrice) - Number(item.discount || 0)
        })
        return data
      }
    },
    created() {
      this.totalList = [
        {key: 'total', title: '订单数', unitm: '单'},
        {key: 'price', title: '营收', unitm: '元'}
      ]
    },
    methods: {
      getReportData(key) {
        const today = this.getToday()
        let timeRange = []
        switch(key) {
          case 'today':
            timeRange = [today, today + 3600 * 1000 * 24]
            break
          case 'yesterday':
            timeRange = [today - 3600 * 1000 * 24, today]
            break
          case 'week':
            timeRange = [today - 3600 * 1000 * 24 * 7, today + 3600 * 1000 * 24]
            break
          case 'month':
            timeRange = [today - 3600 * 1000 * 24 * 30, today + 3600 * 1000 * 24]
            break
          case 'quarter':
            timeRange = [today - 3600 * 1000 * 24 * 90, today + 3600 * 1000 * 24]
            break
          case 'year':
            timeRange = [today - 3600 * 1000 * 24 * 360, today + 3600 * 1000 * 24]
            break
          default:
            timeRange = [new Date(key[0]).getTime() - 3600 * 1000 * 8, new Date(key[1]).getTime() + 3600 * 1000 * 16]
            break;
        }
        this.$http.post(apiUrl.getOrderHistory, {
          data: {startTime: timeRange[0], endTime: timeRange[1], type: 'report'}
        }).then(res => {
          if (res.data.code === 200) {
            this.reportData = res.data.message
          } else {
            this.$Message.error(res.data.message)
            this.reportData = []
          }
        })
      },
      getToday() {
        let today = new Date()
        today.setMilliseconds(0)
        today.setSeconds(0)
        today.setMinutes(0)
        today.setHours(0)
        return today.getTime()
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

  .report-wrapper {
    margin-top: 10px;
  }

  .total-wrapper {
    padding: 10px 0;
    background: $color-white;
    display: flex;
    .item-num {
      padding: 10px 20px;
    }
  }
</style>
