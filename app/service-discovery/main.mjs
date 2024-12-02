import k8s from "@kubernetes/client-node";
import process from "process";
import fs from "fs";
import path from "path";

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

            if( pod.metadata.annotations === undefined ) continue;
            if( pod.metadata.annotations[ "prometheus.io/port" ] === undefined ) continue;

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

    const podTargets = {
        labels: {
            job: "pod-metrics" // See prometheus configuration file.
        },
        targets: []
    };

    for( const address of podIPsWithPrometheus ) {

        podTargets.targets.push( `${ address.IP }:${ address.port }` );

    }
    
    // Make all targets.
    const targets = [ podTargets ]; // Add more targets here in the future (node targets etc).

    // Write targets.
    const pathToTargetsFile = path.join( "/", "prometheus", "targets.json" );
    fs.writeFileSync( pathToTargetsFile, JSON.stringify( targets, null, 2 ) );

    setTimeout( async () => { discoverServices(); }, SERVICE_DISCOVERY_FREQUENCY_MS );

};

const main = async () => {

    discoverServices();    

};
main();
