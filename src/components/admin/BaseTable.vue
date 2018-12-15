<template>
  <div class="basetable-container">
    <div class="sift-wrapper" v-show="!addFlag">
      <div class="top-title">
        <h1>总数：25</h1>
        <el-button type="primary" size="mini" @click="goAdd">添加</el-button>
      </div>
      <el-table
        :data="tableOptions.siftData"
        size="small"
        :stripe="true"
        :header-cell-style="{background:'#f1f1f1', color:'black'}"
        style="width: 100%">
          <template v-for="(item, i) in siftField">
            <el-table-column :min-width="item.minWidth ? item.minWidth : ''" :prop="item.prop" :label="item.label" :key="i"></el-table-column>
          </template>
          <el-table-column width="150" label="操作">
            <template slot-scope="scope">
              <span class="operate-item">详情</span>
              <span class="operate-divide">|</span>
              <span class="operate-item">修改</span>
              <span class="operate-divide">|</span>
              <span class="operate-item">删除</span>
            </template>
          </el-table-column>
      </el-table>
    </div>
    <div class="add-wrapper" v-show="addFlag">
      <div class="top-title">
        <h1></h1>
        <el-button type="primary" size="mini" @click="goSift">返回</el-button>
      </div>
      <div class="add-form">
        <el-form :label-position="labelPosition" size="small" label-width="80px">
          <template v-for="(item, i) in addField">
            <el-form-item :label="item.label" :key="i">
              <el-input v-if="item.type === 'input'" size="small" :placeholder="item.placeholder || '请输入内容'"></el-input>
              <el-input v-if="item.type === 'textarea'" size="small" type="textarea" :rows="5" :placeholder="item.placeholder || '请输入内容'"></el-input>
              <el-checkbox v-if="item.type === 'checkbox'">套餐一</el-checkbox>
              <el-checkbox v-if="item.type === 'checkbox'">套餐二</el-checkbox>
            </el-form-item>
          </template>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
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
        labelPosition: 'right'
      }
    },
    methods: {
      goAdd() {
        this.addFlag = true
      },
      goSift() {
        this.addFlag = false
      }
    },
    computed: {
      siftField() {
        return this.tableOptions.siftField || this.tableOptions.addField
      },
      addField() {
        return this.tableOptions.addField
      },
    }
  }
</script>

<style lang="scss" scoped>
  .top-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 14px;
    margin-bottom: 10px;
  }
  .operate-item:hover {
    cursor: pointer;
    text-decoration: underline;
  }
  .operate-divide {
    margin: 0 5px;
  }
  .add-wrapper .add-form {
    text-align: left;
  }
</style>