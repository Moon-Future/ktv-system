<template>
  <div class="home" v-show="userInfo">
    <div class="left-container">
      <left-menu></left-menu>
    </div>
    <div :class="{'view-wrapper': vipFront}">
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
        vipFront: false
      }
    },
    computed: {
      ...mapGetters(['userInfo'])
    },
    created() {
      if (this.$route.path == '/vip') {
        this.vipFront = true
      } else {
        this.vipFront = false
      }
      this.getSession()
    },
    methods: {
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
        setUserInfo: 'SET_USERINGO'
      })
    },
    watch: {
      $route() {
        if (this.$route.path == '/vip') {
          this.vipFront = true
        } else {
          this.vipFront = false
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
</style>

