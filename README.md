## Технологический журнал и EBK

В репозитории собраны различные настройки для работы с технологическим журналом на стеке EBK.

Для запуска ВМ с Elasticsearch и Kibana, в каталоге репозитория нужно выполнить команду:

```
vagrant up
```

После запуска виртуальной машины в ней будут запущены docker конейнеры с Elasticsearch (Opendistro for Elasticsearch от Amazon) и Kibana.
Запуск контейнеров выполняется с помощью docker-compose и файла [docker-compose.yml](./docker-compose.yml).

Сервисы будут доступны по следующему адресу: 

- 192.168.33.30:5601 - Kibana
- 192.168.33.30:9200 - Elasticsearch

Для изменения адресов и портов необходимо выполнить согласованные изменения в файлах:

- [docker-compose.yml](./docker-compose.yml)
- [Vagrantfile](./Vagrantfile)
- [install-pipeline.sh](./install-pipeline.sh)
- [filebeat.yml](./filebeat/filebeat.yml)

Скрипт [install-pipeline.sh](./install-pipeline.sh) установит в Elasticsearch pipeline для разбора записей лога технологического журнала.
Для выполнения установки нужно запустить команду:

```
bash install-pipeline.sh
```

Pipeline в формате json находится в файле [techlog-pipeline.json](./techlog-pipeline.json).

В каталоге `filebeat` расположены конфигурационные файлы для настройки filebeat под работу с логами технологического журнала.
После установки filebeat и до его запуска, нужно сделать следующие замены файлов в каталоге установки:

- исходный файл `filebeat.yml` заменить файлом [filebeat.yml](./filebeat/filebeat.yml) (при необходимости исправить адрес Elasticsearch и реквизиты авторизации).
- скопировать файл [techlog.template.json](./filebeat/techlog.template.json) в каталог установки filebeat (это json-файл шаблона индекса Elasticsearch для хранения логов технологического журнала, filebeat самостоятельно загрузит его в Elasticsearch).
- скопировать каталог [filebeat/configs](./filebeat/configs) в каталог установки filebeat (в каталоге configs хранятся конфигурационные файлы, которые указывают filebeat откуда собирать файлы логов, как определять многострочные записи в файлах логов, добавляют информацию о часовом поясе и типу лога).

Дистрибутив Elasticsearch от Amazon работает только с filebeat-oss, который можно скачать по адресу:

[filebeat-oss](https://www.elastic.co/downloads/beats/filebeat-oss)

Дополнительная информация по анализу технологического журнала:

- [Путешествие серверного вызова в событиях технологического журнала](./docs/server_call.md)
- [Советы и подсказки](./docs/hints_and_tips.md)