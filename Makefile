image_chatbot_program_o := ypid/program-o

db_container_name := db
db_name := program-o
db_user := program-o
db_pass := change_this
db_root_pass := change_this
db_storage := /tmp/db

.PHONY: start stop run build db program-o

start:
	docker start $(db_container_name) program-o

stop:
	docker stop $(db_container_name) program-o

run: db program-o

build:
	docker build --no-cache --tag $(image_chatbot_program_o) .
	# docker build --tag $(image_chatbot_program_o) .

db:
	-@docker rm -f "$(db_container_name)"
	docker run -d \
		--name "$(db_container_name)" \
		-e "TZ=Europe/Berlin" \
		-e MYSQL_ROOT_PASSWORD=$(db_root_pass) \
		-e MYSQL_USER=$(db_user) \
		-e MYSQL_DATABASE=$(db_name) \
		-e MYSQL_PASSWORD=$(db_pass) \
		-e "TZ=Europe/Berlin" \
		-v $(db_storage):/var/lib/mysql \
		-p 3306:3306
		mysql

program-o:
	-@docker rm -f "$@"
	docker run -d \
		--name "$@" \
		-e "TZ=Europe/Berlin" \
		-e DB_ENV_MYSQL_ROOT_PASSWORD=you_dont_need_to_know \
		-e DB_ENV_MYSQL_USER=you_dont_need_to_know \
		-e DB_ENV_MYSQL_DATABASE=you_dont_need_to_know \
		-e DB_ENV_MYSQL_PASSWORD=you_dont_need_to_know \
		-p 80:80 \
		--link $(db_container_name):db \
		$(image_chatbot_program_o)
