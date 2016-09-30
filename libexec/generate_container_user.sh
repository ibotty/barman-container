# Set current user in nss_wrapper
USER_ID=$(id -u)
GROUP_ID=$(id -g)

if [ x"$USER_ID" != x"0" -a x"$USER_ID" != x"997" ]; then

    NSS_WRAPPER_PASSWD=/var/lib/barman/passwd
    NSS_WRAPPER_GROUP=/etc/group

    sed -e '/barman/d' -e 's/^barman:/builder:/' < /etc/passwd > $NSS_WRAPPER_PASSWD

    echo "barman:x:${USER_ID}:${GROUP_ID}:Backup and Recovery Manager for PostgreSQL:${HOME}:/bin/bash" >> $NSS_WRAPPER_PASSWD

    export NSS_WRAPPER_PASSWD
    export NSS_WRAPPER_GROUP

    LD_PRELOAD=libnss_wrapper.so
    export LD_PRELOAD
fi
