#!/bin/sh

# *********************************************************************
# JBoss Business-Central Workbench Showcase - Docker image start script
# *********************************************************************

# Program arguments
#
# -c | --container-name:    The name for the created container.
#                           If not specified, defaults to "jbpm-workbench-showcase"
# -h | --help;              Show the script usage
#

CONTAINER_NAME="business-central-workbench-showcase"
IMAGE_NAME="kiegroup/business-central-workbench-showcase"
IMAGE_TAG="7.74.1.Final"


function usage
{
     echo "usage: start.sh [ [-c <container_name> ] ] [-h]]"
}

while [ "$1" != "" ]; do
    case $1 in
        -c | --container-name ) shift
                                CONTAINER_NAME=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

# Check if container is already started
if [ -f docker.pid ]; then
    echo "Container already started"
    container_id=$(cat docker.pid)
    echo "Stopping container $container_id..."
    # In case you want to use Docker please use `docker` instead of `podman`
    podman stop $container_id
    rm -f docker.pid
fi

# Start the JBoss jBPM Workbench docker container
echo "Starting $CONTAINER_NAME docker container using:"
echo "** Container name: $CONTAINER_NAME"
image_business_central=$(podman run -P -d --network=host --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG)
echo $image_business_central > docker.pid

# End
echo ""
echo "Server starting ..."
# In windows the IP is correct, but the correct port can be seen for example from the docker UI container data.
echo "You can access the server root context in http://localhost:8080"
echo "JBoss Business-Central Workbench is running at http://localhost:8080/business-central"

# In case you want use Docker instead of Podman please use:
# Start the JBoss jBPM Workbench docker container
#echo "Starting $CONTAINER_NAME docker container using:"
#echo "** Container name: $CONTAINER_NAME"
#image_business_central=$(docker run -P -d --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG)
#ip_business_central=$(docker inspect $image_business_central | grep -m 1 \"IPAddress\" | awk '{print $2}' | tr -d '",')
#echo $image_business_central > docker.pid
#
## End
#echo ""
#echo "Server starting in $ip_business_central"
#echo "You can access the server root context in http://$ip_business_central:8080"
#echo "JBoss Business-Central Workbench is running at http://$ip_business_central:8080/business-central"

exit 0
