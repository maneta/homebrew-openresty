require 'formula'

class Luarocks < Formula

  homepage 'https://luarocks.org'

  stable do
    url 'https://github.com/keplerproject/luarocks/archive/v2.4.2.tar.gz'
    sha256 'f6c81ce3d0e5c6fe95df664a9173b516cc2b6916254128e76a8f37b5392ae081'
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
