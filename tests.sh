docker build -t kanti/buildy .

printf "\n\n"
docker run --rm kanti/buildy rsync --version
printf "\n\n"
docker run --rm kanti/buildy php -v
printf "\n\n"
docker run --rm kanti/buildy composer --version
printf "\n\n"
docker run --rm kanti/buildy git --version

