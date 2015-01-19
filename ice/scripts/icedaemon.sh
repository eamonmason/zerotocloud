description "netflix-ice"

start on net-device-up IFACE=eth0
stop on run level [!2345]
env enabled=1

respawn

exec start-stop-daemon --start --chuid ubuntu --chdir /opt/ice/ --exec /opt/ice/scripts/runit.sh


