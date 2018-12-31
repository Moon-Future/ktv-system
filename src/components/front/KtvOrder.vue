<template>
  <div class="ktv-container">
    <div class="room-container">
      <div class="room-menu">包间</div>
      <ul class="room-list">
        <li class="room"
          :class="{'active-room': activeRoom === room.no, 'busy-room': room.status == '1'}"
          v-for="(room, i) in roomList" 
          :key="i" 
          @click="selectRoom(room)">
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
          <TabPane label="商品" name="second">
            <goods-detail></goods-detail>
          </TabPane>
        </Tabs>
      </div>
    </div>
  </div>
</template>

<script>
  import RoomDetail from '@/components/front/RoomDetail'
  import GoodsDetail from '@/components/front/GoodsDetail'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapMutations } from 'vuex'
  export default {
    data() {
      return {
        roomList: [
          {name: '豪华大包', no: '欢迎光临'}
        ],
        activeName: 'first',
        activeRoom: '0',
        roomInfo: {}
      }
    },
    created() {
      this.roomMap = {}
      this.getRoomInfo()
    },
    methods: {
      getRoomInfo() {
        this.$http.post(apiUrl.getRoomInfo).then(res => {
          if (res.data.code === 200) {
            this.roomList = res.data.message
            this.roomList.forEach(ele => {
              this.roomMap[ele.uuid] = ele
            })
          }
        })
      },
      selectRoom(room) {
        this.roomInfo = this.roomMap[room.uuid]
        this.activeRoom = room.no
        this.$http.post(apiUrl.getOrder, {
          data: {no: this.roomInfo.no}
        }).then(res => {
          if (res.data.code === 200) {
            const message = res.data.message
            this.setOrdInfo(res.data.message[0] || {})
            if (message.length === 0) {
              this.roomInfo.status = 0
            } else {
              this.roomInfo.status = message[0].status
            }
            this.setRoomSelected(this.roomInfo)
          }
        })
      },
      ...mapMutations({
        setRoomSelected: 'SET_ROOM_SELECTED',
        setOrdInfo: 'SET_ORDINFO'
      }),
    },
    components: {
      RoomDetail,
      GoodsDetail
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
        &.active-room {
          border: 1px solid $color-green;
          font-size: 16px;
          font-weight: bold;
        }
        &.busy-room {
          background: $color-red;
          color: $color-white;
        }
        &:hover {
          border: 1px solid $color-green;
          font-size: 16px;
          font-weight: bold;
        }
      }
    }
  }
  .ktv-detail {
    // border-top: 1px solid $color-gray;
    // padding: 5px 0;
  }
</style>
