<template>
  <div class="baseinfo-container">
    <el-tabs type="border-card">
      <el-tab-pane label="房间">
        <room-info></room-info>
      </el-tab-pane>
      <el-tab-pane label="套餐">配置</el-tab-pane>
      <el-tab-pane label="商品">商品</el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
  import RoomInfo from '@/components/admin/RoomInfo'
  export default {
    data() {
      return {
        tabPosition: 'top'
      }
    },
    components: {
      RoomInfo
    }
  }
</script>

<style lang="scss" scoped>
  .baseinfo-container {
    
  }
</style>
