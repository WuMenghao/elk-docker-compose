:: @description : kibana on docker script
:: @author : WuMengaho
:: @date : 2020-01-17

@Echo off

for /f %%a in (container_id.txt) do (
set container_id=%%~a
)

docker run -d ^
-p 5601:5601 ^
--link %container_id%:elasticsearch ^
--name kibana
kibana:7.5.1