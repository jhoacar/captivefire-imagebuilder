DOCKER_TAG="ramips-mt76x8-openwrt-21.02";
PROFILE="tl-mr3020-v3";
COMMAND=$(echo $COMMAND | sed -E 's/luci|luci-ssl//g');