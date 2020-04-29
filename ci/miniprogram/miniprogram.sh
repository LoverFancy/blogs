#!/bin/bash

# /Applications/wechatwebdevtools.app/Contents/MacOS/cli preview --project /Users/jackiegan/TestProject/taro_optimize_webpack/dist/

# appId wx0df06037fa379914

npm i

alias mpcli='/Applications/wechatwebdevtools.app/Contents/MacOS/cli'

mpcli open

npm run build:weapp

upload_ret=$(mpcli upload --project ${WORKSPACE}/dist --appid ${APPID} -v ${VERSION} -d ${DESC})

if [ $upload_ret == 0 ]
  then
  echo "上传成功!"
else
  echo "返回状态码${upload_ret}，上传失败!"
  exit 1
fi

