docker build -t npnkha/multi-client:latest -t npnkha/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t npnkha/multi-server:latest -t npnkha/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t npnkha/multi-worker:latest -t npnkha/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push npnkha/multi-client:latest
docker push npnkha/multi-server:latest
docker push npnkha/multi-worker:latest

docker push npnkha/multi-client:$SHA
docker push npnkha/multi-server:$SHA
docker push npnkha/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=npnkha/multi-server:$SHA
kubectl set image deployments/client-deployment client=npnkha/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=npnkha/multi-worker:$SHA