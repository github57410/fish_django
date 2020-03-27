import os

def startall():
	os.system('killall -9 nginx')
	os.system('nginx -c /etc/nginx/sites-enabled/nginx.conf')
	#os.system('nginx -s reload')
	os.system('killall -9 uwsgi')
	# os.system('uwsgi /home/www/deyi/config.ini')
	os.system('uwsgi /home/GuangZhouScenic/uwsgi.ini')
	#os.system('uwsgi /home/www/insurance_test/config.ini')
	#os.system('uwsgi /home/www/insurance_offical/config.ini')
        #os.system('uwsgi /home/www/insurance_dy/config.ini')
	#os.system('uwsgi /home/www/insurance_app/config.ini')

if __name__ == '__main__':
    startall()

