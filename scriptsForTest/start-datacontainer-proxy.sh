echo "Creating wp-db-proxy & wp-web-proxy data containers and starting up..."

read -p "Are you sure to proceed (y/N)?" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

docker run -itd --name wp-db-proxy --volumes-from wp-db-vol busybox sh
docker run -itd --name wp-web-proxy --volumes-from wp-web-vol busybox sh

docker-compose -f docker-compose-foldermap-proxy.yml up -d
docker-compose -f docker-compose-foldermap-proxy.yml logs

echo "Execute 'docker-compose -f docker-compose-foldermap-proxy.yml stop' to stop all running containers"
