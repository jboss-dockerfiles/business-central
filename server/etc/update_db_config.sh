#!/usr/bin/env bash

if [[ -z "$JBPM_DB_DRIVER" ]]; then
 export JBPM_DB_DRIVER="h2"
fi

if [[ -z "$JBPM_DB_HOST" ]]; then
 export JBPM_DB_HOST="localhost"
fi

if [[ -z "$JBPM_DB_PORT" ]]; then
 if [ "$JBPM_DB_DRIVER" == "mysql" ] && [ -z "$JBPM_DB_PORT" ]; then
    export JBPM_DB_PORT="3306"
 fi
 if [ "$JBPM_DB_DRIVER" == "postgres" ] && [ -z "$JBPM_DB_PORT" ]; then
     export JBPM_DB_PORT="5432"
  fi
fi

if [[ -z "$JBPM_DB_NAME" ]]; then
 export JBPM_DB_NAME="jbpm"
fi

if [[ -z "$JBPM_DB_USER" ]]; then
 export JBPM_DB_USER="jbpm"
fi

if [[ -z "$JBPM_DB_PASSWORD" ]]; then
 export JBPM_DB_PASSWORD="jbpm"
fi

if [ $JBPM_DB_DRIVER == "h2" ]; then
    echo "Using embedded H2 database configuration"
    exit 0
fi

echo ""
echo "Using Database settings:"
echo "Driver: $JBPM_DB_DRIVER"
echo "Host: $JBPM_DB_HOST"
echo "Port: $JBPM_DB_PORT"
echo "Name: $JBPM_DB_NAME"
echo "User: $JBPM_DB_USER"

# If cli file not found, exit.
CLI_FILE=./jbpm-$JBPM_DB_DRIVER-config.cli

echo "Updating driver config for database: $JBPM_DB_DRIVER"
if [ ! -f $CLI_FILE ]; then
    echo "Configuration file for Driver $JBPM_DB_DRIVER, does not exist, running H2 embedded database instead."
    exit 0
fi

sed -i "s/--user-name=jbpm/--user-name=$JBPM_DB_USER/" $CLI_FILE
sed -i "s/--password=jbpm/--password=$JBPM_DB_PASSWORD/" $CLI_FILE
sed -i "s/ServerName=localhost/ServerName=$JBPM_DB_HOST/" $CLI_FILE
sed -i "s/DatabaseName=jbpm/DatabaseName=$JBPM_DB_NAME/" $CLI_FILE
if [ "$JBPM_DB_DRIVER" == "mysql" ]; then
    sed -i "s/PortNumber=3306/PortNumber=$JBPM_DB_PORT/" $CLI_FILE
fi
if [ "$JBPM_DB_DRIVER" == "postgres" ]; then
    sed -i "s/PortNumber=5432/PortNumber=$JBPM_DB_PORT/" $CLI_FILE
fi

./jboss-cli.sh --file=$CLI_FILE
exit $?