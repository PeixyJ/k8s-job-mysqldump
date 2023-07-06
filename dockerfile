FROM alpine:3.18
WORKDIR /

ENV ENABLE_WEBDAV=false
ENV BACKUPS_PATH=/backups

ENV DB_PORT=3306

ADD backups.sh backups.sh
RUN apk add --no-cache \
    mariadb-client \
    mariadb-connector-c \
    curl \
    tzdata \
    tar

# 创建文件夹
RUN mkdir -p ${BACKUPS_PATH}
# 设置备份文件和脚本权限
RUN chmod -R 777 ${BACKUPS_PATH}
RUN chmod +x backups.sh
ENTRYPOINT [ "./backups.sh" ]