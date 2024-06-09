# Creates and runs a new container from an image
docker run -it --net=host \
               --device=/dev/ttyUSB0 \
               -e DISPLAY=$DISPLAY \
               --privileged \
               -v /home/${USER}/work:/workspace \
               esther:ros_ws_1

# docker run -it --net=host \
            #    --device=/dev/ttyUSB0 \
            #    -e DISPLAY=$DISPLAY \
            #    --privileged \
            #  -v /home/${USER}/work:/workspace \
            #    osrf/ros:noetic-desktop-full

# TODO setup network access
# `xhost` adds or deletes host names to the list of machines from which the X-server accepts connectinons.
# xhost +

