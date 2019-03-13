<template>
  <div :class="mobileFlag ? 'mobileFlag-ktv-container' : ''">
    <div class="middle-container" v-show="!mobileFlag || mobileBillShow === 0">
      <ktv-order></ktv-order>
    </div>
    <div class="right-container" v-show="!mobileFlag || mobileBillShow === 1">
      <bill></bill> 
    </div>
  </div>
</template>

<script>
  import KtvOrder from '@/components/front/KtvOrder'
  import Bill from '@/components/front/Bill'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters } from 'vuex'
  export default {
    name: 'ktv',
    components: {
      KtvOrder,
      Bill
    },
    computed: {
      ...mapGetters(['mobileFlag', 'mobileBillShow'])
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';
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

  .mobileFlag-ktv-container {
    .middle-container {
      position: initial;
      width: auto;
      padding: 0;
      margin-top: 63px;
    }
    .right-container {
      position: initial;
      width: auto;
      padding: 0;
    }
  }
</style>

