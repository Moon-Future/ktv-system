import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/front/Home.vue'
import Login from './views/front/Login.vue'
import Ktv from './views/front/Ktv.vue'
import Vip from './views/admin/Vip.vue'
import Admin from './views/admin/Admin.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
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
      children: [
        {
          path: 'baseinfo',
          name: 'baseinfo',
          component: () => import('@/views/admin/BaseInfo.vue'),
          children: [
            {
              path: 'roominfo',
              name: 'roominfo',
              component: () => import('@/views/admin/RoomInfo.vue'),
            },
            {
              path: 'roomtype',
              name: 'roomtype',
              component: () => import('@/views/admin/RoomType.vue'),
            },
            {
              path: 'goodsinfo',
              name: 'goodsinfo',
              component: () => import('@/views/admin/GoodsInfo.vue'),
            },
            {
              path: 'packageinfo',
              name: 'packageinfo',
              component: () => import('@/views/admin/PackageInfo.vue'),
            },
            {
              path: 'unitinfo',
              name: 'unitinfo',
              component: () => import('@/views/admin/UnitInfo.vue'),
            }
          ]
        },
        {
          path: 'vip',
          name: 'vip',
          component: () => import('@/views/admin/Vip.vue')
        },
        {
          path: 'user',
          name: 'user',
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
