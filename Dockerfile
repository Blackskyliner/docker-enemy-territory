FROM blackskyliner/base:ubuntu-bionic

RUN apt-get update && apt-get install -y p7zip p7zip-full p7zip-rar wget && rm -rf /var/lib/apt/lists/* 
ADD gamefiles /tmp

RUN set -e \    
    && mkdir /tmp/et && mkdir /tmp/etl \
    && cd /tmp \
    && chmod +x /tmp/download.sh && /tmp/download.sh && rm /tmp/download.sh \
    && mv etl.tgz etl && cd etl \
    && tar xf etl.tgz && rm etl.tgz \
    && mv $(ls -1)/* /opt/application \
    && cd /tmp \
    && mv et.zip et && cd et \
    && unzip et.zip && rm et.zip \
    && 7za x et260b.x86_keygen_V03.run && rm et260b.x86_keygen_V03.run \
    && 7za x et260b.x86_keygen_V03 && rm et260b.x86_keygen_V03 \
    && rm -r /tmp/et/etmain/video \
    && rm -r /tmp/et/etmain/punkbuster.cfg \
    && cp /tmp/et/bin/Linux/x86/* /opt/application \
    && cp -R /tmp/et/etmain /opt/application \
    && mkdir /opt/application/.etlegacy \
    && unzip /tmp/nitmod.zip -d /opt/application/nitmod && rm /tmp/nitmod.zip \
    && unzip /tmp/etjump.zip -d /opt/application/etjump && rm /tmp/etjump.zip \
    && mv /tmp/server.cfg /opt/application/etmain \
    && mv /tmp/nitmod.cfg /opt/application/nitmod \
    && chown -R application:application /opt/application \
    && find /opt/application -type f -exec chmod 0644 {} \;  \
    && find /opt/application -type d -exec chmod 0755 {} \;  \
    && chmod 0755 /opt/application/et /opt/application/et.x86 /opt/application/etded.x86 /opt/application/etl /opt/application/etl_bot.sh /opt/application/etl_renderer2.sh /opt/application/etlded /opt/application/etlded_bot.sh \
    && rm -rf /tmp/et && rm -rf /tmp/etl \
    && mkdir /opt/mappool && chown -R application:application /opt/mappool

RUN apt-get update && apt-get install -y gcc-multilib && rm -rf /var/lib/apt/lists/*

VOLUME [ "/opt/mappool" ]

ADD entrypoint.d /entrypoint.d
CMD [ "exec-as-user", "/opt/application/etlded", "+set", "fs_game", "nitmod", "+exec", "server.cfg" ]
