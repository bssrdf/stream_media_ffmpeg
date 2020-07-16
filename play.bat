"C:\Program Files\ffmpeg\bin\ffmpeg" -re -stream_loop -1 -i %1 -filter:v subtitles=%1 -vcodec libx264 -f rtsp -rtsp_transport udp rtsp://192.168.x.x:####/streamname
