HUB_PUBLISHER?=rajeshkbathula


create_images:
	@./build/mvn -Pkubernetes -DskipTests clean package
	cd ./dist ; docker build -t ${HUB_PUBLISHER}/spark:3.1.1-hdp3.2 -f kubernetes/dockerfiles/spark/Dockerfile .
	cd ./dist ; docker build -t ${HUB_PUBLISHER}/spark-py:3.1.1-hdp3.2 --build-arg base_img=${HUB_PUBLISHER}/spark:3.1.1-hdp3.2 -f kubernetes/dockerfiles/spark/bindings/python/Dockerfile .
#	@docker build -t ${HUB_PUBLISHER}/spark-py:3.1.1-hdp3.2 --build-arg base_img=spark:3.1.1-hadoop3.2 -f resource-managers/kubernetes/docker/src/main/dockerfiles/spark/bindings/python/Dockerfile .

push:
	@docker push ${HUB_PUBLISHER}/spark:3.1.1-hdp3.2
	@docker push ${HUB_PUBLISHER}/spark-py:3.1.1-hdp3.2

login:
	@docker login --username ${HUB_PUBLISHER} --password Docker@123