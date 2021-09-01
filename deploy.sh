docker build -t simoande/multi-client:latest -t simoande/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t simoande/multi-server:latest -t simoande/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t simoande/multi-worker:latest -t simoande/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push simoande/multi-client:latest    
docker push simoande/multi-server:latest
docker push simoande/multi-worker:latest

docker push simoande/multi-client:$SHA   
docker push simoande/multi-server:$SHA
docker push simoande/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=simoande/multi-server:$SHA
kubectl set image deployments/client-deployment client=simoande/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=simoande/multi-worker:$SHA