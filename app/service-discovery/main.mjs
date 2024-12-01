import k8s from "@kubernetes/client-node";
import process from "process";
import fs from "fs";

const SERVICE_DISCOVERY_FREQUENCY_MS = process.env.SERVICE_DISCOVERY_FREQUENCY_MS;

const kc = new k8s.KubeConfig();
kc.loadFromDefault();
const k8sApi = kc.makeApiClient( k8s.CoreV1Api );

/** @returns { Promise< import( "./types/PodAddress.mjs" ).PodAddress[] > } */
const getPromAddressesFromPods = async () => {

    // Select pods with prometheus metrics.
    const podAddessesWithPrometheus = [];
    try {

        const podsResponse = await k8sApi.listNamespacedPod( 
            'default', 
            undefined,
            undefined,
            undefined,
            undefined,
            "metrics=prometheus"
        );

        if( podsResponse.response.statusCode !== 200 ) {
            throw new Error( `Failed to list pods. Status Code: ${ podsResponse.response.statusCode }` );
        }

        for( const pod of podsResponse.body.items ) {

            /** @type { string | undefined } */
            const podIP = pod?.status?.podIP;

            // Skip if pod doesn't have IP yet.
            if( podIP === undefined ) continue;

            /** @type { string | undefined } */
            const promPort = pod.metadata.annotations[ "prometheus.io/port" ];

            /** @type { import( "./types/PodAddress.mjs" ).PodAddress } */
            const podAddress = { IP: podIP, port: promPort };

            podAddessesWithPrometheus.push( podAddress );
            
        }
        // Select pods with a label

    } catch( err ) {

        console.error( err );

    }

    return podAddessesWithPrometheus;

}

const discoverServices = async () => {

    const podIPsWithPrometheus = await getPromAddressesFromPods();

    const podTargets = podIPsWithPrometheus.map( address => {
        return {
            labels: [
                `job=pod-metrics` // See prometheus configuration file.
            ],
            targets: [ 
                `${ address.IP }:${ address.port }` 
            ]
        };
    });

    // Add prometheus itself.
    podTargets.push( { IP: "localhost", port: "9090" } );

    // Write targets.
    fs.writeFileSync( "/etc/prometheus/targets.json", JSON.stringify( podTargets, null, 2 ) );

    setTimeout( async () => { discoverServices(); }, SERVICE_DISCOVERY_FREQUENCY_MS );

};

const main = async () => {

    discoverServices();    

};
main();
