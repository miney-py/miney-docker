# Minetest + Mineysocket server in docker

## Environment variables

| Env. variable  | Default value | Description 
|---             | --- | ---
| MAP_GENERATOR  | v7 | One of v7, flat, valleys, carpathian, v5, fractal, singlenode, v6
| SEED           | "" (empty) | With empty value, minetest generates a random seed
| MAX_USERS      | 15 | How many can connect at the same time
| ADMIN_NAME     | miney | This user gets admin privileges
| DEFAULT_PASSWORD | "" (empty) | Everyone can join without a password. <br />THIS MEANS ALSO THE ADMIN USER! CHANGE PASSWORD BY PRESSING ESC -> CHANGE PASSWORD
