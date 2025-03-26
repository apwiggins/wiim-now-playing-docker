# wiim-now-playing-docker

Based on the tremendous work by cvdlinden at https://github.com/cvdlinden/wiim-now-playing

# build and run

- this script uses docker-compose to build a wnp container based on the Dockerfile
- the docker-compose.yml uses port 80 by default, so adjust it to your needs
- it pulls the latest main branch of cvdlinden's repository from github and starts a wnp container on the local host
- if you haven't already done so, `chmod +x ./wnp`
- there's a commented prune command at the bottom of wnp.sh to remove older unused docker images

## assumptions
- you have a Raspberry Pi or NUC running Linux
- docker and docker-compose are installed

## docker-compose.yml
Image tags:
| Type | Tag |
| --- | --- |
| AMD64 (Intel/AMD): | `image: apwiggins/wiimnowplaying:v1.6` |
| AMD64 (latest): | `image: apwiggins/wiimnowplaying:latest` |
| ARM64 (RPi): | `image: apwiggins/wiimnowplaying:v1.6-arm64` |
| ARM64 (latest): | `image: apwiggins/wiimnowplaying:latest-arm64` |

```
skopeo list-tags docker://docker.io/apwiggins/wiimnowplaying
{
    "Repository": "docker.io/apwiggins/wiimnowplaying",
    "Tags": [
        "latest",
        "latest-arm64",
        "v1.6",
        "v1.6-arm64"
    ]
}
```

## start 
`./wnp.sh`
