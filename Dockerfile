FROM orgsync/java8
MAINTAINER clifton <cliftonk@gmail.com>

# install xvfb and other X dependencies for IB
RUN apt-get update -y \
    && apt-get install -y xvfb libxrender1 libxtst6 x11vnc socat unzip \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN mkdir /ib-gateway
WORKDIR /ib-gateway

# download and install the IB-gateway
RUN wget -O total.jar -q https://download2.interactivebrokers.com/java/classes/total.2015.jar \
    && wget -O jts.jar -q https://download2.interactivebrokers.com/java/classes/latest/jts.latest.jar \
    && wget https://github.com/ib-controller/ib-controller/releases/download/2.12.1/IBController-2.12.1.zip \
    && unzip IBController-2.12.1.zip

# install init scripts and binaries
ADD config/jts.ini /ib-gateway/jts.ini
ADD init/xvfb_init /etc/init.d/xvfb
ADD init/vnc_init /etc/init.d/vnc
ADD bin/xvfb-daemon-run /usr/bin/xvfb-daemon-run
ADD bin/run-gateway /usr/bin/run-gateway

# IBController and automatic login
ADD config/IBController.ini /ib-gateway/IBController/
ADD config/tws_credentials.txt /ib-gateway/IBController/
RUN cat /ib-gateway/IBController/tws_credentials.txt >> /ib-gateway/IBController/IBController.ini

# vnc (optional)
# set VNC_PASSWORD environment variable in docker-compose.yml to launch vnc

VOLUME /ib-gateway

ENV DISPLAY :0

CMD ["/usr/bin/run-gateway"]
