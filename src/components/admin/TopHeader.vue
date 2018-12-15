<template>
  <div class="header-container">
    <div class="time-wrapper">
      <p>
        <span>{{ currentDate }}， </span>
        <span>{{ currentDay }}， </span>
        <span>{{ currentTime }}</span>
      </p>
    </div>
    <div class="user-wrapper">
      <div class="user-info">
        <span>KTV</span>
      </div>
      <el-button size="mini">退出</el-button>
    </div>
  </div>
</template>

<script>
  import { dateFormat } from '@/common/js/util'
  const datMap = {
    0: '星期天', 1: '星期一', 2: '星期二', 3: '星期三', 4: '星期四', 5: '星期五', 6: '星期六', 
  }
  export default {
    data() {
      return {
        currentDate: '2018-18-21',
        currentDay: `${datMap[new Date().getDay()]}`,
        currentTime: dateFormat(new Date(), 'hh:mm:ss'),
      }
    },
    created() {
      clearInterval(this.timer)
      this.timer = setInterval(() => {
        this.currentData = dateFormat(new Date(), 'yyyy-MM-dd')
        this.currentDay = datMap[new Date().getDay()]
        this.currentTime = dateFormat(new Date(), 'hh:mm:ss')
      }, 1000)
    },
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .header-container {
    background: $color-white;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 20px;
  }
  .user-wrapper {
    display: flex;
    align-items: center;
    .user-info {
      margin-right: 10px;
    }
  }
</style>
