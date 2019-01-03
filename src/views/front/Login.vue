<template>
  <div class="login-container">
    <div class="login-wrapper">
      <h1>登录</h1>
      <div class="form-wrapper">
        <Form ref="submitForm" label-position="left" :label-width="50" :model="formData" :rules="ruleValidate">
          <template v-for="(item, i) in formArray">
            <FormItem :label="item.title" :prop="item.key" :key="i">
              <i-input v-model="formData[item.key]" :placeholder="item.placeholder || '请输入...'"></i-input>
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
        <div class="tool-button" v-show="!registerFlag">
          <Button type="warning" @click="goHome">返回主页</Button>
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
          {key: 'name', title: '账号', placeholder: '输入账号'},
          {key: 'password', title: '密码', type: 'password', placeholder: '输入密码'},
          {key: 'rePassword', title: '密码', type: 'rePassword', placeholder: '确认密码'}
        ],
        formData: {
          name: '', password: '', rePassword: ''
        },
        ruleValidate: {
          name: [
            {required: true, message: '请输入昵称', trigger: 'blur'}
          ],
          password: [
            {required: true, message: '请输入密码', trigger: 'blur'}
          ],
          rePassword: [
            {required: true, message: '两次输入密码不同', trigger: 'blur'}
          ]
        },
        registerFlag: false,
        subWait: false,
        checked: false,
        password: '',
        cookieInfo: {}
      }
    },
    beforeCreate() {
      // this.$http.post(apiUrl.getSession).then(res => {
      //   if (res.data.code === 200) {
      //     this.$router.push('/admin/selfinfo')
      //   }
      // })
    },
    methods: {
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
            this.$message.error('请补充完整数据')
            return
          }
          if (this.form.password !== this.form.rePassword) {
            this.$message.error('两次输入密码不同')
            return
          }
          this.subWait = true
          this.$http.post(apiUrl.register, {
            data: {
              email: this.form.email,
              password: crypto.createHash('sha1').update(this.form.password.trim()).digest('hex'),
              name: this.form.name,
              website: this.form.website
            }
          }).then(res => {
            this.subWait = false
            if (res.data.code === 200) {
              this.$message.success(res.data.message)
              this.registerFlag = false
              this.form.password = ''
              this.form.rePassword = ''
              this.form.name = ''
              this.form.website = ''
            } else {
              this.$message.error(res.data.message)
            }
          }).catch(err => {
            this.subWait = false
            this.$message.error('服务器君傲娇啦😭')
          })
        })
      },
      login() {
        if (this.subWait) {
          return
        }
        if (this.form.email === '' || this.form.password === '') {
          this.$message.error('请输入邮箱和密码')
          return
        }
        this.subWait = true
        this.$http.post(apiUrl.login, {
          data: {
            email: this.form.email,
            password: crypto.createHash('sha1').update(this.form.password.trim()).digest('hex')
          }
        }).then(res => {
          this.subWait = false
          if (res.data.code === 200) {
            this.$message.success(res.data.message)
            this.$router.push('/admin/selfinfo')
          } else {
            this.$message.error(res.data.message)
          }
        }).catch(err => {
          this.subWait = false
          this.$message.error('服务器君傲娇啦😭')
        })
      },
      back() {
        if (this.subWait) {
          return
        }
        this.registerFlag = false
        this.clear()
      },
      goHome() {
        this.$router.push('/')
      },
      clear() {
        this.$refs.loginForm.resetFields()
        this.form.email = ''
        this.form.password = ''
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
    .avatar-wrapper {
      width: 100px;
      height: 100px;
      margin-right: 50px;
      cursor: pointer;
      position: relative;
      img {
        width: 100%;
        border-radius: 50%;
      }
      .click-msg {
        position: absolute;
        top: 50px;
        color: $color-white;
        font-size: 12px;
        text-align: center;
        width: 100%;
      }
    }
    .login-wrapper {
      width: 350px;
      padding: 10px;
      border: 1px solid $color-gray;
      box-shadow: 0 0 1px $color-gray;
      background-color: $color-white;
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
