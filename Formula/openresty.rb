require 'formula'

class Openresty < Formula
  homepage 'http://openresty.org/'

  stable do
    url 'http://openresty.org/download/ngx_openresty-1.7.10.1.tar.gz'
    sha1 '0cc7a3fe75fbe50dec619af1a09b87f7f8c79e1d'
  end

  depends_on 'pcre'
  depends_on 'openssl'

  # openresty options
  option 'with-debug', "Compile with support for debug logging but without proper gdb debugging symbols"

  skip_clean 'logs'

  def install
    args = ["--prefix=#{prefix}",
      "--with-http_ssl_module",
      "--with-pcre",
      "--with-pcre-jit",
      "--sbin-path=#{bin}/nginx",
      "--conf-path=#{etc}/openresty/nginx.conf",
      "--pid-path=#{var}/run/openresty.pid",
      "--lock-path=#{var}/openresty/nginx.lock",
      "--with-http_gunzip_module"
    ]

    # Debugging mode, unfortunately without debugging symbols
    if build.with? 'debug'
      args << '--with-debug'
      args << '--with-dtrace-probes'
      args << '--with-no-pool-patch'
      args << '--with-luajit-xcflags=-DLUAJIT_ENABLE_CHECKHOOK'

      opoo "Openresty will be built --with-debug option, but without debugging symbols. For debugging symbols you have to compile it by hand."
    end

    system "./configure", *args

    system "make"
    system "make install"
  end
end
