docker build -t ioneliacob/multi-client-k8s:latest -t ioneliacob/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t ioneliacob/multi-server-k8s:latest -t ioneliacob/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t ioneliacob/multi-worker-k8s:latest -t ioneliacob/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push ioneliacob/multi-client-k8s:latest
docker push ioneliacob/multi-server-k8s:latest
docker push ioneliacob/multi-worker-k8s:latest

docker push ioneliacob/multi-client-k8s:$SHA
docker push ioneliacob/multi-server-k8s:$SHA
docker push ioneliacob/multi-worker-k8s:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ioneliacob/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=ioneliacob/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=ioneliacob/multi-worker-k8s:$SHA