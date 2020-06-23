:: @description : elasticsearch on docker script
:: @author : WuMengaho
:: @date : 2020-01-16

@Echo off
@SET DATA_DIR = D:/workspace_docker/elk/elasticsearch/data
@SET LOG_DIR = D:/workspace_docker/elk/elasticsearch/log

if "%1" == "start" goto start
if "%1" == "stop" goto stop
goto end


:start
echo start
if exist container_id.txt goto exist_container_run
goto init_container_run
echo started

:stop
echo stop
if exist container_id.txt goto stop_container
echo stoped

:init_container_run

echo init_container_run
:: elasicsearch
docker run -d ^
-p 9200:9200 -p 9300:9300 ^
-e discovery.type=single-node ^
-e xpack.monitoring.collection.enabled=true ^
-e path.data=/var/lib/elasticsearch ^
-e path.logs=/var/log/elasticsearch ^
-e '"ES_JAVA_OPTS=-Xms512m -Xmx512m"' ^
-v D:/workspace_docker/elk/elasticsearch/data:/var/lib/elasticsearch ^
-v D:/workspace_docker/elk/elasticsearch/log:/var/log/elasticsearch ^
elasticsearch:7.5.1 > container_id.txt

for /f %%a in (container_id.txt) do (
set container_id=%%~a
)

:: kibana
docker run -d ^
-p 5601:5601 ^
--link %container_id%:elasticsearch ^
--name kibana
kibana:7.5.1 >> container_id.txt

goto end

:exist_container_run
echo exist_container_run
for /f %%a in (container_id.txt) do (
set container_id=%%~a
)
echo %container_id%
docker container start %container_id%
goto end

:stop_container
echo stop_container
for /f %%a in (container_id.txt) do (
set container_id=%%~a
)
echo %container_id%
docker container stop %container_id%
goto end

:end
echo end