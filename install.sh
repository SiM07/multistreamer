apt-get install -y libreadline-dev libncurses5-dev libpcre3-dev \
    libssl-dev perl make build-essential unzip curl git
mkdir openresty-build && cd openresty-build
curl -R -L https://openresty.org/download/openresty-1.11.2.2.tar.gz | tar xz
curl -R -L https://github.com/arut/nginx-rtmp-module/archive/v1.1.10.tar.gz | tar xz
curl -R -L https://github.com/openresty/stream-lua-nginx-module/archive/e527417c5d04da0c26c12cf4d8a0ef0f1e36e051.tar.gz | tar xz
curl -R -L http://luarocks.github.io/luarocks/releases/luarocks-2.4.2.tar.gz | tar xz
cd openresty-1.11.2.2
./configure \
  --prefix=/opt/openresty-rtmp \
  --with-pcre-jit \
  --with-ipv6 \
  --with-stream \
  --with-stream_ssl_module \
  --add-module=../nginx-rtmp-module-1.1.10 \
  --add-module=../stream-lua-nginx-module-e527417c5d04da0c26c12cf4d8a0ef0f1e36e051
make
make install
cd ../luarocks-2.4.2
./configure \
  --prefix=/opt/openresty-rtmp \
  --with-lua=/opt/openresty-rtmp/luajit \
  --lua-suffix=jit \
  --with-lua-include=/opt/openresty-rtmp/luajit/include/luajit-2.1

luarocks install lua-resty-jit-uuid
luarocks install lua-resty-string
luarocks install lua-resty-http
luarocks install lua-resty-upload
luarocks install lua-resty-exec
luarocks install lapis
luarocks install etlua
luarocks install luaposix
luarocks install luafilesystem
luarocks install whereami

