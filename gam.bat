@echo off
docker run --rm -it -v gam-volume:/home/gam/ --name docker-gam olkitu/docker-gam %*