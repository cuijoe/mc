# Minecraft 1.8.8 Dockerfile - Example with notes


# Use the offical Debian Docker image with a specified version tag, Wheezy, so not all
# versions of Debian images are downloaded.
FROM debian:wheezy
MAINTAINER qida <sunqida@foxmail.com>

# Use APT (Advanced Packaging Tool) built in the Linux distro to download Java, a dependency
# to run Minecraft.
RUN     apt-get -y update && \
        apt-get -y install openjdk-7-jre-headless wget unzip

RUN     apt-get -y install locales && \
        sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
        locale-gen && \
        update-locale LC_ALL= "zh_CN.UTF-8" && \
        export LANGUAGE=zh_CN && \
        export LANG=zh_CN.UTF-8 && \
        locale && \
        sed -i '$a \
        * soft nproc 65536 \
        * hard nproc 65536  \
        * soft nofile 65536  \
        * hard nofile 65536 ' /etc/security/limits.conf && \ 
        echo "Asia/Shanghai" | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
# 设置时区
ENV     TZ "PRC"


# 删除不必要的软件和Apt缓存包列表
RUN     apt-get autoclean && \
        apt-get autoremove && \
        rm -rf /var/lib/apt/lists/* && \
        # Download Minecraft Server components
        wget -q http://shanlinfeiniao.oss-cn-qingdao.aliyuncs.com/mc.jar
        wget -q http://shanlinfeiniao.oss-cn-qingdao.aliyuncs.com/world.zip
	

CMD echo eula=true > /data/eula.txt && java -jar /spigot-1.7.10-R0.1-SNAPSHOTBuild1646.jar
RUN	kill java -9
	rm -rf world
	rm server.properties
	wget -q http://shanlinfeiniao.oss-cn-qingdao.aliyuncs.com/server.properties
	unzip world.zip
CMD echo eula=true > /data/eula.txt && java -jar /spigot-1.7.10-R0.1-SNAPSHOTBuild1646.jar


