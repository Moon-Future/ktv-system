<template>
  <div class="home">
    <div class="left-container">
      <!-- <left-menu></left-menu> -->
    </div>
    <div class="middle-container">
      <ktv-order></ktv-order>
    </div>
    <div class="right-container">

    </div>
  </div>
</template>

<script>
  import LeftMenu from '@/components/front/LeftMenu'
  import KtvOrder from '@/components/front/KtvOrder'
  export default {
    name: 'home',
    mounted() {

    },
    methods: {

    },
    watch: {

    },
    components: {
      LeftMenu,
      KtvOrder
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';
  .home {
    color: $color-black;
    height: 100%;
    width: 100%;
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
  }
</style>

