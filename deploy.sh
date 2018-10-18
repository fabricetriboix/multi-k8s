#!/bin/bash

docker build -t seeker7/multi-client:latest -t seeker7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t seeker7/multi-server:latest -t seeker7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t seeker7/multi-worker:latest -t seeker7/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push seeker7/multi-client:latest
docker push seeker7/multi-client:$SHA
docker push seeker7/multi-server:latest
docker push seeker7/multi-server:$SHA
docker push seeker7/multi-worker:latest
docker push seeker7/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=seeker7/multi-server:$SHA
kubectl set image deployments/client-deployment client=seeker7/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=seeker7/multi-worker:$SHA

