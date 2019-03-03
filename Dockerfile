FROM blackskyliner/base-centos

RUN yum install -y p7zip glibc.i686 libgcc.i686 libstdc++.i686
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
    && mkdir /opt/application/nitmod && unzip /tmp/nitmod.zip -d /opt/application/nitmod && rm /tmp/nitmod.zip \
    && mv /tmp/server.cfg /opt/application/etmain \
    && mv /tmp/nitmod.cfg /opt/application/nitmod \
    && chown -R application:application /opt/application \
    && find /opt/application -type f -exec chmod 0644 {} \;  \
    && find /opt/application -type d -exec chmod 0755 {} \;  \
    && chmod 0755 /opt/application/et /opt/application/et.x86 /opt/application/etded.x86 /opt/application/etl /opt/application/etl_bot.sh /opt/application/etl_renderer2.sh /opt/application/etlded /opt/application/etlded_bot.sh \
    && rm -rf /tmp/et && rm -rf /tmp/etl

VOLUME [ "/opt/application/etmain" ]
VOLUME [ "/opt/application/nitmod" ]

ADD entrypoint.d /entrypoint.d
CMD [ "run-as-user", "/opt/application/etlded", "+set", "fs_game", "nitmod", "+exec", "server.cfg" ]