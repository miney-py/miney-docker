# Minetest + Mineysocket server in docker

## Environment variables

| Env. variable  | Default value | Description 
|---             | --- | ---
| MAP_GENERATOR  | v7 | One of v7, flat, valleys, carpathian, v5, fractal, singlenode, v6
| MG_FLAGS       | caves,dungeons,light,decorations,biomes | Global map generation attributes. <br />possible values: caves, dungeons, light, decorations, biomes, nocaves, nodungeons, nolight, nodecorations, nobiomes
| MGFLAT_GROUND_LEVEL | 8 | For flat mag generator only: Y of flat ground.
| WATER_LEVEL | 1 | Water surface level of the world. **Set this lower or MGFLAT_GROUND_LEVEL under 1 will produce a flodded flat world**
| STATIC_SPAWNPOINT | "" (empty) | Set a static spawn point for all users in the form "(0,0,0)", where these values represent x, y, and z.
| SEED           | "" (empty) | With empty value, minetest generates a random seed
| MAX_USERS      | 15 | How many can connect at the same time
| ADMIN_NAME     | miney | This user gets admin privileges
| DEFAULT_PASSWORD | "" (empty) | Everyone can join without a password. <br />THIS MEANS ALSO THE ADMIN USER! CHANGE PASSWORD BY PRESSING ESC -> CHANGE PASSWORD
