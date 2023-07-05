# -stream_loop -1: infinite loop
# ffmpeg -nostdin -re -stream_loop 1 -i example.mp4 -c copy \
# -f flv -flvflags no_duration_filesize rtmp://localhost:1935/live/mystream

# ffmpeg -re -stream_loop -1 -i example.mp4 -c:a aac -c:v libx264 \
# -f flv rtmp://localhost:1935/hls/mystream

ffmpeg -loglevel verbose -re -i example.mp4  -vcodec libx264 \
    -vprofile baseline -acodec libmp3lame -ar 44100 -ac 1 \
    -f flv -flvflags no_duration_filesize rtmp://localhost:1935/live/mystream
