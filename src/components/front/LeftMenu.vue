<template>
    <div class="menu-container">
      <Button class="user-logout" type="primary" size="small" @click="logout">退出</Button>
      <div class="user-avatar">
        <img :src="avatar" alt="">
      </div>
      <ul class="menu-wrapper">
        <router-link 
          tag="li" 
          :to="item.to" 
          v-for="(item, i) in menuList" 
          :class="{active: i === activeIndex, setup: item.index === '4'}" 
          :key="i" 
          @click="changeIndex(i)">
          <icon-font :icon="i === activeIndex ? `${item.icon}-active` : item.icon" fontSize="22"></icon-font>
          <p>{{ item.text }}</p>
        </router-link>
      </ul>
    </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapMutations } from 'vuex'
  export default {
    data() {
      return {
        avatar: require('@/assets/avatar.jpg'),
        menuList: [
          {icon: 'icon-money-bag', text: '收银台', index: '1', to: '/ktv'},
          {icon: 'icon-order', text: '历史账单', index: '2', to: '/order'},
          {icon: 'icon-vip', text: '会员', index: '3', to: '/vip'},
          {icon: 'icon-shezhi', text: '设置', index: '4', to: '/admin/baseinfo/roominfo'}
        ],
        activeIndex: 0
      }
    },
    created() {
      this.routhPath()
    },
    methods: {
      changeIndex(index) {
        this.activeIndex = index
      },
      logout() {
        this.$http.post(apiUrl.logout).then(res => {
          if (res.data.code === 200) {
            this.setUserInfo({})
            this.$router.push({path: '/login'})
          }
        }).catch(err => {
          this.$Message.error('服务器君傲娇啦😭')
        })
      },
      routhPath() {
        switch(this.$route.path) {
          case '/ktv':
            this.activeIndex = 0
            break
          case '/order':
            this.activeIndex = 1
            break
          case '/vip':
            this.activeIndex = 2
            break
          default:
            this.activeIndex = 0
            break
        }
      },
      ...mapMutations({
        setUserInfo: 'SET_USERINGO'
      })
    },
    watch: {
      $route() {
        this.routhPath()
      }
    },
    components: {
      IconFont
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .menu-container {
    background: $color-shallowblack;
    color: $color-deepgray;
    width: 100%;
    height: 100%;
  }
  .user-logout {
    margin-top: 20px;
    background: $color-shallowblack;
  }
  .user-avatar {
    img {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      margin: 20px 0;
    }
  }
  .menu-wrapper {
    font-size: 14px;
    li {
      cursor: pointer;
      padding: 10px 0;
      p {
        padding-top: 5px;
      }
      &.active {
        background: $color-black;
        color: $color-deeporigin;
        p {
          font-weight: bold;
        }
      }
      &.setup {
        position: absolute;
        bottom: 0;
        width: 100%;
      }
    }
  }
</style>
