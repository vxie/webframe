#!/bin/sh

JAVA_APP_CLASS='InitDB'

COMMOND_CLASSPATH='.'
for i in `ls /home/cutshow/apps/cutshow/WEB-INF/lib/*.jar`; do
     COMMOND_CLASSPATH=$i:$COMMOND_CLASSPATH
done

for i in `ls /home/cutshow/webserver/jetty6/lib/*.jar`; do
     COMMOND_CLASSPATH=$i:$COMMOND_CLASSPATH
done
COMMOND_CLASSPATH=.:$COMMOND_CLASSPATH


java -cp $COMMOND_CLASSPATH -Dfile.encoding=utf8 $JAVA_APP_CLASS /home/cutshow/apps/cutshow/WEB-INF/app-servlet.xml
