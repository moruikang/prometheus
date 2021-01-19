### 安装

####  创建postgres监控用户

执行create_user.sql文件内的sql语句，创建postgres_exporter监控用户并授权，密码默认设置为password；
```
-- To use IF statements, hence to be able to check if the user exists before
-- attempting creation, we need to switch to procedural SQL (PL/pgSQL)
-- instead of standard SQL.
-- More: https://www.postgresql.org/docs/9.3/plpgsql-overview.html
-- To preserve compatibility with <9.0, DO blocks are not used; instead,
-- a function is created and dropped.
CREATE OR REPLACE FUNCTION __tmp_create_user() returns void as $$
BEGIN
  IF NOT EXISTS (
          SELECT                       -- SELECT list can stay empty for this
          FROM   pg_catalog.pg_user
          WHERE  usename = 'postgres_exporter') THEN
    CREATE USER postgres_exporter;
  END IF;
END;
$$ language plpgsql;

SELECT __tmp_create_user();
DROP FUNCTION __tmp_create_user();

ALTER USER postgres_exporter WITH PASSWORD 'password';
ALTER USER postgres_exporter SET SEARCH_PATH TO postgres_exporter,pg_catalog;

-- If deploying as non-superuser (for example in AWS RDS), uncomment the GRANT
-- line below and replace <MASTER_USER> with your root user.
-- GRANT postgres_exporter TO <MASTER_USER>;
CREATE SCHEMA IF NOT EXISTS postgres_exporter;
GRANT USAGE ON SCHEMA postgres_exporter TO postgres_exporter;
GRANT CONNECT ON DATABASE postgres TO postgres_exporter;

CREATE OR REPLACE FUNCTION get_pg_stat_activity() RETURNS SETOF pg_stat_activity AS
$$ SELECT * FROM pg_catalog.pg_stat_activity; $$
LANGUAGE sql
VOLATILE
SECURITY DEFINER;

CREATE OR REPLACE VIEW postgres_exporter.pg_stat_activity
AS
  SELECT * from get_pg_stat_activity();

GRANT SELECT ON postgres_exporter.pg_stat_activity TO postgres_exporter;

CREATE OR REPLACE FUNCTION get_pg_stat_replication() RETURNS SETOF pg_stat_replication AS
$$ SELECT * FROM pg_catalog.pg_stat_replication; $$
LANGUAGE sql
VOLATILE
SECURITY DEFINER;

CREATE OR REPLACE VIEW postgres_exporter.pg_stat_replication
AS
  SELECT * FROM get_pg_stat_replication();

GRANT SELECT ON postgres_exporter.pg_stat_replication TO postgres_exporter;

CREATE OR REPLACE FUNCTION get_pg_stat_statements() RETURNS SETOF pg_stat_statements AS
$$ SELECT * FROM public.pg_stat_statements; $$
LANGUAGE sql
VOLATILE
SECURITY DEFINER;

CREATE OR REPLACE VIEW postgres_exporter.pg_stat_statements
AS
  SELECT * FROM get_pg_stat_statements();

GRANT SELECT ON postgres_exporter.pg_stat_statements TO postgres_exporter;
```
##### 若报插件pg_stat_statements找不到的错误，执行以下步骤安装:
```
$ cd /usr/local/postgresql-10.12/contrib/pg_stat_statements/ #去到postgresql的插件目录的对应插件下
$ make && make install
```
进入psql命令行界面，查看可用插件，并安装
```
$ su postgres #根据实际用户名来
bash-4.2$ psql
postgres=# select name from pg_available_extensions;
postgres=# create extension pg_stat_statements;
```


#### 安装 postgres_exporter

```
$ sh install_postgres_exporter.sh

请输入postgres的IP，默认为localhost，如果使用默认，请输入1并回车；如果需要自定义，请输入IP：

请输入postgres的端口，默认为5432，如果使用默认，请输入1并回车；如果postgres设置有另外端口，请输入端口： 

```
#### 验证
上一步的安装脚本已经顺带验证了

```
$ curl localhost:9187/metrics
```

#### Prometheus配置
```
  - job_name: 'postgres'

    static_configs:
    - targets:
      - localhost:9187 # postgres地址
      labels:
        app: "postgres"
```
