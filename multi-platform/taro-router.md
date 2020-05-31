# Taro 1.0系列：taro-router原理分析

## Taro如何处理页面路由

为了多端统一的初衷，`Taro`在路由跳转的交互体验上，保持了小程序端和h5端的统一，即同一套代码，在h5和小程序端的跳转体验是一致的；如何理解`Taro处理页面路由`的方式，我们可以通过一个页面栈来表示路由的状态变化，`Taro`封装了多个路由API，每次调用路由API，都是对页面栈的一次进栈出栈操作：

- `Taro.navigateTo`：保留当前页面，并跳转到应用内某个页面，相当于把新页面`push`进页面栈；
- `Taro.redirectTo`：关闭当前页面，并跳转到应用内某个页面，相当于用新的页面替换掉旧的页面；
- `Taro.switchTab`：跳转到`tabBar`页面，目前h5不支持；
- `Taro.reLaunch`：关闭所有页面，打开到应用内的某个页面，相当于清空页面栈，并且将新页面`push`进栈底；
- `Taro.navigateBack`：关闭当前页面，返回上一页面或多级页面，相当于将页面`pop`出页面栈；

可以通过下图更加直观表示上述API和页面栈的关系：

![](./images/taro-router-stack.png)

在小程序端，Taro路由API将直接转换成调用原生路由API，也就是说，在微信小程序中，源代码中调用`Taro.navigateTo`，最终调用的是`wx.navigateTo`； 

而在H5端，Taro路由API将转换成调用`window.history`对象的API，那在H5端如何`管理页面栈和页面状态`，以及页面切换后，如何`加载和卸载页面(页面更新)`等的问题，将由本文的主角`taro-router`进行处理； 

## 页面状态的管理

## 页面更新

## 页面栈

内部维护一套history状态

业务代码中使用history api进行pushState，这个状态将不再内部维护的history状态中

## 路由拦截的实现

beforeRouteLeave



问题：

1、为什么在mode hash下使用window location href跳转路由，会触发hashchange

2、使用mode browser跳路由，会再向服务器发送请求吗？如果会，那mode hash会吗