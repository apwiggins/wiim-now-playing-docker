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

## start 
`./wnp.sh`
