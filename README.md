# Docker image to play video on deman via RTMP stream using nginx-rtmp-module
How to use:
 1. Install [docker](https://docs.docker.com/installation/ubuntulinux/) and docker-compose.
 2. Create project folder and subfolder for video files
```mkdir -p /myproject/flvs```
 3. Create docker-compose config file
 ```touch /myproject/docker-compose.yml``` with content

```YML
video:
  image: terbooter/rtmp-vod
  #build: .
  volumes:
    - flvs:/flvs
  ports:
    - "1935:1935"
```
 4. Run docker container ```docker-compose up```
 5. Connect to URI "rtmp://youserver.com:1935/vod"
 6. Play file as rtmp-stream ```netStream.play("myvideo.flv")```

