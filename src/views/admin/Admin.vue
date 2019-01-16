<template>
  <div class="admin-container" v-show="userInfo && userInfo.root == 1">
    <Aside></Aside>
    <div class="right-contain">
      <top-header></top-header>
      <router-view class="view-container"></router-view>
    </div>
  </div>
</template>

<script>
  import Aside from '@/components/admin/Aside'
  import TopHeader from '@/components/admin/TopHeader'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters, mapMutations } from 'vuex'
  export default {
    created() {
      this.getSession()
    },
    computed: {
      ...mapGetters(['userInfo'])
    },
    methods: {
      getSession() {
        this.$http.post(apiUrl.getSession).then(res => {
          if (res.data.code === 200) {
            this.setUserInfo(res.data.message)
            if (res.data.message.root != 1) {
              this.$Message.error('没有权限')
              this.$router.push({path: '/ktv'})
            }
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
      Aside,
      TopHeader
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';
  
  .right-contain {
    position: fixed;
    left: 100px;
    right: 0;
    height: 100%;
    background: $color-shallowgray;
  }
  .view-container {
    padding: 20px;
    position: absolute;
    top: 40px;
    bottom: 0;
    left: 0;
    right: 0;
    overflow: auto;
  }
</style>
