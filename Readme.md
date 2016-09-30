# Barman container

You are supposed to mount config-files in `/etc/barman.d`.

On Kubernetes/Openshift, there are plans to supply a supplementary container
that watches pods with `butter.sh/barman`-annotations and configures
a configMap automatically.
