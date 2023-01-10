FROM debian:latest

RUN groupadd -r clickhouse --gid=101 \
&& useradd -r -g clickhouse --uid=101 --home-dir=/var/lib/clickhouse --shell=/bin/bash clickhouse

RUN mkdir -p /root/app/usr/bin && mkdir /root/app/lib \
    && mkdir -p /root/app/logs && mkdir /root/app/data \
    mkdir -p /root/app/config
ENV LD_LIBRARY_PATH=/root/app/lib

COPY --chown=clickhouse:clickhouse run.sh /root/app
COPY --chown=clickhouse:clickhouse clickhouse /root/app/usr/bin
COPY --chown=clickhouse:clickhouse libfdb_c.so /root/app/lib
RUN chmod +x /root/app/run.sh

ENTRYPOINT ["/root/app/run.sh"]

# run
#      envsubst < /mnt/cnch-tso-config/cnch-tso.xml > /opt/tiger/toutiao/app/etc/cnch-tso/cnch-tso.xml
#      mkdir -p /opt/tiger/chadc/ && cp /opt/tiger/toutiao/app/etc/cnch-tso/netsegment /opt/tiger/chadc/
#      exec /opt/tiger/toutiao/app/usr/bin/tso_server --config-file /opt/tiger/toutiao/app/etc/cnch-tso/cnch-tso.xml



# docker run --env --network host -p 9010:9010
# docker run --env --network host --expose 9010 -v /host_config_foler: 
# docker  run  -v `pwd`:`pwd` -w `pwd` -i -t  ubuntu pwd
