docker build -t giblets257/multi-client:latest -t giblets257/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t giblets257/multi-server:latest -t giblets257/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t giblets257/multi-worker:latest -t giblets257/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push giblets257/multi-client:latest
docker push giblets257/multi-server:latest
docker push giblets257/multi-worker:latest

docker push giblets257/multi-client:$SHA
docker push giblets257/multi-server:$SHA
docker push giblets257/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=giblets257/multi-server:$SHA
kubectl set image deployment/client-deployment client=giblets257/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=giblets257/multi-worker:$SHA
