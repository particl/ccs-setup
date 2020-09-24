docker-compose down
sudo chown -R user data/
rm -rf data/nginx/ccs-*
sudo rm -rf data/mysql && mkdir data/mysql
rm data/particld/particl.conf
rm ccs.env ccs.nginx mysql.env