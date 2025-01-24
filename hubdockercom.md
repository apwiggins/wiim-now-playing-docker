[wiim-now-playing](https://github.com/cvdlinden/wiim-now-playing) shows what the WiiM device is currently playing on a separate screen.

# Credit
This is based on the tremendous [work](https://github.com/cvdlinden/wiim-now-playing) by Caspar van den Linden (cvdlinden).  He has built a nodejs service that interacts with a local WiiM device to display current track, album art, and audio quality information.  It's very cool!

# Usage

Once set up, direct your browser to http://[host]:8080 to access the wnp screen to see what the WiiM device is playing now.

To help you get started creating a container from this image you can either use docker-compose or the docker cli.

## docker-compose (recommended)
To support [SSDP](https://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol) protocol discovery of your WiiM device, `network_mode` is set to `host`.

```
services:
  wnp:
    image: apwiggins/wiimnowplaying:latest
    container_name: wnp
    network_mode: host # for SSDP discovery
    environment:
      - PORT=8080      # defaults to port 80 unless PORT is set
    restart: unless-stopped
```

## Parameters

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate <external>:<internal> respectively. For example, -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 outside the container.

| Parameter   | Function            |
|-------------|---------------------|
| PORT=8080   | Unless set, defaults to 80 |

## Support Info

- Shell access while the container is running:


```docker exec -it wnp /bin/bash```


- To monitor the logs of the container in realtime:

```docker logs -f wnp```

- Container version number:

```docker inspect -f '{{ index .Config.Labels "build_version" }}' wnp```

- Image version number:

```docker inspect -f '{{ index .Config.Labels "build_version" }}' hub.docker.com/apwiggins/wiimnowplaying:latest```
