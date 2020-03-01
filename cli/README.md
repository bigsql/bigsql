# README for IO #

IO is the command line interface for PGSQL.IO

## Usage ##
```
io command [component] [options]
```

## Informational Commands ##
```
  help      - Display help file
  info      - Display OS or component information
  status    - Display status of installed server components
  list      - Display available/installed components 
```

## Service Control Commands ##
```
  start     - Start server components
  stop      - Stop server components
  reload    - Reload server configuration files (without a restart)
  restart   - Stop & then start server components
  enable    - Enable a component
  disable   - Disable a server server component from starting automatically
  config    - Configure a component
  init      - Initialize a component
```

## Software Install & Update Commands ##
```
  update    - Retrieve new lists of components
  upgrade   - Perform an upgrade of a component
  install   - Install (or re-install) a component  
  remove    - Un-install component   
  clean     - Delete downloaded component files
```

## Cloud Commands (coming soon) ##
```
  create-nodes \
    --cloud aws --region us-east-1 --zone us-east-1d \
    --image-os centos-7
    --node-type [ vm || bare-metal || container ] \
    --node-size [ xs, s, m, l, xl, 2xl - 24xl ] \
    --disk1-type gp2  --disk1-size 8 \
    --disk2-type ebs  --disk2-size 1000  --disk2-iops 15000 \
  start-node
  info-node
     status:, 
  stop-node
  terminate-node
```

## Cluster Commands (coming soon) ##
```
  create-cluster
  start-cluster
  stop-cluster
  terminate-cluster
```
  

## Advanced Commands ##
```
  top        - Cross platform version of the "top" command 
  get        - Retrieve a setting
  set        - Populate a setting
  unset      - Remove a setting 
  create-node
```
