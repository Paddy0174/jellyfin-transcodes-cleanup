# Dockerfile for Jellyfin
# Added transcode directory cleanup

# set some env variables
ENV JTC_FFMPEG_DIR='/config/jellyfin-transcodes-cleanup'
    JTC_SCRIPT_DIR='/config/jellyfin-transcodes-cleanup'
    JTC_TRANSCODES_DIR='/config/data/transcodes'
    JTC_SEMAPHORE_DIR='/config/jellyfin-transcodes-cleanup/semaphore'
    JTC_LOG_DIR='/config/jellyfin-transcodes-cleanup/logs'
    JTC_CLEANUP_PROG='/config/jellyfin-transcodes-cleanup/transcode.cleanup.sh'
#    JTC_CLEANUP_LOG_MAXSIZE=''

# load the base image for Jellyfin from linuxserver.io
FROM lscr.io/linuxserver/jellyfin:latest

# install procps and htop
RUN apt-get update \
    && apt-get install -y procps htop git --no-install-recommends

# download jellyfin-transcodes-cleanup
RUN mkdir -p /config \
    && mkdir -p /config/jellyfin-transcodes-cleanup/semaphore
    && mkdir -p /config/jellyfin-transcodes-cleanup/logs
    && cd /config \
    && git clone https://github.com/Paddy0174/jellyfin-transcodes-cleanup.git

# set executable permission
RUN chmod +x /config/jellyfin-transcodes-cleanup/transcode.cleanup.sh \
    && chmod +x /config/jellyfin-transcodes-cleanup/ffmpeg.wrap

# set the symlinks to include .wrap
RUN ln -sf /config/jellyfin-transcodes-cleanup/ffmpeg.wrap /usr/lib/jellyfin-ffmpeg/ffmpeg.wrap \
    && ln -sf /usr/lib/jellyfin-ffmpeg/ffprobe /usr/lib/jellyfin-ffmpeg/ffprobe.wrap
