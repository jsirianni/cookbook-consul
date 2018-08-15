#!/bin/bash

# Initial converge without agents
kitchen converge consul-0
kitchen converge consul-1
kitchen converge consul-2


# Get the master token. xargs will strip the quotes, awk will return the token
MASTER_TOKEN=`cat .kitchen.yml | grep master_token | xargs | awk '{print $2}'`


# Create the agent token and store resp as in $X
X=`curl --request PUT --header "X-Consul-Token: $MASTER_TOKEN" --data \
'{
  "Name": "Agent Token",
  "Type": "client",
  "Rules": "node \"\" { policy = \"write\" } service \"\" { policy = \"read\" }"
}' http://10.0.3.240:8500/v1/acl/create`


# Parse the token from the api response
AGENT_TOKEN=`echo $X | cut -c7- | tr -d '}' | tr -d '"'`


# Place the token into the kitchen config
sed -i '' "s/dummy_agent_token/${AGENT_TOKEN}/" .kitchen.yml


# Converge all nodes, including the agents
kitchen converge
