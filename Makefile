.DEFAULT_GOAL := all
.PHONY: build


create-tables:
	aws dynamodb create-table \
		--cli-input-json file://dynamodb/config/tables/table.json \
		--endpoint-url http://localhost:8000

add-data:
	aws dynamodb put-item \
		--table-name fruitsTable \
		--item file://dynamodb/config/tables/data.json \
		--return-consumed-capacity TOTAL \
		--endpoint-url http://localhost:8000

get-data:
	aws dynamodb get-item \
		--table-name fruitsTable \
		--key file://dynamodb/config/tables/key.json \
		--endpoint-url http://localhost:8000

show-tables:
	aws dynamodb list-tables \
		--endpoint-url http://localhost:8000

setup-db: create-tables add-data


start-docker-compose:
	docker-compose up &


start-sam-local:
	cd sam-app/ && \
	sam local start-api --docker-network aws-sam-local-demo_default &


start-services: start-docker-compose start-sam-local


run-tests:
	cd sam-app/src/ && \
	npm run test


stop-docker-compose:
	docker-compose stop


stop-sam-local:
	ps aux | grep "Python /usr/local/bin/sam" | grep -v grep | awk '{print $$2}' | xargs kill -s KILL


stop-services: stop-docker-compose stop-sam-local

build:
	npm install && \
	cd sam-app/src && \
	npm install

all: build start-services setup-db run-tests stop-services