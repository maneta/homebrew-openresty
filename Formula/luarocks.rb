require 'formula'

class Luarocks < Formula

  homepage 'https://rocks.moonscript.org/'

  stable do
    url 'https://github.com/keplerproject/luarocks/archive/v2.3.0.tar.gz'
    sha256 '92c014889ec6a09c4bb492df6b7f7be784110d6abe031e16418342781ca5c5ce'
  end

  depends_on "homebrew/nginx/openresty"

  def install
    openresty_folder                 = Formula["homebrew/nginx/openresty"].opt_prefix
    openresty_luajit_folder          = File.join(openresty_folder, 'luajit')
    openresty_luajit_include_folder  = File.join(openresty_luajit_folder, 'include', 'luajit-2.1')

    system "./configure",
           "--prefix=#{prefix}",
           "--rocks-tree=#{HOMEBREW_PREFIX}",
           "--with-lua=#{openresty_luajit_folder}",
           "--with-lua-include=#{openresty_luajit_include_folder}",
           "--lua-version=5.1",
           "--lua-suffix=jit"

    system "make", "build"
    system "make", "install"
  end

end
