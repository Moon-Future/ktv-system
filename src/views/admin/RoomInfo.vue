<template>
  <div class="room-info">
    <Button size="small" class="room-position">房间布局</Button>
    <base-table
      :tableOptions="tableOptions"
      @edit="edit">
    </base-table>
  </div>
</template>

<script>
  import BaseTable from '@/components/admin/BaseTable'
  import { roomPosition } from '@/common/js/const'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    data() {
      return {
        tableOptions: {
          packageList: [],
          tableColumns: [
            {key: 'no', title: '房间号'},
            {key: 'name', title: '名称'},
            {key: 'roomTypem', title: '类型',
              render: (h, params) => {
                return h('Tag', {props: {color: 'success'}}, params.row.roomTypem)
              }
            },
            {key: 'package', title: '套餐',
              render: (h, params) => {
                const packageList = params.row.package
                let array = []
                packageList.forEach(ele => {
                  const descr = ele.descr.split('\n')
                  let descrArray = []
                  descr.forEach(ele => {
                    descrArray.push(h('span', {}, ele), h('br'))
                  })
                  array.push(h('Tooltip', {props: {'max-width': '200'}}, [
                    h('Tag', {props: {color: 'primary'}}, ele.packagem),
                    h('div', {slot: 'content'}, descrArray)
                  ]))
                })
                return h('span', array);
              }
            },
            {key: 'descr', title: '描述'},
            {key: 'position', title: '位置', render: (h, params) => {
              let posm = ''
              for (let i = 0, len = roomPosition.length; i < len; i++) {
                if (params.row.position == roomPosition[i].value) {
                  posm = roomPosition[i].label
                  break
                }
              }
              return h('span', posm)
            }},
          ],
          formArray: [
            {key: 'roomType', title: '类型', type: 'select', options: []},
            {key: 'no', title: '房间号', type: 'input'},
            {key: 'name', title: '名称', type: 'input'},
            {key: 'package', title: '套餐', type: 'checkbox', tooltip: true, options: []},
            {key: 'descr', title: '描述', type: 'textarea'},
            {key: 'position', title: '位置', type: 'select', options: roomPosition},
          ],
          formData: {
            roomType: '', name: '', no: '', package: [], descr: '', position: ''
          },
          ruleValidate: {
            roomType: [{required: true, message: '不得为空', trigger: 'blur'}],
            name: [{required: true, message: '不得为空', trigger: 'blur'}],
            no: [{required: true, message: '不得为空', trigger: 'blur'}]
          },
          addApi: 'insertRoomInfo',
          updApi: 'updRoomInfo',
          delApi: 'deleteRoomInfo',
          siftApi: 'getRoomInfo'
        }
      }
    },
    methods: {
      getPackage() {
        return new Promise((resolve, reject) => {
          this.$http.post(apiUrl.getPackage)
            .then(res => {
              if (res.data.code === 200) {
                resolve(res.data.message)
              } else {
                reject()
              }
            })
        })
      },
      getRoomType() {
        return new Promise((resolve, reject) => {
          this.$http.post(apiUrl.getRoomType)
            .then(res => {
              if (res.data.code === 200) {
                resolve(res.data.message)
              } else {
                reject()
              }
            })
        })
      },
      async edit({type, params = {}}) {
        if (!this.hasGet) {
          this.packageList = await this.getPackage()
          this.roomType = await this.getRoomType()
          this.packageList.forEach(ele => {
            ele.id = ele.uuid
            ele.descr = ele.descr.split('\n')
          })
          this.roomType.forEach(ele => {
            ele.value = ele.id + ''
            ele.label = ele.name
          })
          this.hasGet = true
          this.tableOptions.formArray.splice(0, 1, {key: 'roomType', title: '类型', type: 'select', options: this.roomType})
          this.tableOptions.formArray.splice(3, 1, {key: 'package', title: '套餐', type: 'checkbox', tooltip: true, options: this.packageList})
        }
        if (type === 'add') {
          this.tableOptions.formData = {
            roomType: '', name: '', no: '', package: [], descr: '', position: ''
          }
        } else if (type === 'upd') {
          const row = params.row
          let packageList = []
          row.package.forEach(ele => {
            packageList.push(ele.package)
          })
          this.tableOptions.formData = row
          this.tableOptions.formData.package = packageList
          this.tableOptions.formData.price += ''
          this.tableOptions.formData.roomType += ''
        }
      }
    },
    components: {
      BaseTable
    }
  }
</script>

<style lang="scss" scoped>
  .room-position {
    position: absolute;
  }
</style>
