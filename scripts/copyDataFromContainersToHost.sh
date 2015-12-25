echo "!!!Warning!!!: please make sure the folders /var/lib/mysql, /var/lib/ee, var/www, /etc/nginx and /etc/ee are all empty before proceeding!"

read -p "Are you sure to proceed (y/N)?" -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

sudo docker cp dockereasyenginewordpress_wp-ee-db_1:/var/lib/mysql /var/lib

sudo docker cp dockereasyenginewordpress_wp-ee-web_1:/var/www /var
sudo docker cp dockereasyenginewordpress_wp-ee-web_1:/etc/nginx /etc
sudo docker cp dockereasyenginewordpress_wp-ee-web_1:/var/lib/ee /var/lib
sudo docker cp dockereasyenginewordpress_wp-ee-web_1:/etc/ee /etc
