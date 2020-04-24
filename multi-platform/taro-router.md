# 进击的Taro系列：taro-router原理分析

内部维护一套history状态

业务代码中使用history api进行pushState，这个状态将不再内部维护的history状态中

beforeRouteLeave的实现



问题：

1、为什么在mode hash下使用window location href跳转路由，会触发hashchange

2、使用mode browser跳路由，会再向服务器发送请求吗？如果会，那mode hash会吗