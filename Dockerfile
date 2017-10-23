FROM amannm/hive-docker-base
MAINTAINER Amann Malik <amannmalik@gmail.com>

ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/hadoop-aws-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/aws-java-sdk-s3-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/aws-java-sdk-core-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/aws-java-sdk-kms-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/joda-time-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/httpclient-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/jackson-core-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/jackson-annotations-*.jar
ENV HADOOP_CLASSPATH ${HADOOP_CLASSPATH}:${HADOOP_PREFIX}/share/hadoop/tools/lib/jackson-databind-*.jar

RUN mkdir -p /user/data/warehouse

ENV HIVE_CONF_DIR=${HIVE_HOME}/conf

ADD hive-site.xml ${HIVE_CONF_DIR}/hive-site.xml

RUN ${HIVE_HOME}/bin/hive --service schemaTool -dbType postgres -initSchema

ENTRYPOINT ${HIVE_HOME}/bin/hive --service metastore