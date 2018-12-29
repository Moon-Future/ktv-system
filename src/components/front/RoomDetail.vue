<template>
  <div class="room-detail">
    <Row>
      <i-col span="18" class="left-wrapper">
        <ul class="title-wrapper">
          <li class="title-item" v-for="(item, i) in titleArray" :key="i">
            <span>{{ item.title }}：</span>
            <span class="title-content">{{ roomInfo[item.field] }} {{ item.after }}</span>
          </li>
        </ul>
        <div class="package-list">
          <h1>可选套餐</h1>
          <div class="card-wrapper">
            <Card 
              v-for="(item, j) in roomInfo.package" 
              class="card-item" 
              :class="{active: activeIndex === j}"
              :key="j" 
              @click.native="selectPackage(item, j)">
              <p slot="title">{{ item.packagem }}</p>
              <p slot="extra" class="card-price">{{ item.price }} 元</p>
              <p v-for="(descr, k) in item.descr.split('\n')" :key="k">{{ descr }}</p>
              <icon-font 
                v-show="activeIndex === j" 
                icon="icon-selected" 
                fontSize="32" 
                class="card-selected">
              </icon-font>
            </Card>
          </div>
        </div>
      </i-col>
      <i-col span="6" class="right-wrapper">
        <ul class="cust-info">
          <li class="cust-item" v-for="(item, i) in custMap" :key="i">
            <span class="cust-title">{{ item }}：</span>
            <a href="javascript:;" v-if="i === 'vip' && !orderInfo[i]">登陆</a>
            <span v-else>{{ orderInfo[i] }}</span>
          </li>
        </ul>
        <Button type="primary" style="width:100%" @click="placeOrder">开单</Button>
      </i-col>
    </Row>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    props: {
      roomInfo: {
        type: Object,
        default: null
      }
    },
    data() {
      return {
        titleArray: [
          {title: '房间编号', field: 'no'},
          {title: '房间类型', field: 'roomTypem'},
          {title: '价格', field: 'price', after: '元/小时'},
          {title: '状态', field: 'status'},
        ],
        custMap: {vip: '会员', balance: '余额', time: '时间'},
        maxLen: 3,
        activeIndex: -1,
        orderInfo: {}
      }
    },
    methods: {
      selectPackage(item, index) {
        this.activeIndex = this.activeIndex === index ? -1 : index
      },
      placeOrder() {
        const packageUuid = this.activeIndex === -1 ? '' : this.roomInfo.package[this.activeIndex].package
        const startTime = new Date().getTime()
        this.$http.post(apiUrl.insertOrder, {
          data: {no: this.roomInfo.no, package: packageUuid, startTime}
        }).then(res => {
          
        })
      }
    },
    watch: {
      roomInfo() {
        this.$http.post(apiUrl.getOrder, {
          data: {no: this.roomInfo.no}
        }).then(res => {
          if (res.data.code === 200) {
            this.orderInfo = res.data.message[0] || {}
          }
        })
      }
    },
    components: {
      IconFont
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .room-detail {
    text-align: left;
  }
  .left-wrapper {
    border-right: 2px solid $color-gray;
  }
  .right-wrapper {
    padding: 0 3px;
  }
  .title-wrapper {
    display: flex;
    .title-item {
      font-size: 14px;
      margin-right: 10px;
      .title-content {
        color: $color-deeporigin;
      }
    }
  }
  .card-wrapper {
    display: flex;
    flex-wrap: wrap;
    .card-item {
      width: 200px;
      margin-right: 10px;
      margin-bottom: 10px;
      cursor: pointer;
      &.active {
        border: 1px solid $color-green;
      }
      &:hover {
        border: 1px solid $color-green;
      }
    }
    .card-title {
      font-size: 14px;
      font-weight: 700;
      height: 30px;
    }
    .card-price {
      font-size: 14px;
      color: $color-deeporigin;
    }
    .card-selected {
      position: absolute;
      bottom: 0;
      right: 0;
    }
  }
  
  .cust-info {
    .cust-item {
      font-size: 16px;
    }
  }
</style>
