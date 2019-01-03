<template>
  <div class="login-container">
    <div class="login-wrapper">
      <h1>登录</h1>
      <div class="form-wrapper">
        <RadioGroup v-show="registerFlag" v-model="userType" class="radio-group">
          <Radio label="0">
              <span>收银员</span>
          </Radio>
          <Radio label="1">
              <span>管理员</span>
          </Radio>
        </RadioGroup>
        <Form ref="loginForm" label-position="right" :label-width="60" :model="formData" :rules="ruleValidate">
          <template v-for="(item, i) in formArray">
            <FormItem :label="item.title" :prop="item.key" :key="i" v-show="registerFlag || (item.key !== 'rePassword' && item.key !== 'code' && item.key !== 'name')">
              <i-input 
                v-if="!registerFlag && item.key === 'password'"
                v-model="formData[item.key]" 
                :type="item.type || 'text'" 
                :placeholder="item.placeholder || '请输入...'"
                @keyup.enter.native="login"></i-input>
              <i-input v-else v-model="formData[item.key]" :type="item.type || 'text'" :placeholder="item.placeholder || '请输入...'"></i-input>
            </FormItem>
          </template>
        </Form>
        <div class="tool-button" v-show="!registerFlag">
          <Button 
            type="primary" 
            :loading="subWait" 
            :class="subWait ? 'subWait' : ''" 
            @click="login">登陆</Button>
        </div>
        <div class="tool-button">
          <Button 
            type="success" 
            :loading="subWait && registerFlag" 
            :class="subWait && registerFlag ? 'subWait' : ''" 
            @click="register">注册</Button>
        </div>
        <div class="tool-button" v-show="registerFlag">
          <Button type="primary" @click="back">返回</Button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import IconFont from '@/components/IconFont'
  import { apiUrl } from '@/serviceAPI.config.js'
  const crypto = require('crypto')
  export default {
    data() {
      return {
        formArray: [
          {key: 'account', title: '账号', placeholder: '输入账号'},
          {key: 'password', title: '密码', type: 'password', placeholder: '输入密码'},
          {key: 'rePassword', title: '密码', type: 'password', placeholder: '确认密码'},
          {key: 'name', title: '姓名', placeholder: '输入姓名'},
          {key: 'code', title: '验证码', type: 'password', placeholder: '输入验证码'}
        ],
        formData: {
          account: '', password: '', rePassword: '', name: ''
        },
        ruleValidate: {
          account: [
            {required: true, message: '请输入昵称', trigger: 'blur'}
          ],
          password: [
            {required: true, message: '请输入密码', trigger: 'blur'}
          ],
          rePassword: [
            {required: true, message: '两次输入密码不同', trigger: 'blur'}
          ],
          code: [
            {required: true, message: '请输入验证码', trigger: 'blur'}
          ],
          name: [
            {required: true, message: '请输入姓名', trigger: 'blur'}
          ]
        },
        registerFlag: false,
        subWait: false,
        cookieInfo: {},
        userType: '0'
      }
    },
    created() {
      this.getSession()
    },
    methods: {
      getSession() {
        this.$http.post(apiUrl.getSession).then(res => {
          if (res.data.code === 200) {
            res.data.message.type == '0' ? this.$router.push({path: '/'}) : this.$router.push({path: '/admin/baseinfo/roominfo'})
          }
        })
      },
      register() {
        if (!this.registerFlag) {
          this.registerFlag = true
          this.clear()
          return
        }
        if (this.subWait) {
          return
        }
        this.$refs.loginForm.validate((valid) => {
          if (!valid) {
            this.$Message.error('请补充完整数据')
            return
          }
          if (this.formData.password !== this.formData.rePassword) {
            this.$Message.error('两次输入密码不同')
            return
          }
          this.subWait = true
          this.$http.post(apiUrl.register, {
            data: {
              name: this.formData.name,
              account: this.formData.account,
              password: crypto.createHash('sha1').update(this.formData.password.trim()).digest('hex'),
              code: this.formData.code,
              userType: this.userType
            }
          }).then(res => {
            this.subWait = false
            if (res.data.code === 200) {
              this.$Message.success(res.data.message)
              this.registerFlag = false
              this.formData.password = ''
              this.formData.rePassword = ''
              this.formData.code = ''
              this.formData.name = ''
              this.userType = '0'
            } else {
              this.$Message.error(res.data.message)
            }
          }).catch(err => {
            this.subWait = false
            this.$Message.error('服务器君傲娇啦😭')
          })
        })
      },
      login() {
        if (this.subWait) {
          return
        }
        if (this.formData.account === '' || this.formData.password === '') {
          this.$Message.error('请输入邮箱和密码')
          return
        }
        this.subWait = true
        this.$http.post(apiUrl.login, {
          data: {
            account: this.formData.account,
            password: crypto.createHash('sha1').update(this.formData.password.trim()).digest('hex')
          }
        }).then(res => {
          this.subWait = false
          if (res.data.code === 200) {
            this.$Message.success(res.data.message)
            res.data.userInfo.type == '0' ? this.$router.push({path: '/'}) : this.$router.push({path: '/admin/baseinfo/roominfo'})
          } else {
            this.$Message.error(res.data.message)
          }
        }).catch(err => {
          this.subWait = false
          this.$Message.error('服务器君傲娇啦😭')
        })
      },
      back() {
        if (this.subWait) {
          return
        }
        this.registerFlag = false
        this.clear()
      },
      clear() {
        this.$refs.loginForm.resetFields()
      }
    },
    components: {
      IconFont
    }
  }
</script>

<style lang="scss" scoped>
  @import '@/common/css/variable.scss';

  .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    background: $color-gray;
    .radio-group {
      text-align: left;
      margin-bottom: 10px;
    }
    .login-wrapper {
      width: 350px;
      padding: 10px;
      border: 1px solid $color-gray;
      box-shadow: 0 0 1px $color-gray;
      background-color: $color-white;
      border-radius: 5px;
      h1 {
        font-weight: bold;
        padding: 10px 0;
      }
      .form-wrapper {
        .tool-button {
          display: flex;
          flex-flow: column;
          padding: 10px 0;
        }
        .remember-wrapper {
          text-align: left;
        }
      }
    }
  }
</style>
