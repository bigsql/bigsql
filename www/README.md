# bigsql-www-py 

## Pre-reqs for CentOS 7 or Amazon Linux 2 environment

```

sudo yum update
sudo yum install python-pip
sudo pip install -r requirements.txt

sudo yum install httpd
sudo systemctl enable httpd
sudo yum install mod_wsgi
sudo systemctl start httpd

```

### Run this app

sudo vi /etc/httpd/conf/httpd.conf
  add the following lines:


WSGIDaemonProcess run:app
WSGIScriptAlias / /var/www/bigsql-www-py/bigsql-www-py.wsgi

<Directory /var/www/bigsql-www-py>
        WSGIProcessGroup run:app
        WSGIApplicationGroup %{GLOBAL}
        Order allow,deny
        Allow from all
</Directory>


```
sudo systemctl restart httpd

```
