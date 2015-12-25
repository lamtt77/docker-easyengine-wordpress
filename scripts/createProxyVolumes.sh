echo "Creating wp-db-proxy & wp-web-proxy data containers and starting up..."

read -p "Are you sure to proceed (y/N)?" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

docker rm wp-db-proxy
docker run -itd --name wp-db-proxy --volumes-from wp-db-vol busybox sh

docker rm wp-web-proxy
docker run -itd --name wp-web-proxy --volumes-from wp-web-vol busybox sh
