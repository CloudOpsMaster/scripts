<?php
 // Zabbix GUI configuration file.
 \$DB['TYPE']				= 'MYSQL';
 \$DB['SERVER']			= '10.164.10.2';
 \$DB['PORT']				= '0';
 \$DB['DATABASE']			= 'zabbix';
 \$DB['USER']				= 'zabbix';
 \$DB['PASSWORD']			= 'zabbix';
 
 // Schema name. Used for PostgreSQL.
 \$DB['SCHEMA']			= '';
 
 // Used for TLS connection.
 \$DB['ENCRYPTION']		= true;
 \$DB['KEY_FILE']			= '';
 \$DB['CERT_FILE']		= '';
 \$DB['CA_FILE']			= '';
 \$DB['VERIFY_HOST']		= false;
 \$DB['CIPHER_LIST']		= '
 \$DB['DOUBLE_IEEE754']	= true;
 
 \$ZBX_SERVER	= 'localhost';
 \$ZBX_SERVER_PORT	= '10051';
 \$ZBX_SERVER_NAME	= '';
 
 \$IMAGE_FORMAT_DEFAULT	= IMAGE_FORMAT_PN