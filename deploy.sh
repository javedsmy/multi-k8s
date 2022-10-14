docker build -t javshags/multi-client:latest -t javshags/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t javshags/multi-server:latest -t javshags/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t javshags/multi-worker:latest -t javshags/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push javshags/multi-client:latest
docker push javshags/multi-client:$SHA
docker push javshags/multi-server:latest
docker push javshags/multi-server:$SHA
docker push javshags/multi-worker:latest
docker push javshags/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=javshags/multi-server:$SHA
kubectl set image deployments/client-deployment client=javshags/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=javshags/multi-worker:$SHA