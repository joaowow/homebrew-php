require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Phpmyadmin < Formula
  desc "A web interface for MySQL and MariaDB"
  homepage "https://www.phpmyadmin.net"
  url "https://files.phpmyadmin.net/phpMyAdmin/4.7.1/phpMyAdmin-4.7.1-all-languages.tar.gz"
  sha256 "de1f4a9c1f917ae63b07be4928d9b9dba7f29c51b1e1be3ed351d1bc278a8b28"
  head "https://github.com/phpmyadmin/phpmyadmin.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0dde03d72e14161737f6a75e8d18760ab5ee9179add2bf138a56601abf4921a2" => :sierra
    sha256 "8a77bdd3e53dd844338f7f51128fb4f30c251f9c268a22e0c944eb9777b31d09" => :el_capitan
    sha256 "f8025c8d511006823e70acf5d4fbbf36d8e73731dd17db93f16554b525629a9d" => :yosemite
  end

  depends_on PhpMetaRequirement
  depends_on "php53-mcrypt" if Formula["php53"].linked_keg.exist?
  depends_on "php54-mcrypt" if Formula["php54"].linked_keg.exist?
  depends_on "php55-mcrypt" if Formula["php55"].linked_keg.exist?
  depends_on "php56-mcrypt" if Formula["php56"].linked_keg.exist?
  depends_on "php70-mcrypt" if Formula["php70"].linked_keg.exist?
  depends_on "php71-mcrypt" if Formula["php71"].linked_keg.exist?

  def install
    (share+"phpmyadmin").install Dir["*"]

    unless File.exist?(etc+"phpmyadmin.config.inc.php")
      cp (share+"phpmyadmin/config.sample.inc.php"), (etc+"phpmyadmin.config.inc.php")
    end
    ln_s (etc+"phpmyadmin.config.inc.php"), (share+"phpmyadmin/config.inc.php")
  end

  def caveats; <<-EOS.undent
    Note that this formula will NOT install mysql. It is not
    required since you might want to get connected to a remote
    database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance) :
      Alias /phpmyadmin #{HOMEBREW_PREFIX}/share/phpmyadmin
      <Directory #{HOMEBREW_PREFIX}/share/phpmyadmin/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        <IfModule mod_authz_core.c>
          Require all granted
        </IfModule>
        <IfModule !mod_authz_core.c>
          Order allow,deny
          Allow from all
        </IfModule>
      </Directory>
    Then, open http://localhost/phpmyadmin

    More documentation : file://#{pkgshare}/doc/

    Configuration has been copied to #{etc}/phpmyadmin.config.inc.php
    Don't forget to:
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)

    EOS
  end

  test do
    assert File.exist?("#{etc}/phpmyadmin.config.inc.php")
  end
end
