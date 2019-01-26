# Vue全家桶 之 KTV前台收银管理系统 (不想努力啦，回家收银去)

    年关将至，归心似箭。家里在小镇上接手了家小型KTV，发现之前的前台收银管理系统已无法使用，收银员竟然在纸上用笔记录着客人的点单，杂乱无章。之前的管理系统和网上查找的其他的一些系统都大同小异，且都是有些年份的，售后肯定指不上，再者也用不上大多功能，界面也不好看。于是本着学习的态度（收钱的快感）开始使用Vue定制化我们自己需要的 KTV前台收银管理系统。

## 基本业务需求
![基本业务需求](http://qiniu.cdn.cl8023.com/ktv/image/jpg/KTV%E6%94%B6%E9%93%B6%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F%E9%9C%80%E6%B1%82.png)

功能不多，但简单实用

## 技术点
- vue-cli 3.0 构建工具快速搭建项目
- vue-router 路由管理
- vuex 状态管理
- iview UI框架
- Node、Koa后端服务
- Mysql 数据库
- Echarts 
- 短信验证码发送

## 效果图
![收银账单](http://qiniu.cdn.cl8023.com/ktv/image/jpg/KTV%E7%95%8C%E9%9D%A21.png)

## 在线浏览
- 地址：[test.ktv.cl8023.com](//test.ktv.cl8023.com)
- 账号：admin
- 密码：123456
- 几百块钱的服务器，首次打开还请耐心等待... 
- 还没怎么认真测试过，遇到 bug 我改就是了...

## Github
[Moon-Future](https://github.com/Moon-Future/ktv-system)

数据表也在其中，有兴趣的同学可以 clone 下来自己耍哦~ 

server 文件夹下应有一个文件：secret.js 存储一些密匙，可以自己建立，内容如下：
```js
  module.exports = {
    rootCode: { // 注册权限选择
      0: 'xxxxxx',
      1: 'xxxxxx'
    },
    apikey: 'xxxxxxxxxxxx' // 短信验证码
  }
```

## 请原谅全篇没有什么干货（博客搭建、上线部署之前也写过一点），只是想分享一下学习的快乐。
毕竟
# 兴趣才是第一生产力