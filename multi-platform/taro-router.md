# 进击的Taro 1.0系列：taro-router原理分析

## Taro路由系统

为了多端统一的初衷，`Taro`在路由跳转的交互体验上，保持了小程序端和h5端的统一，即同一套代码，在h5和小程序端的跳转体验是一致的；如何理解`Taro路由系统`，我们可以通过一个页面栈来表示路由的状态变化：







内部维护一套history状态

业务代码中使用history api进行pushState，这个状态将不再内部维护的history状态中

## beforeRouteLeave的实现



问题：

1、为什么在mode hash下使用window location href跳转路由，会触发hashchange

2、使用mode browser跳路由，会再向服务器发送请求吗？如果会，那mode hash会吗