<template>
  <div class="basetable-container">
    <div class="sift-wrapper">
      <div class="top-title">
        <h2>总数：{{ total }}</h2>
        <Button type="primary" size="small" @click="goAdd">添加</Button>
      </div>
      <Table :columns="tableColumns" :data="tableData" :loading="loading" stripe size="small"></Table>
    </div>
    <Drawer
      title="新增"
      v-model="addFlag"
      width="50%"
      :mask-closable="false"
      :styles="styles">
      <Form ref="submitForm" label-position="right" :label-width="tableOptions.width || 60" :model="formData" :rules="tableOptions.ruleValidate || {}">
        <template v-for="(item, i) in tableOptions.formArray">
          <FormItem :label="item.title" :prop="item.key" :key="i" v-if="!item.hide">
            <i-input v-if="item.type === 'input'" v-model="formData[item.key]" :placeholder="item.placeholder || '请输入...'">
              <span v-if="item.unit" slot="append">元/小时</span>
              <Button v-if="item.verifyCode" slot="append" @click="sendVerifyCode">
                {{ verifyCodeBtn + (typeof verifyCodeBtn === 'number' ? ' s' : '')  }}
              </Button>
            </i-input>

            <i-input v-if="item.type === 'textarea'" v-model="formData[item.key]" type="textarea" :placeholder="item.placeholder || '请输入...'"></i-input>
            
            <i-switch v-if="item.type === 'switch'" v-model="formData[item.key]" @on-change="changeSwitch" />
            
            <Select v-if="item.type === 'select'" v-model="formData[item.key]">
              <Option v-for="option in item.options" :value="option.value" :key="option.value">{{ option.label }}</Option>
            </Select>

            <CheckboxGroup v-if="item.type === 'checkbox'" v-model="formData[item.key]">
              <Checkbox v-for="(option, j) in item.options" :label="option.id" :key="j">
                <template v-if="!item.tooltip">
                  {{ option.name }}({{ option.price }}元)
                </template>
                <Tooltip v-if="item.tooltip">
                  {{ option.name }}({{ option.price }}元)
                  <div slot="content" style="white-space: normal">
                    <template v-for="(descrSpan, k) in option.descr">
                      <div :key="k">
                        {{ descrSpan }}
                      </div>
                    </template>
                  </div>
                </Tooltip>
                <InputNumber v-if="item.num" :min="1" size="small" v-model="formData['goodsQty'][option.id]" style="width:50px"></InputNumber>
              </Checkbox>
            </CheckboxGroup>

            <RadioGroup v-if="item.type === 'radio'" v-model="formData[item.key]">
              <Radio v-for="(option, i) in item.options" :label="option.label" :key="i">{{ option.name }}</Radio>
            </RadioGroup>

            <Row v-if="item.type === 'switchSelect'">
              <i-col span="3">
                <i-switch v-model="formData[item.key]" @on-change="changeSwitch" />
              </i-col>
              <i-col span="6" v-if="!item.hide2">
                <Select v-model="formData[item.key2]">
                  <Option v-for="option in item.options" :value="option.value" :key="option.value">{{ option.label }}</Option>
                </Select>
              </i-col>
            </Row>
          </FormItem>
        </template>
      </Form>
      <div class="drawer-footer">
        <Button style="margin-right: 8px" @click="addFlag = false">取消</Button>
        <Button type="primary" @click="submitForm">提交</Button>
      </div>
    </Drawer>
  </div>
</template>

