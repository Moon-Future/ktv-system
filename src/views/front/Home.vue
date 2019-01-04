<template>
  <div class="home" v-show="userInfo">
    <div class="left-container">
      <left-menu></left-menu>
    </div>
    <div class="middle-container">
      <ktv-order></ktv-order>
    </div>
    <div class="right-container">
      <bill></bill> 
    </div>
  </div>
</template>

<script>
  import LeftMenu from '@/components/front/LeftMenu'
  import KtvOrder from '@/components/front/KtvOrder'
  import Bill from '@/components/front/Bill'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters, mapMutations } from 'vuex'
  export default {
    name: 'home',
    computed: {
      ...mapGetters(['userInfo'])
    },
    created() {
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
    components: {
      LeftMenu,
      KtvOrder,
      Bill
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
  .middle-container {
    position: fixed;
    left: 60px;
    width: 70%;
    height: 100%;
    padding: 10px;
    box-sizing: border-box;
    overflow: auto;
  }
  .right-container {
    position: fixed;
    right: 0;
    width: 11cm;
    height: 100%;
    padding: 10px;
    box-sizing: border-box;
  }
</style>

