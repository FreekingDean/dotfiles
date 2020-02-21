require 'json'

override = {
  spec: {
    containers: [{
      volumeMounts: [{
        mountPath: '/storage',
        name: 'storage'
      }]
    }],
    volumes: [{
      name: 'storage',
      hostPath: '/storage'
    }]
  }
}.to_json
`KUBECONFIG=~/.kube/config-server kubectl --insecure-skip-tls-verify run -i --tty synstart --image=matrixdotorg/synapse --env="SYNAPSE_SERVER_NAME=riot.public.deangalvin.com" --env="SYNAPSE_REPORT_STATS=yes" --restart=Never --rm --overrides='
`
