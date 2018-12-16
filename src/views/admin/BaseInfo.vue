<template>
  <div class="baseinfo-container">
    <div class="tab-wrapper">
      <Tabs size="small">
        <TabPane label="房间">
          <room-info></room-info>
        </TabPane>
        <TabPane label="套餐">
          <package-info></package-info>
        </TabPane>
        <TabPane label="商品">
          <goods-info></goods-info>
        </TabPane>
        <TabPane label="单位">
          <unit-info></unit-info>
        </TabPane>
      </Tabs>
    </div>
  </div>
</template>

<script>
  import RoomInfo from '@/components/admin/RoomInfo'
  import PackageInfo from '@/components/admin/PackageInfo'
  import GoodsInfo from '@/components/admin/GoodsInfo'
  import UnitInfo from '@/components/admin/UnitInfo'
  export default {
    data() {
      return {
        tabPosition: 'top'
      }
    },
    components: {
      RoomInfo,
      PackageInfo,
      GoodsInfo,
      UnitInfo
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

</style>
