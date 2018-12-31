<template>
  <div class="goods-wrapper">
    <div class="goods-item">
      <Card class="card-item" :class="{active: goods.active}" v-for="(goods, i) in goodsList" :key="i" @click.native="selectGoods(goods, i, $event)">
        <p slot="title">{{ goods.name }}</p>
        <p slot="extra" class="card-price">{{ goods.price }} 元</p>
        <div class="good-info">
          <InputNumber :min="1" size="small" v-model="goods.qty"></InputNumber>
        </div>
        <icon-font 
          v-show="goods.active" 
          icon="icon-selected" 
          fontSize="32" 
          class="card-selected">
        </icon-font>
      </Card>
    </div>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { deepClone } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
  import { mapGetters, mapMutations } from 'vuex'
  export default {
    data() {
      return {
        goodsList: []
      }
    },
    computed: {
      ...mapGetters([
        'goodsSelectedList',
        'roomSelected'
      ])
    },
    created () {
      this.getGoods()
    },
    methods: {
      getGoods() {
        this.$http.post(apiUrl.getGoods)
          .then(res => {
            if (res.data.code === 200) {
              this.goodsList = res.data.message
            }
          })
      },
      selectGoods(goods, index, e) {
        const array = [
          'ivu-input-number-input', 
          'ivu-input-number-handler-up-inner ivu-icon ivu-icon-ios-arrow-up', 
          'ivu-input-number-handler-down-inner ivu-icon ivu-icon-ios-arrow-down'
        ]
        if (array.indexOf(e.target.className) !== -1) {
          return false
        }
        if (goods.active) {
          this.setGoodsSelected({data: deepClone(goods), flag: false})
          this.$set(goods, 'active', false)
        } else {
          this.setGoodsSelected({data: deepClone(goods), flag: true})
          this.$set(goods, 'active', true)
        }
      },
      ...mapMutations({
        setGoodsSelected: 'SET_GOODS_SELECTED'
      }),
    },
    components: {
      IconFont
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .goods-wrapper {
    text-align: left;
  }
  .goods-item {
    display: flex;
    flex-wrap: wrap;
    .card-item {
      width: 200px;
      margin: 10px;
      cursor: pointer;
      &.active {
        border: 1px solid $color-green;
      }
      &:hover {
        border: 1px solid $color-green;
      }
      .card-price {
        font-size: 14px;
        color: $color-deeporigin;
      }
      .good-info {
        display: flex;
        img {
          width: 50px;
          height: 50px;
        }
      }
      .card-selected {
        position: absolute;
        bottom: 0;
        right: 0;
      }
    }
  }
</style>
