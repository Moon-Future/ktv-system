<template>
  <div class="baseinfo-container">
    <div class="menu-wrapper">
      <ul class="menu-ui">
        <router-link
          v-for="(item, i) in menuItem"
          tag="li"
          :to="item.to"
          :class="{active: activeName === i}"
          :key="i">{{ item.title }}</router-link>
      </ul>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        activeName: 0,
        menuItem: [
          {to: '/admin/baseinfo/roominfo', title: '房间设置'},
          {to: '/admin/baseinfo/goodsinfo', title: '商品设置'},
          {to: '/admin/baseinfo/packageinfo', title: '套餐设置'},
          {to: '/admin/baseinfo/unitinfo', title: '单位设置'}
        ]
      }
    },
    created() {
      this.routeMap = {
        roominfo: 0,
        goodsinfo: 1,
        packageinfo: 2,
        unitinfo: 3
      }
      this.activeName = this.routeMap[this.$route.name]
    },
    methods: {
      
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
    border-radius: 3px;
    margin-bottom: 10px;
    li {
      width: 25%;
      padding: 10px 0;
      cursor: pointer;
      &:hover {
        background: $color-origin;
        color: $color-black;
      }
      &.active {
        background: $color-origin;
        color: $color-black;
      }
    }
  }
</style>
