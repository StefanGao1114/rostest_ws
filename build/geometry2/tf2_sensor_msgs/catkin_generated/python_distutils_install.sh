#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/stefan/rostest_ws/src/geometry2/tf2_sensor_msgs"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/stefan/rostest_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/stefan/rostest_ws/install/lib/python3/dist-packages:/home/stefan/rostest_ws/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/stefan/rostest_ws/build" \
    "/usr/bin/python3" \
    "/home/stefan/rostest_ws/src/geometry2/tf2_sensor_msgs/setup.py" \
     \
    build --build-base "/home/stefan/rostest_ws/build/geometry2/tf2_sensor_msgs" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/stefan/rostest_ws/install" --install-scripts="/home/stefan/rostest_ws/install/bin"
