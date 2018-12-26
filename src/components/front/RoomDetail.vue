<template>
  <div class="room-detail">
    <Row>
      <i-col span="18">
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
              v-for="(item, i) in roomInfo.package" 
              class="card-item" 
              :class="{active: activeIndex === i}"
              :key="i" 
              @click.native="selectPackage(i)">
              <p slot="title">{{ item.packagem }}</p>
              <p slot="extra" class="card-price">{{ item.price }} 元</p>
              <p v-for="(descr, j) in item.descr.split('\n')" :key="j">{{ descr }}</p>
              <icon-font 
                v-show="activeIndex === i" 
                icon="icon-selected" 
                fontSize="32" 
                class="card-selected">
              </icon-font>
            </Card>
          </div>
        </div>
      </i-col>
      <i-col span="6">
        zaina
      </i-col>
    </Row>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
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
        activeIndex: -1
      }
    },
    methods: {
      selectPackage(index) {
        this.activeIndex = this.activeIndex === index ? -1 : index
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
    .card-item {
      width: 200px;
      margin-right: 10px;
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
      top: 0;
      right: 0;
    }
  }
</style>
