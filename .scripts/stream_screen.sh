sudo modprobe v4l2loopback
sudo ffmpeg -probesize 100M -framerate 15 -f x11grab -video_size 1280x720 -i :0.0+0,0 -vcodec rawvideo -pix_fmt yuv420p -f v4l2 /dev/videoN
