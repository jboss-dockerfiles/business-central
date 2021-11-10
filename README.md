KIE Business-Central Workbench Docker images
==============================================

KIE Business-Central Workbench [Docker](http://docker.io/) image.
From version 7.61.0.Final we changed the location for our docker images from [Docker](http://docker.io/) to [RedHat Quay](https://quay.io)

The 7.61.0.Final version will have the images at both locations (Docker and Quay).

From the versions > 7.61.0.Final on the images will only be available on Quay.

This module provides the community KIE Business-Central Workbench images.

There are three available images:

**business-central-workbench**

It's the base Docker image for JBoss Business-Central Workbench. It's purpose is to be used as base for extending and creating your own images that uses JBoss Business-Central Workbench.
 
**business-central-workbench-showcase**

It inherits from KIE Business-Central Workbench image and provides a **ready to run Quay image for KIE Business-Central Workbench**.
It provides some custom configurations and default users and roles to try and test the workbench. 

**jBPM Server Full distribution**

Provides a **ready to run Docker image for jBPM server full** with all necessary configurations between services.
Deployed applications include: jBPM Workbench, Kie Server and jBPM Case Management Showcase.
For more information, please visit the [Getting Started Guide](http://jbpm.org/learn/gettingStarted.html)
It provides some custom configurations and default users and roles to try and test the workbench.



