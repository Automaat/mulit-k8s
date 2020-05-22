docker build -t automaat/multi-client:latest -t automaat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t automaat/multi-worker:latest -t automaat/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t automaat/multi-server:latest -t automaat/multi-server:$SHA -f ./server/Dockerfile ./serer

docker push automaat/multi-client:latest
docker push automaat/multi-server:latest
docker push automaat/multi-worker:latest
docker push automaat/multi-client:$SHA
docker push automaat/multi-server:$SHA
docker push automaat/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=automaat/multi-server:$SHA
kubectl set image deployments/client-deployment client=automaat/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=automaat/multi-worker:$SHA