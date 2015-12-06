# Minecraft 1.8.8 Dockerfile - Example with notes


# Use the offical Debian Docker image with a specified version tag, Wheezy, so not all
# versions of Debian images are downloaded.
FROM debian:wheezy
MAINTAINER qida <sunqida@foxmail.com>

# Use APT (Advanced Packaging Tool) built in the Linux distro to download Java, a dependency
# to run Minecraft.
RUN     apt-get -y update && \
        apt-get -y install openjdk-7-jre-headless wget

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
        wget -q http://getspigot.org/spigot/spigot-1.7.10-R0.1-SNAPSHOTBuild1646.jar
	wget -q http://shanlinfeiniao.oss-cn-qingdao.aliyuncs.com/mc.sh
	wget -q http://shanlinfeiniao.oss-cn-qingdao.aliyuncs.com/world.zip
		
# Sets working directory for the CMD instruction (also works for RUN, ENTRYPOINT commands)
WORKDIR /data
#服务配置文件
ADD server.properties /data/
# Create mount point, and mark it as holding externally mounted volume
VOLUME /data
# Expose the container's network port: 25565 during runtime.
EXPOSE 25565
#Automatically accept Minecraft EULA, and start Minecraft server
CMD echo eula=true > /data/eula.txt && java -jar /spigot-1.7.10-R0.1-SNAPSHOTBuild1646.jar

rm -rf world
wget unzip
unzip world.zip
CMD echo eula=true > /data/eula.txt && java -jar /spigot-1.7.10-R0.1-SNAPSHOTBuild1646.jar


