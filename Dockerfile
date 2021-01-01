FROM alpine:latest AS compile

LABEL version="1.0" maintainer="Robert Lieback <info@zetabyte.de>"

ENV MINETEST_VERSION 5.3.0
ENV MINETEST_GAME_VERSION stable-5

WORKDIR /usr/src/minetest

RUN apk add --no-cache git build-base irrlicht-dev cmake bzip2-dev libpng-dev \
		jpeg-dev libxxf86vm-dev mesa-dev sqlite-dev libogg-dev \
		libvorbis-dev openal-soft-dev curl-dev freetype-dev zlib-dev \
		gmp-dev jsoncpp-dev postgresql-dev luajit-dev ca-certificates && \
	git clone --depth=1 --single-branch --branch ${MINETEST_VERSION} -c advice.detachedHead=false https://github.com/minetest/minetest.git . && \
	git clone --depth=1 -b ${MINETEST_GAME_VERSION} https://github.com/minetest/minetest_game.git ./games/minetest_game && \
	rm -fr ./games/minetest_game/.git

WORKDIR /usr/src/minetest
RUN cd build && \
	cmake .. \
		-DCMAKE_INSTALL_PREFIX=/usr/local \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SERVER=TRUE \
		-DBUILD_UNITTESTS=FALSE \
		-DBUILD_CLIENT=FALSE \
		-DVERSION_EXTRA=miney_docker && \
	make && \
	make install && \
	mkdir /usr/local/share/minetest/mods && \
	git clone --depth=1 -b master https://github.com/miney-py/mineysocket.git /usr/local/share/minetest/mods/mineysocket && \
	rm -fr ./mods/mineysocket/.git


FROM alpine:latest AS server

ENV MAP_GENERATOR v7
ENV MG_FLAGS "caves,dungeons,light,decorations,biomes"
ENV SEED ""
ENV MAX_USERS 15
ENV ADMIN_NAME Miney
ENV DEFAULT_PASSWORD ""
ENV MGFLAT_GROUND_LEVEL 8
ENV WATER_LEVEL 1
ENV STATIC_SPAWNPOINT ""

COPY --from=compile /usr/local/share/minetest /usr/local/share/minetest
COPY --from=compile /usr/local/bin/minetestserver /usr/local/bin/minetestserver
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apk add --no-cache sqlite-libs curl gmp libstdc++ libgcc libpq luajit lua5.1-socket lua5.1-cjson bash && \
	adduser -D minetest --uid 30000 -h /var/lib/minetest && \
	mkdir /var/lib/minetest/.minetest && \
	chown -R minetest:minetest /var/lib/minetest && \
	chmod +x /usr/local/bin/entrypoint.sh

COPY --chown=minetest:minetest minetest.conf /var/lib/minetest/.minetest/minetest.conf
COPY --chown=minetest:minetest worlds/ /var/lib/minetest/.minetest/worlds/

WORKDIR /var/lib/minetest

USER minetest:minetest

EXPOSE 30000/udp 30000/tcp 29999/tcp

VOLUME /var/lib/minetest/.minetest

ENTRYPOINT /usr/local/bin/entrypoint.sh
