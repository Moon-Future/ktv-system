<template>
  <div class="basetable-container">
    <div class="sift-wrapper" v-show="!addFlag">
      <div class="top-title">
        <h1>总数：25</h1>
        <Button type="primary" size="small" @click="addFlag = true">添加</Button>
      </div>
      <Table :columns="tableColumns" :data="tableOptions.tableData" size="small"></Table>
    </div>
    <Drawer
      title="新增"
      v-model="addFlag"
      width="50%"
      :mask-closable="false"
      :styles="styles">
      <Form :model="formData" :rules="tableOptions.ruleValidate || {}">
        <template v-for="(item, i) in tableOptions.formArray">
          <FormItem :label="item.title" :prop="item.key" :key="i">
            <i-input v-if="item.type === 'input'" v-model="formData[item.key]" :placeholder="item.placeholder || '请输入...'"></i-input>
            <i-input v-if="item.type === 'textarea'" v-model="formData[item.key]" type="textarea" :placeholder="item.placeholder || '请输入...'"></i-input>
            <CheckboxGroup v-if="item.type === 'checkbox'">
              <Checkbox label="香蕉"></Checkbox>
              <Checkbox label="苹果"></Checkbox>
              <Checkbox label="西瓜"></Checkbox>
            </CheckboxGroup>
          </FormItem>
        </template>
      </Form>
      <div class="drawer-footer">
          <Button style="margin-right: 8px" @click="addFlag = false">取消</Button>
          <Button type="primary" @click="addFlag = false">提交</Button>
      </div>
    </Drawer>
  </div>
</template>

<script>
  import { deepClone } from '@/common/js/util'
  export default {
    props: {
      tableOptions: {
        type: Object,
        default: {}
      }
    },
    data() {
      return {
        addFlag: false,
        styles: {
          height: 'calc(100% - 55px)',
          overflow: 'auto',
          paddingBottom: '53px',
          position: 'static'
        },
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
              h('span', {class: {'operate-item' : true}}, '详情'),
              h('span', {class: {'operate-divide' : true}}, '|'),
              h('span', {class: {'operate-item' : true}}, '更新'),
              h('span', {class: {'operate-divide' : true}}, '|'),
              h('span', {class: {'operate-item' : true}}, '删除')
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