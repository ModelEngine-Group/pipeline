#!/bin/sh
set -e

umask 0007
# root下更改pvc存储及必要文件属主为runtime，组为appengine
mkdir -p ${LOG_HOME}
chown -R runtime:appengine ${LOG_HOME}
chmod -R 750 ${LOG_HOME}
chown -R runtime:appengine /log
chmod 750 /log

chown -R runtime:appengine /tmp
chmod -R 640 /var/log/*.log
mkdir -p ${ENTRY_PLUGINS_PATH}/java
chmod 770 ${ENTRY_PLUGINS_PATH}/java
chown runtime:appengine ${ENTRY_PLUGINS_PATH}/java

/fitframework/bin/fit start -Xms250m -Xmx3500m \
#-Dlog4j2.configurationFile=/fitframework/conf/log4j2.xml \
-Dserver.http.port=8090 \
-Dserver.http.to-register-port=8090 \
#-Dserver.http.is-ssl-enabled=false \
-Dmatata.registry.protocol=2 \
#-Dclient.http.secure.ignore-trust=true \
-Dplugin.registry.listener.mode=pull \
-Dmatata.registry.port=8004
