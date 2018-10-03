#!/usr/bin/env bash


create-tables() {
    aws dynamodb create-table \
        --cli-input-json file://dynamodb/config/tables/table.json \
        --endpoint-url http://localhost:8000
}

add-data() {
    aws dynamodb put-item \
        --table-name fruitsTable \
        --item file://dynamodb/config/tables/data.json \
        --return-consumed-capacity TOTAL \
        --endpoint-url http://localhost:8000
}

get-data() {
    aws dynamodb get-item \
        --table-name fruitsTable \
        --key file://dynamodb/config/tables/key.json \
        --endpoint-url http://localhost:8000
}

show-tables() {
    aws dynamodb list-tables \
        --endpoint-url http://localhost:8000
}

setup-db() {
    create-tables &&
    add-data
}

start-docker-compose() {
    docker-compose up &
}

start-sam-local() {
    cd sam-app/ &&
    sam local start-api --docker-network aws-sam-local-demo_default &
}

start-services() {
    start-docker-compose
    start-sam-local
}

run-tests() {
    cd sam-app/hello_world/ &&
    npm run test
}

stop-docker-compose() {
    docker-compose stop
}

stop-sam-local() {
    ps aux | grep "Python /usr/local/bin/sam" | grep -v grep | awk '{print $2}' | xargs kill &> /dev/null
}

stop-services() {
    stop-docker-compose &&
    stop-sam-local
}

all() {
    start-services &&
    setup-db &&
    run-tests &&
    stop-services
}

# Check if the function exists (bash specific)
if declare -f $1 > /dev/null
then
  # call arguments verbatim
  "$@"
else
  # Show a helpful error
  echo "'$1' is not a known function name" >&2
  exit 1
fi