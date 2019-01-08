<template>
  <div class="room-detail">
    <div class="left-wrapper">
      <ul class="title-wrapper">
        <li class="title-item" v-for="(item, i) in titleArray" :key="i">
          <span>{{ item.title }}：</span>
          <span v-if="item.field !== 'startTime'" class="title-content">{{ roomInfo[item.field] | status({field: item.field, roomInfo: roomInfo, ordInfo: ordInfo}) }} {{ item.after }}</span>
          <span v-if="item.field === 'startTime' && ordInfo.startTime" class="title-content">
            {{ ordInfo.startTime | filterTime(true)}}{{ currentTime | filterTime(false)}}， {{ diffTime }}
          </span>
        </li>
      </ul>
      <Tabs type="card" v-model="packageType">
        <TabPane label="阳光档套餐(13:30 ~ 17:00)" name="1">
          <div class="card-wrapper">
            <Card
              v-for="(item, j) in packageList1" 
              class="card-item" 
              :class="{active: ordInfo.package && (activeItem.type == '1' && activeItem.package == item.package) || (packageSelected.type == '1' && packageSelected.package == item.package)}"
              :key="j" 
              @click.native="clickPackage(item, j)">
              <p slot="title">{{ item.packagem }}</p>
              <p slot="extra" class="card-price">{{ item.price1 }} 元</p>
              <p v-for="(descr, k) in item.descr.split('\n')" :key="k">{{ descr }}</p>
              <icon-font 
                v-show="ordInfo.package && (activeItem.type == '1' && activeItem.package == item.package) || (packageSelected.type == '1' && packageSelected.package == item.package)" 
                icon="icon-selected" 
                fontSize="32" 
                class="card-selected">
              </icon-font>
            </Card>
          </div>
        </TabPane>
        <TabPane label="黄金档档套餐(17:00 ~ 24:00)" name='2'>
          <div class="card-wrapper">
            <Card
              v-for="(item, j) in packageList2" 
              class="card-item" 
              :class="{active: ordInfo.package && (activeItem.type == '2' && activeItem.package == item.package) || (packageSelected.type == '2' && packageSelected.package == item.package)}"
              :key="j" 
              @click.native="clickPackage(item, j)">
              <p slot="title">{{ item.packagem }}</p>
              <p slot="extra" class="card-price">{{ item.price2 }} 元</p>
              <p v-for="(descr, k) in item.descr.split('\n')" :key="k">{{ descr }}</p>
              <icon-font 
                v-show="ordInfo.package && (activeItem.type == '2' && activeItem.package == item.package) || (packageSelected.type == '2' && packageSelected.package == item.package)" 
                icon="icon-selected" 
                fontSize="32" 
                class="card-selected">
              </icon-font>
            </Card>
          </div>
        </TabPane>
      </Tabs>
    </div>
    <Modal
      v-model="modalFlag"
      :title="modalTitle"
      :footer-hide="true">
      <CheckboxGroup v-model="goodsListSelected" class="goods-list">
        <Checkbox class="goods-list-item" v-for="(item, i) in goodsList" :label="item.goods" disabled :key="i">{{ item.goodsm }}({{ item.qty }}{{ item.unitm }})</Checkbox>
      </CheckboxGroup>
      <RadioGroup v-model="packageItem.grpSelected">
        <Radio class="goods-list-item" v-for="(item, i) in goodsListGrp" :label="item.goods" :key="i">{{ item.goodsm }}({{ item.qty }}{{ item.unitm }})</Radio>
      </RadioGroup>
      <div class="modal-operate">
        <Button @click="modalFlag = false">取消</Button>
        <Button type="primary" @click="selectPackage">确认</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { deepClone, dateFormat } from '@/common/js/util'
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
        titleArray: [
          {title: '房间编号', field: 'no'},
          {title: '房间类型', field: 'roomTypem'},
          {title: '状态', field: 'status'},
          {title: '时长', field: 'startTime'}
        ],
        custMap: {vip: '会员', balance: '余额', time: '时间'},
        maxLen: 3,
        activeItem: {},
        packageType: '1',
        packageItem: {},
        modalFlag: false,
        goodsList: [],
        goodsListSelected: [],
        goodsListGrp: [],
        modalTitle: '套餐商品',
        currentTime: new Date().getTime()
      }
    },
    created() {
      this.timer = setInterval(() => {
        this.currentTime += 1000
      }, 1000)
    },
    computed: {
      packageList1() {
        if (!this.roomInfo || !this.roomInfo.package) {
          return []
        }
        let packageList = []
        this.roomInfo.package.forEach(ele => {
          if (ele.type1 == '1') {
            packageList.push(ele)
          }
        });
        return packageList
      },
      packageList2() {
        if (!this.roomInfo || !this.roomInfo.package) {
          return []
        }
        let packageList = []
        this.roomInfo.package.forEach(ele => {
          if (ele.type2 == '1') {
            packageList.push(ele)
          }
        });
        return packageList
      },
      diffTime() {
        const diff = this.currentTime - this.ordInfo.startTime
        const hour = Math.floor(diff / (1000 * 60 * 60))
        const minute = Math.floor((diff - hour) / (1000 * 60))
        const str = hour === 0 ? `${minute} 分钟` : `${hour} 小时 ${minute} 分钟`
        return str
      },
      ...mapGetters([
        'packageSelected',
        'goodsSelected',
        'roomSelected',
        'ordInfo'
      ])
    },
    methods: {
      clickPackage(item, index) {
        item.grpSelected = item.grpSelected || ''
        this.packageItem = item
        if (this.ordInfo.package && this.ordInfo.package.type == this.packageType && this.ordInfo.package.package == this.packageItem.package) {
          this.$set(this.packageItem, 'grpSelected', Number(this.ordInfo.package.grpSelected) || '')
        }
        const grp = item.grp.split(',')
        this.modalTitle = `套餐商品（${item.packagem}）`
        this.modalFlag = true
        this.goodsList = []
        this.goodsListGrp = []
        item.goods.forEach(ele => {
          if (grp.indexOf(ele.goods + '') === -1) {
            this.goodsList.push(ele)
            this.goodsListSelected.push(ele.goods)
          } else {
            this.goodsListGrp.push(ele)
          }
        })
      },
      selectPackage() {
        if (this.packageItem.grp != '' && this.packageItem.grpSelected == '') {
          this.$Message.error('请选择商品')
          return
        }
        if (this.roomSelected.status == 1) {
          this.$Modal.confirm({
            title: '确认更换套餐？',
            content: '订单已下，确认是否更换套餐？',
            onOk: () => {
              let item = deepClone(this.packageItem)
              item.type = this.packageType
              this.setOrdInfo({data: item, type: 'packageMap'})
              this.totalPrice()
              if (this.roomSelected.status == 1) {
                this.$http.post(apiUrl.updOrder, {
                  data: {ordInfo: this.ordInfo}
                }).then(res => {
                  this.modalFlag = false
                })
              } else {
                this.modalFlag = false
              }
            },
          })
          return
        }
        this.modalFlag = false
        this.activeItem = deepClone(this.packageItem)
        this.activeItem.type = this.packageType
        this.setOrdInfo({data: this.activeItem, type: 'packageMap'})
      },
      totalPrice() {
        let price = 0
        const packagePrice = this.packageSelected.type == '1' ? this.packageSelected.price1 : this.packageSelected.price2
        for (let key in this.goodsSelected) {
          price += Number(this.goodsSelected[key].price) * Number(this.goodsSelected[key].qty)
        }
        price += Number(packagePrice || 0)
        this.setOrdInfo({data: {totalPrice: price}})
      },
      ...mapMutations({
        setOrdInfo: 'SET_ORDINFO'
      })
    },
    filters: {
      status(value, {field, roomInfo, ordInfo}) {
        if (field === 'status') {
          return roomInfo.status === undefined ? '' : roomInfo.status == 0 ? '空闲' : '使用中'
        } else {
          return value
        }
      },
      filterTime(time, flag) {
        if (time) {
          return dateFormat(time, 'hh:mm') + (flag ? ' ~ ' : '')
        } else {
          return ''
        }
      }
    },
    watch: {
      roomSelected() {
        this.activeItem = {}
        this.packageType = this.ordInfo && this.ordInfo.package && (this.ordInfo.package.type + '') || '1'
        this.currentTime = new Date().getTime()
      }
    },
    components: {
      IconFont
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .room-detail {
    text-align: left;
  }
  .title-wrapper {
    display: flex;
    padding-bottom: 10px;
    .title-item {
      font-size: 14px;
      margin-right: 10px;
      .title-content {
        color: $color-deeporigin;
      }
    }
  }
  .card-wrapper {
    display: flex;
    flex-wrap: wrap;
    .card-item {
      width: 250px;
      margin-right: 10px;
      margin-bottom: 10px;
      cursor: pointer;
      &.active {
        border: 1px solid $color-red;
      }
      &:hover {
        border: 1px solid $color-red;
      }
      p {
        line-height: 22px;
      }
    }
    .card-title {
      font-size: 14px;
      font-weight: 700;
      height: 30px;
    }
    .card-price {
      font-size: 14px;
      font-weight: bold;
      color: $color-red;
    }
    .card-selected {
      position: absolute;
      bottom: 0;
      right: 0;
    }
  }
  .goods-list {
    display: flex;
    flex-flow: column;
  }
  .goods-list-item {
    padding: 5px 0;
    font-size: 16px;
  }
  .modal-operate {
    text-align: right;
    border-top: 1px solid $color-gray;
    padding-top: 10px;
    button {
      margin-left: 10px;
    }
  }
</style>
