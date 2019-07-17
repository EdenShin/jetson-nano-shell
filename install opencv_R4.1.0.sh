sudo echo"deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu xenial main restricted universe multiverse" >> /etc/apt/sourcelist

echo "export CUBA_HOME=/usr/local/cuda-10.0 \
	export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH \
	export PATH=/usr/local/cuda-10.0/bin:$PATH" >> ~/.bashrc

sudo apt update

sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev python2.7-dev python3.6-dev python-dev python-numpy python3-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev libv4l-dev v4l-utils qv4l2 v4l2ucp wget

mkdir devel && cd devel

wget https://github.com/opencv/opencv/archive/4.1.0.zip -o opencv-4.1.0.zip
wget https://github.com/opencv/opencv_contrib/archive/4.1.0.zip -o opencv_contrib-4.1.0.zip
wget https://github.com/opencv/dldt/archive/2019_R1.1.zip -o dldt-2019_R1.1.zip

unzip -q opencv-4.1.0.zip opencv_contrib-4.1.0.zip dldt-2019_R1.1.zip

cd opencv-4.1.0
mkdir build && cd build

cmake -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.1.0/modules \
	-DWITH_GSTREAMER=ON -DWITH_LIBV4L=ON \
	-DBUILD_opencv_python2=ON -DBUILD_opencv_python3=ON \
	-DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_EXAMPLES=OFF \
	-DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local ..

make -j$(nproc)
sudo make install

echo "** Install opencv-4.1.0 successfully"
echo "** newt build opencv/dldt :)"

cd ../../dldt-2019_R1.1/inference-engine
mkdir build && cd build

cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_MKL_DNN=OFF -DENABLE_GNA=OFF -DENABLE_SSE42=OFF -DTHREADING=SEQ -DENABLE_CLDNN=OFF ..

make -j$(nproc)
sudo usermod -aG users "$(whoami)"
cd ../../
wget https://software.intel.com/sites/default/files/managed/05/1a/Setup%20Additional%20Files%20Package.tar.gz udev.tar.gz
tar xf udev.tar.gz
cd udev
sudo cp 97-myriad-usbboot.rules_.txt /etc/udev/rules.d/97-myriad-usbboot.rules
sudo udevadm control --reload-rules
sudo udevadm trigger 
sudo ldconfig

echo "** Install dldt successfully"
echo "** Bye :)"

sudo apt install libgoogle-glog-dev libatlas-base-dev
