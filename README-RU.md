# RTMP-server
> RTMP-сервер, конфигурируемый переменными среды

1. Установить [Docker](https://www.docker.com/products/docker-desktop)
2. Выполнить `docker pull rtuitlab/rtmp-server` в командной строке
3. Создать файл с переменными среды
4. Выполнить `docker run -p 1935:1935 --env-file <путь_к_файлу_с_переменными> --rm -it rtuitlab/rtmp-server` в командной строке
5. Отправлять и просматривать видео можно по адресу `rtmp://<ip_компьютера>/live/<ключ_трансляции>`

## Настройка переменных среды

Доступные параметры:
+ CS_record: all - для записи видео и аудио
+ CS_record_path: /my_records - путь **внутри** контейнера к папке с записями
+ CS_record_unique: "on" - для создания файлов с уникальными именами
+ CS_push: "URL" - ссылка на стрим с его ключом

Также можно использовать все параметры из [документации](https://github.com/arut/nginx-rtmp-module/wiki/Directives) указывая перед ними префикс `CS_`.

## Работа с Insta360 Pro

1. Убедитесь, что Insta360 Pro находится в той же локальной сети, что и компьютер
2. Начните трансляцию по адресу `rtmp://<ip_компьютера>/live/<ключ_трансляции>`

## Примеры
Следующие примеры показывают примеры использования данного RTMP сервера. Все возможности можно свободно комбинировать между собой.
### Пример с записью в файл

1. Создайте файл `env.txt`:
```env
CS_record=all
CS_record_path=/my_records
CS_record_unique=on
```

2. Выполните команду:
```bash
docker run -p 1935:1935 -v <полный_путь_к_папке_сохранения_видео>:/my_records --env-file <путь_к_файлу_с_переменными> --rm -it rtuitlab/rtmp-server
# Например
docker run -p 1935:1935 -v D:/records:/my_records --env-file env.txt --rm -it  rtuitlab/rtmp-server
```

Разрешите доступ к файловой системе для Docker, если это необходимо(может появиться уведомление).


### Пример с перенаправление на YouTube

1. Создайте файл `env.txt`:
```env
CS_push=rtmp://a.rtmp.youtube.com/live2/<приватный_ключ_трансляции>
```

2. Выполните команду:
```bash
docker run -p 1935:1935 --env-file env.txt --rm -it rtuitlab/rtmp-server
```
