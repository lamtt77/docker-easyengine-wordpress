echo "Creating wp-db-vol & wp-web-vol data containers and starting up..."

read -p "Are you sure to proceed (y/N)?" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

docker create -v /var/lib/mysql --name wp-db-vol --volumes-from dockereasyenginewordpress_wp-ee-db_1 \
  lamtrantuan/docker-easyengine-stack:db
  
docker create -v /var/www -v /etc/nginx --name wp-web-vol --volumes-from dockereasyenginewordpress_wp-ee-web_1 \
  lamtrantuan/docker-easyengine-stack:web
  
docker-compose -f docker-compose-datacontainer.yml up -d
docker-compose -f docker-compose-datacontainer.yml logs

echo "Execute 'docker-compose -f docker-compose-datacontainer.yml stop' to stop all running containers"
