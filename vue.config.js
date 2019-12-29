const CompressionPlugin = require('compression-webpack-plugin')

module.exports = {
  devServer: {
    proxy: {
      '/api': {
        target: 'http://localhost:8889/api',
        changeOrigin: true,
        pathRewrite: {
          '^/api': ''
        }
      }
    }
  },
  productionSourceMap: false,
  configureWebpack: {
    externals: {
      'vue': 'Vue',
      'vue-router': 'VueRouter',
      'axios': 'axios',
      'vuex': 'Vuex'
     },
  },
  configureWebpack: config => {
    if (process.env.NODE_ENV === 'production') {
      return {
        plugins: [new CompressionPlugin({
          test: /\.js$|\.html&|\.css/,
          threshold: 10204,
          deleteOriginalAssets: false
        })]
      }
    }
  }
}