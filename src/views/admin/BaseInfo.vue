<template>
  <div class="baseinfo-container">
    <el-tabs type="border-card">
      <el-tab-pane label="房间">
        <room-info></room-info>
      </el-tab-pane>
      <el-tab-pane label="套餐">
        <package-info></package-info>
      </el-tab-pane>
      <el-tab-pane label="商品">
        <goods-info></goods-info>
      </el-tab-pane>
      <el-tab-pane label="单位">
        <goods-info></goods-info>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
  import RoomInfo from '@/components/admin/RoomInfo'
  import PackageInfo from '@/components/admin/PackageInfo'
  import GoodsInfo from '@/components/admin/GoodsInfo'
  import GoodsInfo from '@/components/admin/GoodsInfo'
  export default {
    data() {
      return {
        tabPosition: 'top'
      }
    },
    components: {
      RoomInfo,
      PackageInfo,
      GoodsInfo
    }
  }
</script>

<style lang="scss" scoped>
  .baseinfo-container {
    
  }
</style>
