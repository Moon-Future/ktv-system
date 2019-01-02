<template>
  <div class="room-detail">
    <div class="left-wrapper">
      <ul class="title-wrapper">
        <li class="title-item" v-for="(item, i) in titleArray" :key="i">
          <span>{{ item.title }}：</span>
          <span class="title-content">{{ roomInfo[item.field] | status({field: item.field, roomInfo: roomInfo}) }} {{ item.after }}</span>
        </li>
      </ul>
      <Tabs type="card">
        <TabPane label="阳光档套餐(13:30 ~ 17:00)">
          <div class="card-wrapper">
            <Card
              v-for="(item, j) in roomInfo.package" 
              class="card-item" 
              :class="{active: activeIndex === j || packageSelected.package == item.package}"
              :key="j" 
              @click.native="selectPackage(item, j)">
              <p slot="title">{{ item.packagem }}</p>
              <p slot="extra" class="card-price">{{ item.price }} 元</p>
              <p v-for="(descr, k) in item.descr.split('\n')" :key="k">{{ descr }}</p>
              <icon-font 
                v-show="activeIndex === j || packageSelected.package == item.package" 
                icon="icon-selected" 
                fontSize="32" 
                class="card-selected">
              </icon-font>
            </Card>
          </div>
        </TabPane>
        <TabPane label="黄金档档套餐(17:00 ~ 24:00)">
          <div class="card-wrapper">
            <Card
              v-for="(item, j) in roomInfo.package" 
              class="card-item" 
              :class="{active: activeIndex === j || packageSelected.package == item.package}"
              :key="j" 
              @click.native="selectPackage(item, j)">
              <p slot="title">{{ item.packagem }}</p>
              <p slot="extra" class="card-price">{{ item.price }} 元</p>
              <p v-for="(descr, k) in item.descr.split('\n')" :key="k">{{ descr }}</p>
              <icon-font 
                v-show="activeIndex === j || packageSelected.package == item.package" 
                icon="icon-selected" 
                fontSize="32" 
                class="card-selected">
              </icon-font>
            </Card>
          </div>
        </TabPane>
      </Tabs>
    </div>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters, mapMutations } from 'vuex'
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
    computed: {
      ...mapGetters([
        'packageSelected',
        'roomSelected',
        'ordInfo'
      ])
    },
    methods: {
      selectPackage(item, index) {
        if (this.roomSelected.status == 1) {
          this.$Modal.confirm({
            title: '确认更换套餐？',
            content: '订单已下，确认是否更换套餐？',
            onOk: () => {
              this.activeIndex = this.activeIndex === index ? -1 : index
              this.setOrdInfo({data: item, type: 'package'})
              this.$http.post(apiUrl.updOrder, {
                data: {ordInfo: this.ordInfo, type: 'package'}
              }).then(res => {

              })
            },
          })
          return
        }
        this.setOrdInfo({data: this.activeIndex === index ? {} : item, type: 'package'})
        this.activeIndex = this.activeIndex === index ? -1 : index
      },
      ...mapMutations({
        setOrdInfo: 'SET_ORDINFO'
      })
    },
    filters: {
      status(value, {field, roomInfo}) {
        if (field === 'status') {
          return roomInfo.status == 0 ? '空闲' : '使用中'
        } else {
          return value
        }
      }
    },
    watch: {
      roomSelected() {
        this.activeIndex = -1
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
        border: 1px solid $color-red;
      }
      &:hover {
        border: 1px solid $color-red;
      }
    }
    .card-title {
      font-size: 14px;
      font-weight: 700;
      height: 30px;
    }
    .card-price {
      font-size: 14px;
      font-weight: bold;
      color: $color-red;
    }
    .card-selected {
      position: absolute;
      bottom: 0;
      right: 0;
    }
  }
</style>
