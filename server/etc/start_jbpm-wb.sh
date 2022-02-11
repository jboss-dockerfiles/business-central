#!/usr/bin/env bash

# Start Wildfly with the given arguments.
echo "Update database connection setup"
./update_db_config.sh
echo "Running jBPM Server Full on JBoss Wildfly..."
exec ./standalone.sh -c standalone-full-ha.xml -b $JBOSS_BIND_ADDRESS $EXTRA_OPTS -Dorg.kie.server.location=$KIE_SERVER_LOCATION -Dorg.kie.server.id=$KIE_SERVER_ID -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true
exit $?
