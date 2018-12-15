<template>
  <div class="admin-container">
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
  export default {
    components: {
      Aside,
      TopHeader
    }
  }
</script>

<style lang="scss" scoped>
  .right-contain {
    position: fixed;
    left: 100px;
    right: 0;
    height: 100%;
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
