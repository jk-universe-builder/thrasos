
* Need to finish initalizer which will copy targets.json
  into /prometheus shared volume as an initContainer - should
  run as a standalone container when debugging in docker.
* Then prometheus and service-discoverer run - where service-discoverer
  will mutate /prometheus/targets.json and prometheus will be informed
  when that updates.