## v2ray-heroku
[![](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/libsgh/v2ray-heroku.git)

### heroku上部署v2ray
- [x] 支持vmess和vless两种协议
- [x] 支持自定义websocket路径
- [x] 可访问首页（3D元素周期表）
- [x] 使用v2ray最新版构建
、
### 环境变量说明

|  名称 | 值  | 说明  |
| ------------ | ------------ | ------------ |
|  PROTOCOL |  vmess<br>vless（可选） |  协议：nginx+vmess+ws+tls或是nginx+vless+ws+tls |
|  UUID |  [uuid在线生成器](https://www.uuidgenerator.net "uuid在线生成器") | 用户主ID  |
|  WS_PATH | 默认为`/ray` |  路径 |