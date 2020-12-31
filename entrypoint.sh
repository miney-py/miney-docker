#!/usr/bin/env sh

sed -i "s/{MAP_GENERATOR}/$MAP_GENERATOR/" /var/lib/minetest/.minetest/minetest.conf
sed -i "s/{MG_FLAGS}/$MG_FLAGS/" /var/lib/minetest/.minetest/minetest.conf
sed -i "s/{SEED}/$SEED/" /var/lib/minetest/.minetest/minetest.conf
sed -i "s/{MAX_USERS}/$MAX_USERS/" /var/lib/minetest/.minetest/minetest.conf
sed -i "s/{ADMIN_NAME}/$ADMIN_NAME/" /var/lib/minetest/.minetest/minetest.conf
sed -i "s/{DEFAULT_PASSWORD}/$DEFAULT_PASSWORD/" /var/lib/minetest/.minetest/minetest.conf

if [ "$DEFAULT_PASSWORD" = "" ]
then
  echo "The admin username is '$ADMIN_NAME' and the default password for all users is empty."
else
  echo "The admin username is '$ADMIN_NAME' and the default password for all users is '$DEFAULT_PASSWORD'."
fi

exec /usr/local/bin/minetestserver --config /var/lib/minetest/.minetest/minetest.conf --gameid minetest --worldname minetest