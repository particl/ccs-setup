from subprocess import call
import time
while True:
    call(["git","-C","/var/www/html/ccs-front","pull"])
    call(["git","-C","/var/www/html/ccs-back/storage/app/proposals/","pull"])
    call(["php","/var/www/html/ccs-back/artisan","schedule:run"])
    call(["jekyll","build","--source","/var/www/html/ccs-front","--destination","/var/www/html/ccs-front/_site"])
    print("updated website to latest state")
    time.sleep(30)