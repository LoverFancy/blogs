# 进击的Taro 1.0系列：taro build原理分析

众所周知，`taro-cli`是Taro脚手架初始化和项目构建的的命令行工具，它的实现原理，相信大家从[Taro 技术揭秘：taro-cli](https://juejin.im/post/5b3ce041e51d45194832aaf6)这篇文章中已经有所了解；本文将对其中的项目构建`build`命令进行分析，从`cli`层面了解`taro`构建的过程到底做了什么；

### build命令的注册

在执行`npm install -g @tarojs/cli`时，`npm`通过读取`package.json`文件中的`bin`字段，将`taro`这个命令注册到`[prefix]/bin`中作为全局命令； 
如果在当前项目目录下，执行`npm install @tarojs/cli`，则会将taro这个命令注册到`./node_modules/.bin/`底下作为本地命令；

```js
// package.json
"bin": {
  "taro": "bin/taro"
}
```

由于`npm config get prefix`为`/usr/local`，所以全局命令将会被注册到`/usr/local`目录底下，通过`symlink`符号链接的方式，使得`/usr/local/bin/taro`指向`/usr/local/lib/node_modules/@tarojs/cli/bin/taro`； 

`bin/taro`文件作为`taro-cli`的入口，内部使用`commander.js`来解析命令中的参数，并且支持`git`风格的子命令处理，可以根据子命令自动引导到`[command]-[subcommand]`格式命名的执行文件； 

所以当执行`taro build`命令时，则被`commander.js`自动引导到`bin/taro-build`文件下，继而执行`bin/taro-build`的逻辑； 

### build命令的分发

`taro build`命令功能非常多，它能够支持：

- 1、构建`H5`；
```sh
taro build --type h5
```
- 2、构建小程序及小程序插件，支持`weapp/swan/alipay/tt/qq/jd`类型；
```sh
// 小程序
taro build --type weapp
// 小程序插件
taro build --plugin weapp
```
- 3、构建UI库；
```sh
cross-env TARO_BUILD_TYPE=component taro build --ui
```

`taro-build`接收`--type`参数的值，接收到的结果交由`dist/build.js`的`build`函数进行判断，通过判断不同`type`的值，决定执行对应平台构建类型的逻辑，例如，当`--type`为`h5`时，则执行`dist/h5/index.js`文件中`build`函数的逻辑；当`--type`为`weapp`时，则执行`dist/mini/index.js`文件中`build`逻辑；

### h5的构建逻辑

`h5`的构建流程主要经过：`源代码` => `中间代码` => `目标代码`的转换； 其中：

- 源代码：一般是指`src`目录底下的代码，如果`config`中有配置`sourceRoot`，则源代码入口就为`sourceRoot`；
- 中间代码：指`.temp`目录下的代码，由`taro-build`实现的中间流程，主要通过`babel`实现中间代码的转换和生成；
- 目标代码：指最终运行在浏览器的代码，一般指`dist`目录下的代码，如果`config`中配置`outputRoot`，则目标代码将输出在`outputRoot`；

所以，三种代码间的转换关系可以用下图表示：

![](./images/taro-build-workflow.png)

`taro-build`帮助将源代码转换成中间代码，并保存在`.temp`文件夹中，中间代码再交由`webpack`进行打包构建生成目标代码；

#### 中间代码的生成

为什么会有中间代码生成这个步骤呢，这是因为


#### 

### 结语