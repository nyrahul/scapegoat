build:
	docker buildx build -t nyrahul/scapegoat:latest .

push:
	docker push nyrahul/scapegoat:latest
