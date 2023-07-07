# k8s-job-mysqldump

采用镜像的方式进行备份数据库

## 开始

### Docker
备份mysql

```bash
docker run \
    --rm \
    -e MYSQL_HOST=数据库地址 \
    -e MYSQL_PORT=3306 \
    -e MYSQL_USER=root \
    -e MYSQL_PASSWORD=123456 \
    -e ENABLE_WEBDAV=false \
    -e WEBDAV_PATH=xxx/数据库备份/ \
    -e WEBDAV_USER=xxx \
    -e WEBDAV_PASSWORD=xxxx \
    -e BACKUPS_DATABASES="mysql sys" \
    mysqldump:latest
```

### 编译

```bash
docker build -t mysqldump:xxxx .
```

### Kubernetes

该文件配置了一个每5分钟备份一次数据库后上传至Webdav

Secret配置的`Value`需要进行`Base64`编码

[备份文件](backups-job.yaml)

```bash
k apply -f backs-job.yaml
```

## 备份相关

| 变量 | 描述 | 默认值 |
|---|---|---|
|BACKUPS_PATH|备份路径|/backups|

## Mysql

| 变量 | 描述 | 默认值 |
|---|---|---|
|BACKUPS_DATABASES|需要备份的数据库空格分割||
|MYSQL_HOST|数据库地址||
|MYSQL_USER|数据库账户||
|MYSQL_PASSWORD|数据库密码||
|MYSQL_PORT|数据库端口|3306|

## Webdav

| 变量 | 描述 | 默认值 |
|---|---|---|
|ENABLE_WEBDAV| 启用WEBDAV| false|
|WEBDAV_USER| WEBDAV用户||
|WEBDAV_PASSWORD| WEBDAV密码||
|WEBDAV_PATH| WEBDAV地址||