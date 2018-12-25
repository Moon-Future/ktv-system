<template>
  <div class="ktv-container">
    <div class="room-container">
      <div class="room-menu">包间</div>
      <ul class="room-list">
        <li class="room" v-for="(room, i) in roomList" :key="i">
          {{ room.no }}
        </li>
      </ul>
    </div>
    <div class="ktv-detail">
      <div class="tab-wrapper">
        <Tabs v-model="activeName">
          <TabPane label="包间信息" name="first">
            <room-detail></room-detail>
          </TabPane>
          <TabPane label="商品" name="second">商品</TabPane>
        </Tabs>
      </div>
    </div>
  </div>
</template>

<script>
  import RoomDetail from '@/components/front/RoomDetail'
  import apiUrl from '@/serviceAPI.config.js'
  export default {
    data() {
      return {
        roomList: [
          // {name: '豪华大包', no: 1},
          // {name: '豪华大包', no: 2},
          // {name: '豪华大包', no: 3},
          // {name: '豪华大包', no: 4},
          // {name: '豪华大包', no: 5},
          // {name: '豪华大包', no: 6},
          // {name: '豪华大包', no: 7},
          // {name: '豪华大包', no: 8},
          // {name: '豪华大包', no: 9},
          // {name: '豪华大包', no: 10},
          // {name: '豪华大包', no: 11},
          // {name: '豪华大包', no: 12},
          // {name: '豪华大包', no: 13},
          // {name: '豪华大包', no: '欢迎光临'}
        ],
        activeName: 'first'
      }
    },
    created() {
      this.getRoomInfo()
    },
    methods: {
      getRoomInfo() {
        this.$http.post(apiUrl.getRoomInfo)
          .then(res => {
            if (res.data.code === 200) {
              this.roomList = res.data.message
            }
          })
      }
    },
    components: {
      RoomDetail
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';
  .ktv-container {
    height: 100%;
    background: $color-white;
    padding: 10px;
    box-sizing: border-box;
    border-radius: 5px;
  }
  .room-container {
    text-align: left;
    .room-menu {
      padding-bottom: 5px;
      border-bottom: 1px solid $color-gray;
      font-weight: bold;
    }
    .room-list {
      width: 100%;
      display: flex;
      flex-wrap: wrap;
      .room {
        width: 11%;
        min-width: 11%;
        max-width: 11%;
        height: 100px;
        box-sizing: border-box;
        border: 1px solid $color-gray;
        margin: 10px;
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        &:hover {
          border: 1px solid $color-deepgray;
        }
      }
    }
  }
  .ktv-detail {
    // border-top: 1px solid $color-gray;
    // padding: 5px 0;
  }
</style>
