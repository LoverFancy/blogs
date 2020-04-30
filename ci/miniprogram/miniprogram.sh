git checkout ${BRANCH}

npm i

alias mpcli='/Applications/wechatwebdevtools.app/Contents/MacOS/cli'

mpcli open

npm run build:weapp

mpcli upload --project ${WORKSPACE}/dist -v ${VERSION} -d ${DESC}

