# Dockerfile for Jellyfin including transcode directory cleanup

# load the base image for Jellyfin from linuxserver.io
FROM lscr.io/linuxserver/jellyfin:latest

# install procps and htop
RUN apt-get update \
    && apt-get install -y procps htop git --no-install-recommends

# download jellyfin-transcodes-cleanup
RUN mkdir -p /config \
    && cd /config \
    && git clone https://github.com/Paddy0174/jellyfin-transcodes-cleanup.git \
    && mkdir -p /config/jellyfin-transcodes-cleanup/semaphore \
    && mkdir -p /config/jellyfin-transcodes-cleanup/logs

# set executable permission
RUN chmod +x /config/jellyfin-transcodes-cleanup/transcode.cleanup.sh \
    && chmod +x /config/jellyfin-transcodes-cleanup/ffmpeg.wrap

# set the symlinks to include .wrap
RUN ln -sf /config/jellyfin-transcodes-cleanup/ffmpeg.wrap /usr/lib/jellyfin-ffmpeg/ffmpeg.wrap \
    && ln -sf /usr/lib/jellyfin-ffmpeg/ffprobe /usr/lib/jellyfin-ffmpeg/ffprobe.wrap

# set some env variables
ENV JTC_FFMPEG_DIR='/config/jellyfin-transcodes-cleanup'
ENV JTC_SCRIPT_DIR='/config/jellyfin-transcodes-cleanup'
ENV JTC_TRANSCODES_DIR='/config/data/transcodes'
ENV JTC_SEMAPHORE_DIR='/config/jellyfin-transcodes-cleanup/semaphore'
ENV JTC_LOG_DIR='/config/jellyfin-transcodes-cleanup/logs'
ENV JTC_CLEANUP_PROG='/config/jellyfin-transcodes-cleanup/transcode.cleanup.sh'
# ENV JTC_CLEANUP_LOG_MAXSIZE=''
