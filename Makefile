.PHONY: multiarchbuild

multiarchbuild:
	docker buildx rm nubuilder
	docker buildx create --name "nubuilder" --use
	docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm/v6 -t heussd/newsboat:latest --push .
	docker buildx rm nubuilder