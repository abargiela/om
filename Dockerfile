FROM ubuntu:14.04

WORKDIR /opt/

RUN apt-get update
RUN apt-get -qy upgrade

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -qy oracle-java8-installer

RUN apt-get install -qy oracle-java8-set-default

RUN apt-get install -qy libreoffice

RUN apt-get install -qy imagemagick gdebi libgif4 libgif-dev synaptic zlib1g-dev liboil0.3 unzip make
RUN apt-get install -qy build-essential libfreetype6-dev wget

#RUN cd /opt
RUN wget http://sourceforge.net/projects/sox/files/sox/14.4.2/sox-14.4.2.tar.gz
RUN tar xzvf sox-14.4.2.tar.gz -C /opt


RUN /opt/sox-14.4.2/configure
RUN cd /opt/sox-14.4.2
RUN make && make install

#RUN cd /opt
RUN apt-get -yq  install libart-2.0-2  libjpeg62
RUN wget http://old-releases.ubuntu.com/ubuntu/pool/universe/s/swftools/swftools_0.9.0-0ubuntu1_amd64.deb
RUN dpkg -i swftools_0.9.0-0ubuntu1_amd64.deb
RUN echo "swftools hold" | sudo dpkg --set-selections

#RUN echo 'deb http://ftp.us.debian.org/debian jessie contrib non-free \n deb http://ftp.us.debian.org/debian jessie contrib' > /etc/apt/sources.list

RUN apt-get update
RUN apt-get  -qy install flashplugin*

RUN cd /opt
RUN wget http://jodconverter.googlecode.com/files/jodconverter-core-3.0-beta-4-dist.zip
RUN unzip jodconverter-core-3.0-beta-4-dist.zip

RUN apt-get -yq --force-yes install autoconf automake libass-dev libfreetype6-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev nasm libx264-dev cmake mercurial libopus-dev
#RUN apt-get -qy install lame  libmp3lame0  libmp3lame-dev

RUN apt-get install -yq software-properties-common

RUN add-apt-repository ppa:mc3man/trusty-media
RUN sudo add-apt-repository ppa:mc3man/trusty-media
RUN sudo apt-get update

RUN apt-get -yq  install ffmpeg gstreamer0.10-ffmpeg
COPY ./ffmpeg.sh /opt
RUN bash /opt/ffmpeg.sh


# MariaDB
RUN apt-get -qy install python-software-properties
#apt-get -qy install software-properties-common


#####################
#######################ADICIONAR MARIADB
#####################


#Install openmeetings
RUN mkdir /opt/red5311
RUN cd /opt/red5311

RUN wget -c http://apache.rediris.es/openmeetings/3.1.2/bin/apache-openmeetings-3.1.2.tar.gz && tar -xzvf apache-openmeetings-3.1.2.tar.gz -C /opt/red5311/

RUN cd /opt

RUN wget --directory-prefix=/opt http://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar
RUN cp -a /opt/mysql-connector-java-5.1.38.jar /opt/red5311/webapps/openmeetings/WEB-INF/lib

#Now we are going to form OpenMeetings for our database in MariaDB:
RUN sed -i 's,localhost:3306/openmeetings,localhost:3306/open311,g' /opt/red5311/webapps/openmeetings/WEB-INF/classes/META-INF/mysql_persistence.xml

RUN sed -i 's,Username=root,Username=hola,g' /opt/red5311/webapps/openmeetings/WEB-INF/classes/META-INF/mysql_persistence.xml
RUN sed -i 's,Password=\",Password=123456\",g' /opt/red5311/webapps/openmeetings/WEB-INF/classes/META-INF/mysql_persistence.xml


RUN cd /opt
RUN wget -c "https://cwiki.apache.org/confluence/download/attachments/27838216/red5?version=4&modificationDate=1458903758300&api=v2" -O red5
#RUN mv red5?version=4 red5
RUN cp /opt/red5 /etc/init.d/
RUN chmod +x /etc/init.d/red5
ENTRYPOINT ["/etc/init.d/red5" , "start"]

EXPOSE 5080 80 443
