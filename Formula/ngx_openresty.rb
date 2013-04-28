require 'formula'

class NgxOpenresty < Formula
  homepage 'http://openresty.org/'
  url 'http://openresty.org/download/ngx_openresty-1.2.7.6.tar.gz'
  sha1 'f7a5c697d6cae8473023375cedae56752bea442b'

  depends_on 'pcre'
  depends_on 'luajit' if build.include? 'with-luajit'
  depends_on 'libdrizzle' if build.include? 'with-drizzle'

  option 'with-luajit', "Compile with support for the Lua Just-In-Time Compiler"
  option 'with-drizzle', "Compile with support for upstream communication with MySQL and/or Drizzle database servers"
  option 'with-postgres', "Compile with support for direct communication with PostgreSQL database servers"
  option 'with-iconv', "Compile with support for converting character encodings"

  skip_clean 'logs'

  def install
    args = ["--prefix=#{prefix}",
      "--with-http_ssl_module",
      "--with-pcre",
      "--with-cc-opt='-I#{HOMEBREW_PREFIX}/include'",
      "--with-ld-opt='-L#{HOMEBREW_PREFIX}/lib'",
      "--sbin-path=#{bin}/openresty",
      "--conf-path=#{etc}/openresty/nginx.conf",
      "--pid-path=#{var}/run/openresty.pid",
      "--lock-path=#{var}/openresty/nginx.lock"
    ]

    args << "--with-http_dav_module" if build.include? 'with-webdav'

    # OpenResty options
    args << "--with-luajit" if build.include? 'with-luajit'
    args << "--with-http_drizzle_module" if build.include? 'with-drizzle'
    args << "--with-http_postgres_module" if build.include? 'with-postgres'
    args << "--with-http_iconv_module" if build.include? 'with-iconv'

    system "./configure", *args
    system "make"
    system "make install"
  end
end