<script>
  import { deepClone } from '@/common/js/util'
  import { apiUrl } from '@/serviceAPI.config.js'
  export default {
    props: {
      tableOptions: {
        type: Object,
        default: {}
      }
    },
    mounted() {
      this.getData()
      this.sendTimer = null
    },
    data() {
      return {
        loading: false,
        addFlag: false,
        updFlag: false,
        styles: {
          height: 'calc(100% - 55px)',
          overflow: 'auto',
          paddingBottom: '53px',
          position: 'static'
        },
        tableData: [],
        total: '',
        verifyCodeBtn: '发送验证码',
        sending: false
      }
    },
    computed: {
      tableColumns() {
        let columns = deepClone(this.tableOptions.tableColumns)
        let obj = {
          key: 'operate',
          title: '操作',
          render: (h, params) => {
            return h('div', [
              h('span', {
                class: {'operate-item' : true},
                on: {
                  click: () => {
                    this.tableOptions.vip ? this.recharge(params) : this.goUpdate(params)
                  }
                }
              }, this.tableOptions.vip ? '充值' : '更新'),
              h('span', {class: {'operate-divide' : true}}, '|'),
              h('span', {
                class: {'operate-item' : true},
                on: {
                  click: () => {
                    this.goDelete(params)
                  }
                }
              }, '删除')
            ])
          }
        }
        columns.push(obj)
        return columns
      },
      formData() {
        return this.tableOptions.formData
      }
    },
    methods: {
      sendVerifyCode() {
        const phone = this.formData.phone
        if (phone === '' || !/^1[34578]\d{9}$/.test(phone)) {
          this.$Message.error('手机号码有误')
          return
        }
        if (this.sending) {
          this.$Message.error('请稍后再发送')
          return
        }
        this.sending = true
        this.$http.post(apiUrl.sendVerifyCode, {
          data: {phone}
        }).then(res => {
          if (res.data.code === 200) {
            this.$Message.success(res.data.message)
            this.verifyCodeBtn = 60
            this.sendTimer = setInterval(() => {
              this.verifyCodeBtn -= 1
              if (this.verifyCodeBtn <= 0) {
                this.verifyCodeBtn = '发送验证码'
                this.sending = false
                clearInterval(this.sendTimer)
              }
            }, 1000)
          } else {
            this.sending = false
            this.$Message.error(res.data.message)
          }
        })
      },
      getData(params = {}) {
        this.loading = true
        this.$http.post(apiUrl[this.tableOptions.siftApi], {
          data: params
        }).then(res => {
          if (res.data.code === 200) {
            this.tableData = res.data.message
            this.total = res.data.count
          } else {
            this.tableData = []
            this.total = 0
          }
          this.loading = false
        })
      },
      goAdd() {
        this.updFlag = false
        this.addFlag = true
        this.$emit('edit', {type: 'add'})
        this.$refs.submitForm.resetFields()
      },
      goUpdate(params) {
        this.updFlag = true
        this.addFlag = true
        this.$emit('edit', {type: 'upd', params: deepClone(params)})
      },
      recharge(params) {
        this.$emit('recharge', {params: deepClone(params)})
      },
      goDelete(params) {
        this.$Modal.confirm({
          title: '确认删除',
          content: '此操作将删除该数据, 并且会影响到与之相关的数据, 是否继续?',
          onOk: () => {
            this.$http.post(apiUrl[this.tableOptions.delApi], {
              data: [params.row]
            }).then(res => {
              if (res.data.code === 200) {
                this.tableData.splice(params.index, 1)
                this.$Message.success(res.data.message)
              } else {
                this.$Message.error(res.data.message)
              }
            })
          }
        })
      },
      changeSwitch(status) {
        this.$emit('changeSwitch', status)
      },
      submitForm() {
        this.$refs.submitForm.validate((valid) => {
          if (!valid) {
            this.$Message.error('*号为必填项')
            return false
          }
          // console.log(this.formData)
          // return
          if (!this.updFlag) {
            this.$http.post(apiUrl[this.tableOptions.addApi], {
              data: [this.formData]
            }).then(res => {
              if (res.data.code === 200) {
                this.getData()
                this.$Message.success(res.data.message)
                this.addFlag = false
              } else {
                this.$Message.error(res.data.message)
              }
            })
          } else {
            this.$http.post(apiUrl[this.tableOptions.updApi], {
              data: this.formData
            }).then(res => {
              if (res.data.code === 200) {
                this.getData()
                this.$Message.success(res.data.message)
                this.addFlag = false
              } else {
                this.$Message.error(res.data.message)
              }
            })
          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .top-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 14px;
    margin-bottom: 10px;
  }
  .drawer-footer{
    width: 100%;
    position: absolute;
    bottom: 0;
    left: 0;
    border-top: 1px solid $color-gray;
    padding: 10px 16px;
    text-align: right;
    background: $color-white;
  }
</style>