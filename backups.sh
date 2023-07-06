#!/bin/sh
mysqldump --version
echo "------- $(date +%F_%T) Start MySQL database backup-------- " >>${BACKUPS_PATH}/back.log
BACKUPS_DATE=$(date +"%Y-%m-%d")
mkdir -p ${BACKUPS_PATH}/${BACKUPS_DATE}

# 开始备份数据库
for database in $BACKUPS_DATABASES
do  
    echo "Start backup database: ${database}"
    /usr/bin/mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} --host=${MYSQL_HOST} --port=${MYSQL_PORT} --databases $database > ${BACKUPS_PATH}/${BACKUPS_DATE}/${database}.sql
done
echo "------- $(date +%F_%T) End MySQL database backup-------- "
# 打包备份文件
echo "------- $(date +%F_%T) Start compress backup files-------- "
tar -zcvf ${BACKUPS_PATH}/${BACKUPS_DATE}.tar.gz ${BACKUPS_PATH}/${BACKUPS_DATE}
ls ${BACKUPS_PATH}

if [ "$ENABLE_WEBDAV" = true ]; then
    curl -X PUT -u ${WEBDAV_USER}:${WEBDAV_PASSWORD} -T ${BACKUPS_PATH}/${BACKUPS_DATE}.tar.gz ${WEBDAV_PATH}/${BACKUPS_DATE}.tar.gz
fi