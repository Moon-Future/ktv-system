<template>
  <div class="goods-wrapper">
    <div class="goods-item">
      <Card class="card-item" :class="{active: goodsMap[goods.id] || goodsSelected[goods.id]}" v-for="(goods, i) in goodsList" :key="i" @click.native="selectGoods(goods, $event)">
        <p slot="title">{{ goods.name }}</p>
        <p slot="extra" class="card-price">{{ goods.price }} 元</p>
        <div class="good-info">
          <InputNumber :min="1" v-model="goods.qty" @on-change="change(goods, i)"></InputNumber>
        </div>
        <icon-font 
          v-show="goodsMap[goods.id] || goodsSelected[goods.id]" 
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
    props: {
      roomInfo: {
        type: Object,
        default: null
      }
    },
    data() {
      return {
        goodsList: [],
        goodsMap: {}
      }
    },
    computed: {
      ...mapGetters([
        'goodsSelected',
        'ordInfo',
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
              this.goodsList.forEach(ele => {
                ele.qty = 1
              })
            }
          })
      },
      selectGoods(goods, e) {
        const array = [
          'ivu-input-number-input', 
          'ivu-input-number-handler-up-inner ivu-icon ivu-icon-ios-arrow-up', 
          'ivu-input-number-handler-down-inner ivu-icon ivu-icon-ios-arrow-down'
        ]
        if (array.indexOf(e.target.className) !== -1) {
          return false
        }
        if (this.goodsMap[goods.id]) {
          this.setOrdInfo({data: deepClone(goods), flag: false, type: 'goods'})
          this.$set(this.goodsMap, goods.id, false)
        } else {
          this.setOrdInfo({data: deepClone(goods), flag: true, type: 'goods'})
          this.$set(this.goodsMap, goods.id, true)
        }
        if (this.roomSelected.status == 1) {
          this.updOrder()
        }
      },
      change(goods) {
        if (this.ordInfo && this.ordInfo.goods && this.ordInfo.goods[goods.id]) {
          this.setOrdInfo({data: deepClone(goods), flag: true, type: 'goods'})
          if (this.roomSelected.status == 1) {
            this.updOrder()
          }
        }
      },
      updOrder() {
        this.$http.post(apiUrl.updOrder, {
          data: {ordInfo: this.ordInfo, type: 'goods'}
        }).then(res => {

        })
      },
      ...mapMutations({
        setOrdInfo: 'SET_ORDINFO'
      }),
    },
    watch: {
      roomSelected() {
        this.goodsMap = {}
        this.goodsList.forEach((ele, i) => {
          ele.qty = this.goodsSelected && this.goodsSelected[ele.id] && Number(this.goodsSelected[ele.id].qty) || 1
        })
      }
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
        border: 1px solid $color-red;
      }
      &:hover {
        border: 1px solid $color-red;
      }
      .card-price {
        color: $color-red;
        font-size: 14px;
        font-weight: bold;
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
