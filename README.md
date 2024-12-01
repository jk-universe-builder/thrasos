# thrasos

Thrasos is a metrics gatherer, persistor, and visualizer.

It consists of three projects that form the application:
* initializer - initializes the volume with the prometheus configuration files.
* prometheus - gathering, persisting, visualizing via a dashboard.
* service-discovery - discovers k8s services that have metrics and provides those to prometheus.

## Initializer
The prometheus and service-discovery share the targets.json file.
To achieve this the targets.json is stored in the shared volume.
The initializer copies these files to the shared volume before these services start.



## Debugging

## Local
* Install prom.
...

## Docker

## Kube