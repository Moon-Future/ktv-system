<template>
  <div class="ktv-container">
    <div class="middle-container">
      <ktv-order></ktv-order>
    </div>
    <div class="right-container">
      <bill></bill> 
    </div>
  </div>
</template>

<script>
  import KtvOrder from '@/components/front/KtvOrder'
  import Bill from '@/components/front/Bill'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    name: 'ktv',
    components: {
      KtvOrder,
      Bill
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
</style>

