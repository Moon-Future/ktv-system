<template>
  <div class="aside-container">
    <div class="mobile-menu" v-if="mobileFlag">
      <icon-font icon="icon-menu" @click.native="openMenu"></icon-font>
    </div>
    <div class="menu-wrapper" v-show="showFlag">
      <Menu class="aside-menu"
        theme="dark"
        mode="vertical"
        width="auto">
        <div class="close-menu" v-if="mobileFlag" index="closeMenu">
          <icon-font icon="icon-close" @click.native="closeMenu"></icon-font>
        </div>
        <div class="user-message" index="userMessage">
          <div class="user-avatar">
            <img :src="userInfo.avatar || avatar" alt="">
          </div>
        </div>
        <template v-for="item in items">
          <template v-if="item.subs">
            <Submenu :key="item.index" :name="item.index" class="menu-item">
              <template slot="title">
                <icon-font :icon="item.icon"></icon-font>
                <span>{{ item.title }}</span>
              </template>
              <menu-item v-for="(subItem, i) in item.subs" :key="i" :name="subItem.index" :to="subItem.index">
                <icon-font :icon="subItem.icon"></icon-font>
                <span>{{ subItem.title }}</span>
              </menu-item>
            </Submenu>
          </template>
          <template v-else>
            <menu-item :key="item.index" :name="item.index" :to="item.index" class="menu-item">
              <icon-font :icon="item.icon"></icon-font>
              <span>{{ item.title }}</span>
            </menu-item>
          </template>
        </template>
        <div class="rights" index="rights">
          <p>Copyright © 2018 - {{ new Date().getFullYear() }} KTV Co., Ltd.</p>
        </div>
      </Menu>
    </div>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  export default {
    props: {
      userInfo: {
        type: Object,
        default() {
          return {}
        }
      }
    },
    data() {
      return {
        showFlag: true,
        mobileFlag: false,
        user: 'KTV',
        avatar: require('@/assets/avatar.jpg'),
        activeIndex: '0',
        items: [
          {
            icon: 'icon-shezhi',
            index: '/admin/baseinfo/roominfo',
            title: '基本设置'
          }
        ]
      }
    },
    methods: {
      openMenu() {
        this.showFlag = true
      },
      closeMenu() {
        this.showFlag = false
      }
    },
    components: {
      IconFont
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';
  .mobile-menu {
    position: fixed;
    padding: 5px;
    text-align: left;
  }
  .menu-wrapper {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    width: 100px;
    text-align: left;
    display: flex;
    flex-flow: column;
    overflow-y: auto;
    z-index: 100;
    .menu-item {
      display: flex;
      align-items: center;
      padding: 10px !important;
    }
    .close-menu {
      text-align: right;
      padding: 5px;
    }
    .user-message {
      padding: 10px 0;
      margin: auto;
      .user-avatar {
        width: 50px;
        height: 50px;
        margin: auto;
        img {
          width: 50px;
          height: 50px;
          border-radius: 50%;
        }
      }
      .user-name {
        text-align: center;
        margin-top: 10px;
        color: $color-white;
      }
    }
    .aside-menu {
      height: 100%;
      border: none;
    }
    .rights {
      font-size: 12px;
      color: $color-white;
      margin: 10px;
      text-align: center;
      line-height: 22px;
      position: absolute;
      bottom: 0;
    }
  }
</style>