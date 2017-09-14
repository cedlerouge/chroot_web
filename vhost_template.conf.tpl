<VirtualHost *:80>
    ServerName      DOMAIN
    ServerAlias     DOMAIN
    ServerAdmin     postmaster@DOMAIN

    CustomLog       /var/log/apache2/DOMAIN_access.log combined
    ErrorLog        /var/log/apache2/DOMAIN_error.log
    LogLevel        warn

    DocumentRoot    /var/www/USER/www
    <Directory "/">
        Options         FollowSymLinks Indexes ExecCGI
        AllowOverride   All
        Require all granted
    </Directory>

    <Directory "/var/www/USER/www/">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride all
        Require all granted
    </Directory>

    <Directory "/var/www/USER/wp-admin">
        FallbackResource disabled
    </Directory>

    <IfModule mod_fastcgi.c>
        ScriptAlias /fcgi-bin/ /srv/www/fcgi-bin/
        AddHandler php5-fastcgi .php
        Action php5-fastcgi /fcgi-bin/PROJECT-fpm
        FastCgiExternalServer /srv/www/fcgi-bin/PROJECT-fpm -socket /var/run/php5-fpm_PROJECT.sock -pass-header Authorization
    </IfModule>

#    ProxyPassMatch ^/phpmyadmin !
#    ProxyPassMatch ^/fpm-status(/.*)?$ fcgi://127.0.0.1:9000/fpm-status$1

    ####################
    # GZIP COMPRESSION #
    ####################
    SetOutputFilter DEFLATE
    AddOutputFilterByType DEFLATE text/html text/css text/plain text/xml application/x-javascript application/x-httpd-php
    BrowserMatch ^Mozilla/4 gzip-only-text/html
    BrowserMatch ^Mozilla/4\.0[678] no-gzip
    BrowserMatch \bMSIE !no-gzip !gzip-only-text/html
    BrowserMatch \bMSI[E] !no-gzip !gzip-only-text/html
    SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png)$ no-gzip
    #Header append Vary User-Agent env=!dont-vary

    ServerSignature Off

</VirtualHost>

