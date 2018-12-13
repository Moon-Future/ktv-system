<template>
  <div class="icon-container" :class="flag ? has-margin : ''" :style="{fontSize: fontSize + 'px'}">
    <svg class="iconfont" aria-hidden="true" style="color:red">
      <use :xlink:href="`#${icon}`"></use>
    </svg>
    <div class="icon-content">
      <slot name="content"></slot>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Iconfont',
    props: {
      icon: {
        type: String,
        default: 'icon-yonghu'
      },
      fontSize: {
        type: String,
        default: '16'
      },
      flag: {
        type: Boolean,
        default: false
      }
    }
  }
</script>

<style lang="scss" scoped>
  .icon-container {
    display: inline;
    .has-margin {
      margin: 0 10px;
    }
    .icon-content {
      display: inline;
      margin-left: 3px;
    }
  }
</style>

