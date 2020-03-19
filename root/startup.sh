#! /bin/sh

IFACE=eth0

IP=$(ip addr show dev ${IFACE} | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -1)

for i in /etc/dnsmasq.d/*.preconf
do
  conf=$(dirname $i)/$(basename $i .preconf).conf
  cp /dev/null $conf
  for h in $(cat $i)
  do
    echo "address=/$h/${IP}" >> $conf
  done
done

dnsmasq
sniproxy -c /etc/sniproxy/sniproxy.conf

# Run until stopped
trap "killall dnsmasq sniproxy ; exit" TERM INT
sleep 2147483647d &
wait "$!"
