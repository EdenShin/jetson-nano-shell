sudo cp libcudnn.so.7.3.1 libcudnn_static_v7.a /usr/lib/aarch64-linux-gnu/
sudo cp cudnn_v7.h /usr/include/aarch64-linux-gnu/

sudo ln -s /usr/lib/aarch64-linux-gnu/libcudnn.so.7.3.1 /usr/lib/aarch64-linux-gnu/libcudnn.so.7
sudo ln -s /usr/include/aarch64-linux-gnu/cudnn_v7.h /etc/alternatives/libcudnn 
sudo ln -s /usr/lib/aarch64-linux-gnu/libcudnn.so.7 /etc/alternatives/libcudnn_so 
sudo ln -s /usr/lib/aarch64-linux-gnu/libcudnn_static_v7.a /etc/alternatives/libcudnn_stlib

sudo ln -s /etc/alternatives/libcudnn_stlib /usr/lib/aarch64-linux-gnu/libcudnn_static.a 
sudo ln -s /etc/alternatives/libcudnn_so /usr/lib/aarch64-linux-gnu/libcudnn.so
sudo ln -s /etc/alternatives/libcudnn /usr/include/cudnn.h
