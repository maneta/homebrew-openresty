require 'formula'

class Luarocks < Formula

  homepage 'https://rocks.moonscript.org/'

  stable do
    url 'http://keplerproject.github.io/luarocks/releases/luarocks-2.2.1.tar.gz'
    sha1 '82b858889e31ec0eb4d05ce7ea3a72fdf5403aad'
  end

  depends_on "apitools/openresty/openresty"

  def install
    openresty_folder                 = Formula["openresty"].opt_prefix
    openresty_luajit_folder          = File.join(openresty_folder, 'luajit')
    openresty_luajit_include_folder  = File.join(openresty_luajit_folder, 'include', 'luajit-2.1')


    args = ["--prefix=#{prefix}",
            "--with-lua=#{openresty_luajit_folder}",
            "--lua-suffix=jit-2.1.0-alpha",
            "--with-lua-include=#{openresty_luajit_include_folder}"]

    system "./configure", *args
    system "make", "build"
    system "make", "install"
  end

end
