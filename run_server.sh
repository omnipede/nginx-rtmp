docker build -t media .
docker run --rm \
-p 80:80 \
-p 8080:8080 \
-p 1935:1935 \
-v /Users/seohyeongyu/Desktop/work/nginx-rtmp/nginx.conf:/etc/nginx/nginx.conf \
media