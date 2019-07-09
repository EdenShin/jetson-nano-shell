sudo apt-get install libwxgtk2.8-dev
sudo apt-get install libwxgtk2.8-0
# There is a fuck release problem. Fuck it

wget http://sourceforge.net/projects/codeblocks/files/Sources/17.12/codeblocks_17.12.tar.xz
tar -xf codeblocks_17.12.tar.xz && mv codeblocks-17.12 codeblocks

wget http://www.wxwidgets.org/
tar -xf wxgtk-2.8.12.tar.gz && cd wxGTK-2.8.12

mkdir build_gtk2_shared_monolithic_unicode
cd build_gtk2_shared_monolithic_unicode
../configure --prefix=/opt/wx/2.8.12 \
       --build=aarch64-unknown-linux-gnu \
       --enable-monolithic \
       --enable-xrc \
       --enable-unicode

make -j4
sudo make install

echo "export PATH=/usr/bin:/opt/wx/2.8.12/bin:$PATH" >> ~/.bashrc
source ~/.bashrc

sudo -i
echo "/opt/wx/2.8.12/lib" >> /etc/ld.so.conf
exit

sudo ldconfig
source /etc/profile

wx-config --prefix

cd ../../codeblock
echo `wx-config --prefix`/share/aclocal >> /usr/share/aclocal/dirlist
./bootstrap
./configure
make -j4
sudo make install

# codeblocks: error while loading shared libraries: libcodeblocks.so.0: cannot open shared object file: No such file or directory
sudo -i
echo "export /usr/local/lib" >> /etc/ld.so.conf
ldconfig
source /etc/profile
exit
