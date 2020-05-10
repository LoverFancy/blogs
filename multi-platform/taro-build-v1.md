# 进击的Taro 1.0系列：taro build原理分析

众所周知，`taro-cli`是Taro脚手架初始化和项目构建的的命令行工具，它的实现原理，相信大家从[Taro 技术揭秘：taro-cli](https://juejin.im/post/5b3ce041e51d45194832aaf6)这篇文章中已经有所了解；本文将对其中的项目构建`build`命令进行分析，从`cli`层面了解`taro`构建的过程到底做了什么；

### 命令注册

在执行`npm install -g @tarojs/cli`时，`npm`通过`package.json`文件中的`bin`字段，将`taro`这个命令注册到`[prefix]/bin`中作为全局命令； 
或者在当前项目目录下，执行`npm install @tarojs/cli`，将taro这个命令注册到`./node_modules/.bin/`底下作为本地命令；

```js
"bin": {
  "taro": "bin/taro"
}
```

由于`npm config get prefix`为`/usr/local`，所以全局命令将会被注册到`/usr/local`目录底下，通过`symlink`符号链接的方式，使得`/usr/local/bin/taro`指向`/usr/local/lib/node_modules/@tarojs/cli/bin/taro`；

### build命令触发

`bin/taro`文件作为`taro-cli`的入口，使用`commander.js`来解析命令和参数，支持`git`风格的子命令处理，可以根据子命令自动引导到`[command]-[subcommand]`格式命名的执行文件； 

`taro build`命令则被自动引导到`bin/taro-build`文件下，

### 目录结构

### build命令的核心逻辑

### 结语