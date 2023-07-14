# -stream_loop -1: infinite loop
ffmpeg -loglevel verbose -re -i example.mp4  -vcodec libx264 \
    -vprofile baseline -acodec libmp3lame -ar 44100 -ac 1 \
    -f flv -flvflags no_duration_filesize rtmp://localhost:1935/hls/mystream
