<template>
  <div class="report-container">
    <div class="condition-wrapper">
      <Button :class="activeIndex === i ? 'active' : ''" size="small" v-for="(item, i) in btnList" @click="filterReportData(item.key, i)">{{ item.title }}</Button>  
      <DatePicker type="daterange" placement="bottom-end" placeholder="选择日期" style="width: 200px;font-size: 14px" @on-change="getReportData"></DatePicker>
    </div>
    <div class="report-wrapper">
      <div class="report-item total-wrapper">
        <div class="item-num" v-for="(item, i) in totalList" :key="i">
          <p class="title">{{ item.title }}</p>
          <p class="num">{{ totalData[item.key] }}</p>
        </div>
      </div>
      <div class="report-item goods-report">
        <div ref="goodsReport" style="height:300px;"></div>
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
        orderList: [],
        goodsList: [],
        packageList: [],

        reportData: [],
        formatData: [],
        activeIndex: -1
      }
    },
    computed: {
      totalData() {
        let data = {}
        data.total = this.formatData.length
        data.price = 0
        this.formatData.forEach(item => {
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
    },
    mounted() {
      this.getReportData()
    },
    methods: {
      getReportData() {
        this.$http.post(apiUrl.getOrderHistory, {
          data: {type: 'report'}
        }).then(res => {
          if (res.data.code === 200) {
            const message = res.data.message
            this.orderList = message.orderList
            this.goodsList = message.goodsList
            this.packageList = message.packageList
            console.log('goodsList', this.goodsList)
            // this.filterReportData('today', 0)
          } else {
            this.$Message.error(res.data.message)
            this.orderList = []
            this.goodsList = []
            this.packageList = []
            this.formatData = []
          }
          this.goodsECharts()
        })
      },
      filterReportData(key, index) {
        this.activeIndex = index
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
        if (key === 'all') {
          this.formatData = this.reportData
        } else {
          this.formatData = []
          this.reportData.forEach(ele => {
            if (ele.startTime >= timeRange[0] && ele.startTime <= timeRange[1]) {
              this.formatData.push(ele)
            }
          })
        }
        this.formatData.sort((a, b) => {
          return a.startTime - b.startTime
        })
      },
      goodsECharts() {
        const myChart = this.$echarts.init(this.$refs.goodsReport)
        let titleData = []
        this.goodsList.forEach(ele => {
          titleData.push(ele.name)
        })
        console.log('data', titleData, this.goodsList)
        const option = {
          title: {
            text: '商品销售统计'
          },
          tooltip: {},
          legend: {
            data:['销量']
          },
          xAxis: {
            data: titleData,
            axisLabel: {
              interval: 0,
              rotate: -45,
              textStyle: {
                color: 'black',
                fontFamily: 'Microsoft YaHei'
              }
            }
          },
          yAxis: {},
          series: [{
            name: '销量',
            type: 'bar',
            barWidth: 30,
            data: [5, 20, 36, 10, 10, 20, 5, 20, 36, 10, 10, 20],
            lable: {
              show: true,
              position: 'top',
            }
          }]
        }
        myChart.setOption(option)
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
    .report-item {
      width: 100%;
      margin-top: 10px;
      padding: 10px 0;
      background: $color-white;
      border-radius: 5px;
    }
  }

  .total-wrapper {
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

  .goods-report {
    
  }
</style>
