echo "!!!Warning!!!: please make sure the folders /var/lib/mysql, var/www and /etc/nginx are all empty before proceeding!"

read -p "Are you sure to proceed (y/N)?" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

sudo docker cp dockereasyenginewordpress_wp-ee-db_1:/var/lib/mysql /var/lib

sudo docker cp dockereasyenginewordpress_wp-ee-web_1:/var/www /var
sudo docker cp dockereasyenginewordpress_wp-ee-web_1:/etc/nginx /etc

docker-compose -f docker-compose-foldermap.yml up -d
docker-compose -f docker-compose-foldermap.yml logs

echo "Execute 'docker-compose -f docker-compose-foldermap.yml stop' to stop all running containers"
