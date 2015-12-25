echo "Creating wp-db-vol & wp-web-vol data containers"

read -p "Are you sure to proceed (y/N)?" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

docker rm wp-db-vol
docker create -v /var/lib/mysql \
  --name wp-db-vol --volumes-from dockereasyenginewordpress_wp-ee-db_1 \
  lamtrantuan/docker-easyengine-stack:db

docker rm wp-web-vol  
docker create -v /var/www -v /etc/nginx -v /var/lib/ee -v /etc/ee \
  --name wp-web-vol --volumes-from dockereasyenginewordpress_wp-ee-web_1 \
  lamtrantuan/docker-easyengine-stack:web
