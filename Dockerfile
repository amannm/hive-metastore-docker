FROM amannm/java8-docker-base
MAINTAINER Amann Malik <amannmalik@gmail.com>

WORKDIR /root

ENV HADOOP_VERSION 2.8.1
ENV HADOOP_PREFIX /usr/local/hadoop

RUN wget http://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar --exclude='./share/doc' -zxf /hadoop-${HADOOP_VERSION}.tar.gz && \
    rm /hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} ${HADOOP_PREFIX}

ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/hadoop-aws-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/aws-java-sdk-s3-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/aws-java-sdk-core-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/aws-java-sdk-kms-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/joda-time-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/httpclient-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/jackson-core-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/jackson-annotations-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/jackson-databind-*.jar

ENV HIVE_VERSION 2.3.0
ENV HIVE_HOME /usr/local/hive
ENV HIVE_CONF_DIR=${HIVE_HOME}/conf

RUN wget http://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar -zxf /apache-hive-${HIVE_VERSION}.tar.gz && \
    rm /apache-hive-${HIVE_VERSION}.tar.gz && \
    mv apache-hive-${HIVE_VERSION} ${HIVE_HOME}

RUN mkdir -p /user/data/warehouse

ADD hive-site.xml ${HIVE_CONF_DIR}/hive-site.xml

RUN ${HIVE_HOME}/bin/hive --service schemaTool -dbType postgres -initSchema

ENTRYPOINT ${HIVE_HOME}/bin/hive --service metastore