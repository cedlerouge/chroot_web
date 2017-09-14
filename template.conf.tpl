; FILE MANAGED VIA addNewSFTP script, DIRECT EDITS NOT PERSISTED - Netensia

[USER]
user                        = $pool
group                       = www-data

listen                      = /var/run/php/php5-fpm_DOMAIN.sock

access.log                  = /var/log/php-fpm/$pool.access.log
access.format               = "%R - %u %t \"%m %r%Q%q\" %s %f %{mili}d %{kilo}M %C%%"
request_slowlog_timeout     = 5s
slowlog                     = /var/log/php-fpm/$pool.slow.log
php_flag[display_errors]    = off
php_admin_flag[log_errors]  = on
php_admin_value[error_log]  = /var/log/php-fpm/$pool.error.log
catch_workers_output        = yes

pm                          = ondemand
pm.max_children             = 5
pm.start_servers            = 3
pm.min_spare_servers        = 2
pm.max_spare_servers        = 4
pm.max_requests             = 200

pm.status_path              = /fpm-DOMAIN-status

;listen.backlog              = -1
request_terminate_timeout   = 120s
rlimit_files                = 131072
rlimit_core                 = unlimited
catch_workers_output        = yes

; Set session path to a directory owned by process user
php_value[session.save_handler] = files
php_value[session.save_path]    = /var/lib/php/session
php_value[soap.wsdl_cache_dir]  = /var/lib/php/wsdlcache

env[HOSTNAME]               = $HOSTNAME
env[TMP]                    = /tmp
env[TMPDIR]                 = /tmp
env[TEMP]                   = /tmp

chdir                       = /

