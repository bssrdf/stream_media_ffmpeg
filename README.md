# Streaming videos over LAN using rtsp-simple-server and ffmpeg  

## Introduction

I have been looking for ways to stream x265(HEVC) videos to an old Android TV box which doesn't have hardware x265 codecs. Here is one solution able to stream smoothly with subtitle support. 

## Required
1. FFmpeg
2. [rtsp-simple-server](https://github.com/aler9/rtsp-simple-server)
3. VLC or other clients which support rtsp playback

## Steps

1. Install FFmpeg
2. Config FFmpeg font by following instructions [here](https://blob.pureandapplied.com.au/solved-ffmpeg-fontconfig-woes-on-windows/) (Windows only)
3. Install rtsp-simple-server by following instructions [here](https://github.com/aler9/rtsp-simple-server)
4. Start rtsp-simple-server

   `c:\path\to\rtsp-simple-server\rtsp-simple-server`

5. Publish a stream from a video file with FFmpeg, e.g.,

    `"C:\Program Files\ffmpeg\bin\ffmpeg" -re -stream_loop -1 -i input.mkv -filter:v subtitles=input.mkv -vcodec libx264 -f rtsp -rtsp_transport udp rtsp://192.168.x.x:port#/streamname`
   
    - the absolute path to ffmpeg executable is necessary, see [here](https://stackoverflow.com/questions/46212237/ffmpeg-hardcoding-subtitles-fontconfig-error)
    - `input.mkv` is the media file which may contain embedded subtitle; if the subtitle is in a separate file, e.g., `sub.srt`, replace `subtitles=input.mkv` with `subtitles=sub.srt`; for other subtitle formats, see [here](https://trac.ffmpeg.org/wiki/HowToBurnSubtitlesIntoVideo)
    - `libx264` is used here to encode streams, which has hardware support on almost all devices (even very old ones)   

    - `192.168.x.x` is the ip address of the machine as stream server
    - `port#` must be the same as specified in rtsp-simple-server.yml   

        `# port of the TCP RTSP listener`

        `rtspPort: 8554`
    
    - pick a `streamname`

6. Open VLC or other clients, choose rtsp as source `rtsp://192.168.x.x:port#/streamname`
7. Enjoy


