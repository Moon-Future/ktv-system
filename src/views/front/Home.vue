<template>
  <div class="home" v-show="userInfo" :class="mobileFlag ? 'mobileFlag-home' : ''">
    <div class="left-container">
      <left-menu></left-menu>
    </div>
    <div class="view-container" :class="{'view-wrapper': vipFront}">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
  import LeftMenu from '@/components/front/LeftMenu'
  import Ktv from '@/views/front/Ktv'
  import Vip from '@/views/admin/Vip'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters, mapMutations } from 'vuex'
  export default {
    name: 'home',
    data() {
      return {
        vipFront: false,
        mobileFlag: false
      }
    },
    computed: {
      ...mapGetters(['userInfo'])
    },
    created() {
      this.setMobile()
      if (this.$route.path == '/vip' || this.$route.path == '/order') {
        this.vipFront = true
      } else {
        this.vipFront = false
      }
      this.getSession()
    },
    methods: {
      setMobile() {
        const width = document.documentElement.clientWidth
        if (width <= 736) {
          this.mobileFlag = true
        } else {
          this.mobileFlag = false
        }
        this.setMobileFlag(this.mobileFlag)
      },
      getSession() {
        this.$http.post(apiUrl.getSession).then(res => {
          if (res.data.code === 200) {
            this.setUserInfo(res.data.message)
          } else {
            this.$Message.info(res.data.message)
            this.$router.push({path: '/login'})
          }
        }).catch(err => {
          this.$router.push({path: '/login'})
          this.$Message.error(res.data.message)
        })
      },
      ...mapMutations({
        setUserInfo: 'SET_USERINGO',
        setRoomSelected: 'SET_ROOM_SELECTED',
        setOrdInfo: 'SET_ORDINFO',
        setMobileFlag: 'SET_MOBILE_FLAG'
      })
    },
    watch: {
      $route() {
        if (this.$route.path == '/vip' || this.$route.path == '/order') {
          this.vipFront = true
        } else {
          this.vipFront = false
          this.setOrdInfo({data: {}, type: 'ordInfo'})
          this.setRoomSelected({})
        }
      }
    },
    components: {
      LeftMenu,
      Ktv,
      Vip
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';
  .home {
    color: $color-black;
    height: 100%;
    width: 100%;
    overflow: auto;
  }
  .left-container {
    position: fixed;
    left: 0;
    width: 60px;
    height: 100%;
  }
  .view-wrapper {
    margin-left: 60px;
    padding: 20px;
  }
  .view-container {
    height: 100%;
    background-image: url('~@/assets/spring.jpg');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
  }

  .mobileFlag-home {
    .left-container {
      position: fixed;
      width: 100%;
      height: auto;
      z-index: 99;
    }
    .view-wrapper {
      margin-left: 0;
      padding: 0;
      margin-top: 63px;
    }
  }
</style>

