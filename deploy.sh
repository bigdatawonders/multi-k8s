docker build -t bigdatawonders/multi-client:latest -t bigdatawonders/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bigdatawonders/multi-server:latest -t bigdatawonders/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bigdatawonders/multi-worker:latest -t bigdatawonders/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bigdatawonders/multi-client:latest
docker push bigdatawonders/multi-server:latest
docker push bigdatawonders/multi-worker:latest

docker push bigdatawonders/multi-client:$SHA
docker push bigdatawonders/multi-server:$SHA
docker push bigdatawonders/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bigdatawonders/multi-server:$SHA
kubectl set image deployments/client-deployment client=bigdatawonders/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bigdatawonders/multi-worker:$SHA
