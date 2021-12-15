# Pull necessary images

docker pull nginx
docker pull mongo

# Create bridged networks

docker network create -d bridge --subnet=172.1.1.0/24 MyBridgedNetwork
docker network create -d bridge --subnet=172.2.2.0/24 BCNetwork

# Deploy nginx container on MyBridgedNetwork

docker run -d -it --network MyBridgedNetwork --name web nginx

# Deploy mongo container on MyBridgedNetwork

docker run -d -it --network MyBridgedNetwork --name mongodb mongo

# Attach volume “bdd” to mongodb container

docker volume create bdd

docker run -d --network MyBridgedNetwork --name bdd mongo --mount source=bdd,destination=/bdd

# Create Ethereum node volume

docker volume create blockchain

# Deploy Ethereum node

docker build -t geth ./geth

docker run -d -it --network BCNetwork --mount source=blockchain,destination=/blockchain --name geth geth