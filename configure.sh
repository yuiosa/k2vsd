#!/bin/sh
# V2Ray generate configuration
# Download and install V2Ray
config_path=$PROTOCOL"_ws_tls.json"
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
# Remove temporary directory
rm -rf /tmp/v2ray
# V2Ray new configuration
install -d /usr/local/etc/v2ray
envsubst '\$UUID,\$WS_PATH' < $config_path > /usr/local/etc/v2ray/config.json
# Run V2Ray
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json &
# print config
echo "V2ray 配置信息"
echo "地址（address）：$HEROKU_APP_NAME.herokuapp.com"
echo "端口（port）：443 "
echo "用户id（UUID）：$UUID"
if [ "$PROTOCOL" = "vmess" ]
then
    echo "额外id（alterId）： 64"
fi
echo "加密方式（security）： 自适应"
echo "传输协议（network）： ws"
echo "伪装类型（type）： none"
echo "路径：$WS_PATH"
echo "底层传输安全： tls "
if [ "$PROTOCOL" = "vmess" ]
then
    vmess_link=$(printf "%s""{\"add\":\"$HEROKU_APP_NAME\","aid":64,"host":\"\",\"id\":\"$UUID\",\"net\":\"ws\",\"path\":\"$WS_PATH\",\"port\":443,\"ps\":\"h1\",\"tls\":\"tls\",\"type\":\"none\",\"v\":2}" | base64)
echo "vmess客户端地址：vmess://"$vmess_link
fi
# Run nginx
/bin/bash -c "envsubst '\$PORT,\$WS_PATH' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'