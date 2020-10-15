// import Vue from 'vue'
// import Router from 'vue-router'
import Home from './views/front/Home.vue'
import Login from './views/front/Login.vue'
import Ktv from './views/front/Ktv.vue'
import OrderHistory from './views/front/OrderHistory.vue'
import Vip from './views/admin/Vip.vue'
import Admin from './views/admin/Admin.vue'
import axios from 'axios'
import { apiUrl } from '@/serviceAPI.config.js'
import store from './store/index'
import { Message } from 'iview'

Vue.use(VueRouter)

const router = new VueRouter({
  // mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      redirect: '/ktv',
      component: Home,
      children: [
        {
          path: '/ktv',
          name: 'ktv',
          component: Ktv
        },
        {
          path: '/order',
          name: 'order',
          component: OrderHistory
        },
        {
          path: '/vip',
          name: 'vip',
          component: Vip
        }
      ]
    },
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/admin',
      name: 'admin',
      component: Admin,
      meta: {
        root: 1 // root 权限为1才可进入
      },
      children: [
        {
          path: 'report',
          name: 'report',
          meta: {
            root: 1 // root 权限为1才可进入
          },
          component: () => import('@/views/admin/reportForm')
        },
        {
          path: 'baseinfo',
          name: 'baseinfo',
          meta: {
            root: 1 // root 权限为1才可进入
          },
          component: () => import('@/views/admin/BaseInfo.vue'),
          children: [
            {
              path: 'roominfo',
              name: 'roominfo',
              meta: {
                root: 1 // root 权限为1才可进入
              },
              component: () => import('@/views/admin/RoomInfo.vue'),
            },
            {
              path: 'roomtype',
              name: 'roomtype',
              meta: {
                root: 1 // root 权限为1才可进入
              },
              component: () => import('@/views/admin/RoomType.vue'),
            },
            {
              path: 'goodsinfo',
              name: 'goodsinfo',
              meta: {
                root: 1 // root 权限为1才可进入
              },
              component: () => import('@/views/admin/GoodsInfo.vue'),
            },
            {
              path: 'packageinfo',
              name: 'packageinfo',
              meta: {
                root: 1 // root 权限为1才可进入
              },
              component: () => import('@/views/admin/PackageInfo.vue'),
            },
            {
              path: 'unitinfo',
              name: 'unitinfo',
              meta: {
                root: 1 // root 权限为1才可进入
              },
              component: () => import('@/views/admin/UnitInfo.vue'),
            }
          ]
        },
        {
          path: 'vip',
          name: 'vip',
          meta: {
            root: 1 // root 权限为1才可进入
          },
          component: () => import('@/views/admin/Vip.vue')
        },
        {
          path: 'user',
          name: 'user',
          meta: {
            root: 1 // root 权限为1才可进入
          },
          component: () => import('@/views/admin/User.vue')
        }
      ]
    }
    // {
    //   path: '/about',
    //   name: 'about',
    //   // route level code-splitting
    //   // this generates a separate chunk (about.[hash].js) for this route
    //   // which is lazy-loaded when the route is visited.
    //   component: () => import(/* webpackChunkName: "about" */ './views/About.vue')
    // }
  ]
})

router.beforeEach((to, from, next) => {
  if (to.name !== 'login') {
    axios.post(apiUrl.getSession).then(res => {
      if (res.data.code === 200) {
        store.commit('SET_USERINGO', res.data.message)
        let root = to.meta && to.meta.root
        if (root === 1 && res.data.message.root != 1) {
          Message.error('没有权限')
          next({ path: '/ktv' })
        } else {
          next()
        }
      } else {
        Message.info(res.data.message)
        next({ path: '/login' })
      }
    }).catch(err => {
      next({ path: '/login' })
    })
  } else {
    next()
  }
})

export default router
