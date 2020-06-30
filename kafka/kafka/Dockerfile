FROM docker.io/tmwmh/c7-systemd-java
ENV broker_id '0'
ENV listeners 'PLAINTEXT://:9092'
ENV log_dirs '/tmp/kafka-logs-2'
ENV zookeeper_connect 'localhost:2181'
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.5.0/kafka_2.12-2.5.0.tgz
RUN tar -zxvf kafka_2.12-2.5.0.tgz
RUN echo 'broker.id='$broker_id >> ./kafka_2.12-2.5.0/config/broker.properties &&\
    echo 'listeners='$listeners >> ./kafka_2.12-2.5.0/config/broker.properties &&\
    echo 'log.dirs='$log_dirs >> ./kafka_2.12-2.5.0/config/broker.properties &&\
    echo 'zookeeper.connect='$zookeeper_connect >> ./kafka_2.12-2.5.0/config/broker.properties &&\
    echo 'nohup /kafka_2.12-2.5.0/bin/zookeeper-server-start.sh /kafka_2.12-2.5.0/config/zookeeper.properties 2>&1 &' > /start_zookeeper.sh; chmod 777 /start_zookeeper.sh &&\
    echo '/kafka_2.12-2.5.0/bin/kafka-server-start.sh /kafka_2.12-2.5.0/config/broker.properties' > /start_brocker.sh ; chmod 777 /start_brocker.sh

ENTRYPOINT ["/bin/bash","-c","/start_zookeeper.sh;/start_brocker.sh"]
