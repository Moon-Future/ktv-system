<template>
  <div class="ktv-container">
    <div class="room-container">
      <div class="room-menu">包间</div>
      <ul class="room-list">
        <li class="room" v-for="(room, i) in roomList" :key="i" @click="selectRoom(room.uuid)">
          {{ room.no }}
        </li>
      </ul>
    </div>
    <div class="ktv-detail">
      <div class="tab-wrapper">
        <Tabs v-model="activeName">
          <TabPane label="包间信息" name="first">
            <room-detail :roomInfo="roomInfo"></room-detail>
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
          {name: '豪华大包', no: '欢迎光临'}
        ],
        activeName: 'first',
        roomInfo: {}
      }
    },
    created() {
      this.roomMap = {}
      this.getRoomInfo()
    },
    methods: {
      getRoomInfo() {
        this.$http.post(apiUrl.getRoomInfo)
          .then(res => {
            if (res.data.code === 200) {
              this.roomList = res.data.message
              this.roomList.forEach(ele => {
                this.roomMap[ele.uuid] = ele
              })
            }
          })
      },
      selectRoom(uuid) {
        this.roomInfo = this.roomMap[uuid]
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
        cursor: pointer;
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
