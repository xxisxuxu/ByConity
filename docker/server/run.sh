#!/bin/bash

function run_tso() {
    docker run \
    --mount type=bind,source="$(pwd)"/config,target=/root/app/config \
    --mount type=bind,source="$(pwd)"/logs,target=/root/app/logs \
    --expose 18689 \
    --network host \
    --name byconity-tso minhthucdao1/byconity-server tso-server --config-file /root/app/config/tso.xml
}

function run_server() {
    docker run \
    --mount type=bind,source="$(pwd)"/config,target=/root/app/config \
    --mount type=bind,source="$(pwd)"/logs,target=/root/app/logs \
    --mount type=bind,source="$(pwd)"/data,target=/root/app/data \
    --expose 18684 \
    --expose 18685 \
    --expose 18686 \
    --expose 18687 \
    --expose 18688 \
    --network host \
    --name byconity-tso minhthucdao1/byconity-server server -C --config-file /root/app/config/server$1.xml 
}

function run_read_worker() {
    docker run \
    --mount type=bind,source="$(pwd)"/config,target=/root/app/config \
    --mount type=bind,source="$(pwd)"/logs,target=/root/app/logs \
    --mount type=bind,source="$(pwd)"/data,target=/root/app/data \
    --expose 18696 \
    --expose 18697 \
    --expose 18698 \
    --expose 18699 \
    --expose 18700 \
    --network host \
    --name byconity-tso minhthucdao1/byconity-server server -C --config-file /root/app/config/read_worker$1.xml 
}

function run_write_worker() {
    docker run \
    --mount type=bind,source="$(pwd)"/config,target=/root/app/config \
    --mount type=bind,source="$(pwd)"/logs,target=/root/app/logs \
    --mount type=bind,source="$(pwd)"/data,target=/root/app/data \
    --expose 18690 \
    --expose 18691 \
    --expose 18692 \
    --expose 18693 \
    --expose 18694 \
    --network host \
    --name byconity-tso minhthucdao1/byconity-server server -C --config-file /root/app/config/write_worker$1.xml 
}

function run_dm() {
    docker run \
    --mount type=bind,source="$(pwd)"/config,target=/root/app/config \
    --mount type=bind,source="$(pwd)"/logs,target=/root/app/logs \
    --mount type=bind,source="$(pwd)"/data,target=/root/app/data \
    --expose 18965 \
    --network host \
    --name byconity-tso minhthucdao1/byconity-server daemon-manager --config-file /root/app/config/dm.xml 
}

if [ ! -f "config/fdb.cluster" ]; then
    echo "file config/fdb.cluster does not exist."
    exit 0
fi

if [ "$1" = "tso" ]; then
    run_tso
elif [$1 = "server"]; then
    run_server $2
else
    echo "valid argument are tso, server, read_worker, write_worker, dm"
fi
