<template>
  <div class="ktv-container" :class="mobileFlag ? 'moblie-ktv-container' : ''">
    <div class="room-container">
      <div class="room-menu">包间</div>
      <h2 v-if="mobileFlag && roomListLine1.length !== 0" class="floor-no">三楼</h2>
      <ul class="room-list">
        <li class="room"
          :class="{'active-room': activeRoom === room.no, 'busy-room': room.status == '1'}"
          v-for="(room, i) in roomListLine1" 
          :key="i" 
          @click="selectRoom(room)">
          <div class="room-type">{{ room.roomTypem }}</div>
          {{ room.no }}
        </li>
      </ul>
      <h2 v-if="mobileFlag && roomListLine2.length !== 0" class="floor-no">四楼</h2>
      <ul class="room-list">
        <li class="room"
          :class="{'active-room': activeRoom === room.no, 'busy-room': room.status == '1'}"
          v-for="(room, i) in roomListLine2" 
          :key="i" 
          @click="selectRoom(room)">
          <div class="room-type">{{ room.roomTypem }}</div>
          {{ room.no }}
        </li>
      </ul>
      <ul class="room-list">
        <li class="room"
          :class="{'active-room': activeRoom === room.no, 'busy-room': room.status == '1'}"
          v-for="(room, i) in roomListLine3" 
          :key="i" 
          @click="selectRoom(room)">
          {{ room.no }}
        </li>
      </ul>
    </div>
    <div class="ktv-detail" v-if="!mobileFlag">
      <div class="tab-wrapper">
        <Tabs v-model="activeName">
          <TabPane label="包间信息" name="first">
            <room-detail :roomInfo="roomInfo"></room-detail>
          </TabPane>
          <TabPane label="商品" name="second">
            <goods-detail :roomInfo="roomInfo"></goods-detail>
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
  import { mapGetters, mapMutations } from 'vuex'
  export default {
    data() {
      return {
        roomList: [
          // {name: '豪华大包', no: '欢迎光临'}
        ],
        roomListLine1: [],
        roomListLine2: [],
        roomListLine3: [],
        activeName: 'first',
        activeRoom: '0',
        roomInfo: {}
      }
    },
    created() {
      this.roomMap = {}
      this.getRoomInfo()
    },
    computed: {
      ...mapGetters([
        'userInfo',
        'roomSelected',
        'ordInfo',
        'mobileFlag'
      ])
    },
    methods: {
      getRoomInfo() {
        this.$http.post(apiUrl.getRoomInfo).then(res => {
          if (res.data.code === 200) {
            this.roomList = res.data.message
            this.roomList.forEach(ele => {
              this.roomMap[ele.uuid] = ele
              const position = ele.position
              if (!position) {
                this.roomListLine3.push(ele)
              } else {
                const row = position.split('_')[0]
                const col = position.split('_')[1]
                if (row == '1') {
                  this.roomListLine1.splice(col, 1, ele)
                } else {
                  this.roomListLine2.splice(col, 1, ele)
                }
              }
            })
          }
        })
      },
      selectRoom(room) {
        this.roomInfo = this.roomMap[room.uuid]
        this.activeRoom = room.no
        this.activeName = 'first'
        this.$http.post(apiUrl.getOrder, {
          data: {no: this.roomInfo.no}
        }).then(res => {
          if (res.data.code === 200) {
            const message = res.data.message
            this.setOrdInfo({data: res.data.message[0] || {room: room.no, user: this.userInfo.name}, type: 'ordInfo'})
            if (message.length === 0) {
              this.roomInfo.status = 0
            } else {
              this.roomInfo.status = 1
            }
            this.setRoomSelected(this.roomInfo)
            this.setMobileBillShow(1);
          }
        })
      },
      ...mapMutations({
        setRoomSelected: 'SET_ROOM_SELECTED',
        setOrdInfo: 'SET_ORDINFO',
        setMobileBillShow: 'SET_MOBILE_BILL_SHOW'
      })
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
    // height: 100%;
    width: 70%;
    min-height: 100%;
    // background: $color-white;
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
      font-size: 16px;
      .room {
        width: 11%;
        min-width: 11%;
        max-width: 11%;
        height: 100px;
        box-sizing: border-box;
        border: 1px solid $color-gray;
        background: $color-gray;
        margin: 10px;
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        position: relative;
        .room-type {
          position: absolute;
          top: 0;
          right: 0;
          font-size: 12px;
          padding: 5px;
          color: $color-deeporigin;
        }
        &.busy-room {
          background: $color-red;
          color: $color-white;
          .room-type {
            color: $color-yellow;
          }
        }
        &.active-room {
          font-size: 32px;
          font-weight: bold;
        }
        &:hover {
          font-size: 32px;
          font-weight: bold;
        }
      }
    }
  }

  .moblie-ktv-container {
    .room-container .room-list .room {
      min-width: 40%;
      max-width: inherit;
    }
    .floor-no {
      padding-top: 10px;
      font-weight: bold;
    }
    .room:hover {
      font-size: initial;
      font-weight: initial;
    }
  }
</style>
