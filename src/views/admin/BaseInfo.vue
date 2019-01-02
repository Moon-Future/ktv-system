<template>
  <div class="baseinfo-container">
    <div class="menu-wrapper">
      <Menu class="menu-ui" mode="horizontal" :active-name="activeName">
        <template v-for="(menu, i) in menuItem">
          <menu-item v-if="!menu.submenu" :name="menu.name" :key="i" @click.native="goPage(menu.to)">{{ menu.title }}</menu-item>
          <Submenu v-else :name="menu.name" :key="i">
            <template slot="title">{{ menu.title }}</template>
            <menu-item v-for="(sub, j) in menu.submenu" :name="sub.name" @click.native="goPage(sub.to)" :key="j">{{ sub.title }}</menu-item>
        </Submenu>
        </template>
    </Menu>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        activeName: '1-1',
        menuItem: [
          {name: '1', title: '房间设置',
            submenu: [
              {name: '1-1', to: '/admin/baseinfo/roominfo', title: '房间列表'},
              {name: '1-2', to: '/admin/baseinfo/roomtype', title: '房间类型'}
            ]
          },
          {name: '2', to: '/admin/baseinfo/goodsinfo', title: '商品设置'},
          {name: '3', to: '/admin/baseinfo/packageinfo', title: '套餐设置'},
          {name: '4', to: '/admin/baseinfo/unitinfo', title: '单位设置'}
        ]
      }
    },
    created() {
      this.routeMap = {
        roominfo: '1-1',
        roomtype: '1-2',
        goodsinfo: '2',
        packageinfo: '3',
        unitinfo: '4'
      }
      this.activeName = this.routeMap[this.$route.name]
    },
    methods: {
      goPage(href) {
        this.$router.push(href)
      }
    },
    watch: {
      $route() {
        this.activeName = this.routeMap[this.$route.name]
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .menu-ui {
    display: flex;
    justify-content: space-around;
    background: $color-shallowblack;
    color: $color-white;
    height: 35px;
    line-height: 35px;
    border-radius: 3px;
    margin-bottom: 10px;
  }
  .menu-ui>li {
    width: 25%;
    color: $color-white !important;
    &:hover {
      background: $color-origin;
      color: $color-black !important;
    }
    &.ivu-menu-item-active {
      background: $color-origin !important;
      color: $color-black !important;
    }
    }
</style>
