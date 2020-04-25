#!/bin/bash

# /Applications/wechatwebdevtools.app/Contents/MacOS/cli preview --project /Users/jackiegan/TestProject/taro_optimize_webpack/dist/

# /c/Program\ Files\ \(x86\)/Tencent/微信web开发者工具/cli.bat --project /d/TestProject/madp_test_leave

# appId wx0df06037fa379914

alias mpcli='/Applications/wechatwebdevtools.app/Contents/MacOS/cli'

mpcli open

ret = mpcli upload --project /Users/jackiegan/TestProject/taro_optimize_webpack/dist --appid wx0df06037fa379914 -v 0.1.1 -d 'test'

if [ ret ] echo 'result is ${ret}'



