This is based on the tremendous [work](https://github.com/cvdlinden/wiim-now-playing) by Caspar van den Linden (cvdlinden).  He has built a nodejs service that interacts with a local WiiM device to display current track, album art, and audio quality information.  It's very cool!

# Usage

Once set up, direct your browser to http://[host]:8080 to access the wnp screen to see what the WiiM device is playing now.

To help you get started creating a container from this image you can either use docker-compose or the docker cli.

## docker-compose (recommended)
To support [SSDP](https://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol) protocol discovery of your WiiM device, `network_mode` is set to `host`.

NOTE: Recent changes to a rootless container means that port 80 no longer is possible.
```
services:
  wnp:
    image: apwiggins/wiimnowplaying-test:latest #use tag like v1.6.3 for specific version
    container_name: wnp
    network_mode: host # for SSDP discovery
    environment:
      - PORT=8080      # defaults to port 8080 unless PORT is set
                       # now runs rootless with a non-privileged user,
                       # so port MUST be larger than 1024
    restart: unless-stopped
    volumes:
      - wnp-data:/app/data

volumes:
  wnp-data:
```

## Parameters

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate <external>:<internal> respectively. For example, -p 9000:8080 would expose port 8080 from inside the container to be accessible from the host's IP on port 9000 outside the container.

**IMPORTANT:** A recent change to a rootless container architecture means that `PORT` MUST be LARGER THAN 1024 or the port is denied.  The longstanding default PORT has been remapped from 80 to 8080.

| Parameter   | Function            |
|-------------|---------------------|
| PORT=9000   | Unless set, defaults to 8080 |

## Support Info

- Shell access while the container is running:


```docker exec -it wnp /bin/bash```


- To monitor the logs of the container in realtime:

```docker logs -f wnp```

- Container version number:

```docker inspect -f '{{ index .Config.Labels "build_version" }}' wnp```

- Image version number:

Starting with wiim-now-playing version 1.6, a version tag can be appended to the image (e.g., `v1.6`).  The `latest` tag can also be used.

```docker inspect -f '{{ index .Config.Labels "build_version" }}' hub.docker.com/apwiggins/wiimnowplaying:latest```

# Security

- Docker Scout scan on this build was performed.
- Container no longer runs as root user