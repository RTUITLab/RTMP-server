# RTMP-server
> RTMP server with environment configuration

1. Install Docker
2. Run `docker pull rtuitlab/rtmp-server` in command line
3. Create file with environmental variables
4. Run `docker run -p 1935:1935 --env-file <route_to_env_file> --rm -it rtuitlab/rtmp-server` in command line

## Configuration of environmental variables

Available variables:
+ CS_record: all - record video and audio
+ CS_record_path: /my_records - path to records folder **inside** container
+ CS_record_unique: "on" - use unique names to video files
+ CS_push: "URL" - URL with stream key

You can use all parameters from [documentation](https://github.com/arut/nginx-rtmp-module/wiki/Directives) with `CS_` prefix.

## Work with Insta360 Pro

1. Enshure that Insta360 Pro is using the same network as your PC
2. Start stream to URL `rtmp://<your_pc_ip>/live/<stream_key>`

## Example with recording

1. Create file `env.txt`:
```env
CS_record=all
CS_record_path=/my_records
CS_record_unique=on
```

2. Run command:
```bash
docker run -p 1935:1935 -v <full_path_to_records_folder>:/my_records --env-file <route_to_env_file> --rm -it rtuitlab/rtmp-server
# For example
docker run -p 1935:1935 -v D:/records:/my_records --env-file env.txt --rm -it  rtuitlab/rtmp-server
```

Accept drive sharing if Docker wants it.


## Example with relay to YouTube

1. Create file `env.txt`:
```env
CS_push=rtmp://a.rtmp.youtube.com/live2/<your_private_string_key>
```

2. Run command:
```bash
docker run -p 1935:1935 --env-file env.txt --rm -it rtuitlab/rtmp-server
```
