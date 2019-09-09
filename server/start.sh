#!/bin/sh

# ******************************************
# jBPM Workbench - Docker image start script
# ******************************************

# Program arguments
#
# -c | --container-name:    The name for the created container.
#                           If not specified, defaults to "jbpm-workbench"
# -h | --help;              Show the script usage
#

CONTAINER_NAME="jbpm-server-full"
IMAGE_NAME="jboss/jbpm-server-full"
IMAGE_TAG="7.26.0.Final"


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
    docker stop $container_id
    docker rm $container_id
    rm -f docker.pid
fi

# Start the JBoss jBPM Server Full docker container
echo "Starting $CONTAINER_NAME docker container using:"
echo "** Container name: $CONTAINER_NAME"
image_jbpm_workbench=$(docker run -P -d --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG)
ip_jbpm_workbench=$(docker inspect $image_jbpm_workbench | grep -m 1 \"IPAddress\" | awk '{print $2}' | tr -d '",')
echo $image_jbpm_workbench > docker.pid

# End
echo ""
echo "Server starting in $ip_jbpm_workbench"
echo "You can access the server root context in http://$ip_jbpm_workbench:8080"
echo "jBPM Workbench is running at http://$ip_jbpm_workbench:8080/business-central"
echo "KIE Server Swagger documentation is running at http://$ip_jbpm_workbench:8080/kie-server/docs"
echo "jBPM Case Management Showcase is running at http://$ip_jbpm_workbench:8080/jbpm-casemgmt"

exit 0
