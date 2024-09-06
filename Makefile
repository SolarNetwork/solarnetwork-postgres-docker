REPO=snmatt/sndev
NAME=solarnetwork-postgres
VER=12
PORT=5432

build : 
	docker build -t $(NAME)-$(VER) .
	
buildstage : 
	docker build --target build -t $(NAME)-$(VER) .
	
rebuild : 
	docker build --no-cache -t $(NAME)-$(VER) .
	
start : 
	docker start $(NAME)-$(VER)

stop : 
	docker stop $(NAME)-$(VER)

remove : 
	docker rm $(NAME)-$(VER)

tag:
	docker tag $(NAME)-$(VER):latest snmatt/sndev:$(NAME)-$(VER)

push:
	docker push snmatt/sndev:$(NAME)-$(VER)

run :
	docker run -d \
		--publish $(PORT):5432 \
		--memory 1GB \
		-e POSTGRES_PASSWORD=postgres \
		--name $(NAME)-$(VER) \
		-v "${PWD}/postgresql.conf":/etc/postgresql/postgresql.conf \
		$(NAME)-$(VER):latest \
		postgres -c 'config_file=/etc/postgresql/postgresql.conf'
		
shell:
	docker exec -it $(NAME)-$(VER) /bin/bash

