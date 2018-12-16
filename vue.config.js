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
  }
}