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
            <Card v-for="(item, i) in roomInfo.package" :key="i" class="card-item">
              <p slot="title"><Radio value="true" class="card-title">{{ item.packagem }}</Radio></p>
              <p slot="extra" class="card-price">{{ item.price }} 元</p>
              <p v-for="(descr, j) in item.descr.split('\n')" :key="j">{{ descr }}</p>
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
        ]
      }
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
    }
    .card-title {
      font-size: 14px;
      font-weight: 700;
    }
    .card-price {
      font-size: 14px;
    }
  }
</style>
