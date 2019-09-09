############################################################################
# Dockerfile that provides the image for JBoss jBPM Server Full 7.26.0.Final
############################################################################

####### BASE ############
FROM jboss/wildfly:14.0.1.Final

####### MAINTAINER ############
MAINTAINER "Michael Biarnes Kiefer" "mbiarnes@redhat.com"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://download.jboss.org/jbpm/release
ENV KIE_VERSION 7.26.0.Final
ENV KIE_CLASSIFIER wildfly14
ENV KIE_CONTEXT_PATH business-central
ENV KIE_SERVER_ID sample-server
ENV KIE_SERVER_LOCATION http://localhost:8080/kie-server/services/rest/server
ENV EXTRA_OPTS -Dorg.jbpm.ht.admin.group=admin -Dorg.uberfire.nio.git.ssh.host=$JBOSS_BIND_ADDRESS

####### JBPM-WB ############
RUN curl -o $HOME/jbpm-server-dist.zip $KIE_REPOSITORY/$KIE_VERSION/jbpm-server-$KIE_VERSION-dist.zip && \
unzip -o -q jbpm-server-dist.zip -d $JBOSS_HOME &&  \
rm -rf $HOME/jbpm-server-dist.zip

####### CONFIGURATION ############
USER root
ADD etc/start_jbpm-wb.sh $JBOSS_HOME/bin/start_jbpm-wb.sh
ADD etc/update_db_config.sh $JBOSS_HOME/bin/update_db_config.sh
RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/*
RUN chown jboss:jboss $JBOSS_HOME/bin/start_jbpm-wb.sh
RUN chown jboss:jboss $JBOSS_HOME/bin/update_db_config.sh
RUN sed -i '/<property name="org.kie.server.location" value="http:\/\/localhost:8080\/kie-server\/services\/rest\/server"\/>/d' $JBOSS_HOME/standalone/configuration/standalone.xml
RUN sed -i '/<property name="org.kie.server.id" value="sample-server"\/>/d' $JBOSS_HOME/standalone/configuration/standalone.xml

####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss

####### EXPOSE INTERNAL JBPM GIT PORT ############
EXPOSE 8001

####### RUNNING JBPM-WB ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_jbpm-wb.sh"]
