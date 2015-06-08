require 'formula'

class Luarocks < Formula

  homepage 'https://rocks.moonscript.org/'

  stable do
    url 'http://keplerproject.github.io/luarocks/releases/luarocks-2.2.2.tar.gz'
    sha1 'eb867374e5a11edb705fd9fab3b47b083a9e55a6'
  end

  depends_on "apitools/openresty/openresty"

  def install
    openresty_folder                 = Formula["openresty"].opt_prefix
    openresty_luajit_folder          = File.join(openresty_folder, 'luajit')
    openresty_luajit_include_folder  = File.join(openresty_luajit_folder, 'include', 'luajit-2.1')

    system "./configure",
           "--prefix=#{prefix}",
           "--rocks-tree=#{HOMEBREW_PREFIX}",
           "--with-lua=#{openresty_luajit_folder}",
           "--with-lua-include=#{openresty_luajit_include_folder}",
           "--lua-suffix=jit-2.1.0-alpha"

    system "make", "build"
    system "make", "install"
  end

end
