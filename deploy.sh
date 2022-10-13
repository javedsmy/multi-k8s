docker build -t javedsmy/multi-client:latest -t javedsmy/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t javedsmy/multi-server:latest -t javedsmy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t javedsmy/multi-worker:latest -t javedsmy/multi-worker:$SHA -f ./worker/Dockefile ./worker
docker push  javedsmy/multi-client:latest
docker push  javedsmy/multi-client:$SHA
docker push javedsmy/multi-server:latest
docker push javedsmy/multi-server:$SHA
docker push javedsmy/multi-worker:latest
docker push javedsmy/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=javedsmy/multi-server:$SHA
kubectl set image deployments/client-deployment client=javedsmy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=javedsmy/multi-worker:$SHA