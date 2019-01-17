<template>
  <div class="report-container">
    <div class="condition-wrapper">
      <Button :class="activeIndex === i ? 'active' : ''" size="small" v-for="(item, i) in btnList" @click="getReportData(item.key, i)">{{ item.title }}</Button>  
      <DatePicker type="daterange" placement="bottom-end" placeholder="选择日期" style="width: 200px;font-size: 14px" @on-change="getReportData"></DatePicker>
    </div>
    <div class="report-wrapper">
      <div class="total-wrapper">
        <div class="item-num" v-for="(item, i) in totalList" :key="i">
          <p class="title">{{ item.title }}</p>
          <p class="num">{{ totalData[item.key] }}</p>
        </div>
      </div>
      <div class="">
        <Col span="12">
          <DatePicker type="date" placeholder="Select date" style="width: 200px"></DatePicker>
        </Col>
        <Col span="12">
            <DatePicker type="daterange" placement="bottom-end" placeholder="Select date" style="width: 200px"></DatePicker>
        </Col>
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
        btnList: [
          {key: 'today', title: '今天'},
          {key: 'all', title: '所有'},
          {key: 'yesterday', title: '昨天'},
          {key: 'week', title: '最近一周'},
          {key: 'month', title: '最近一月'},
          {key: 'quarter', title: '最近三月'},
          {key: 'year', title: '最近一年'}
        ],
        reportData: [],
        activeIndex: -1
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
        {key: 'total', title: '订单数（单）'},
        {key: 'price', title: '营收（元）'}
      ]
      this.getReportData('today', 0)
    },
    methods: {
      getReportData(key, index) {
        this.activeIndex = index
        const today = this.getToday()
        let timeRange = []
        let type = key === 'all' ? 'all' : 'report'
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
          data: {startTime: timeRange[0], endTime: timeRange[1], type: type}
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
      &.active {
        background: $color-blue;
        color: $color-white;
      }
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
      text-align: left;
      .title {
        padding-bottom: 5px;
        font-size: 14px;
      }
      .num {
        font-size: 32px;
        font-weight: bold;
        color: $color-red;
      }
    }
  }
</style>
