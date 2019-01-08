require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.9.3.tar.gz"
  sha256 "113b50fdd348d84743c1ec264167bcec5eb77d6a2cf9f07f15b7dab52f78ee55"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1ba457f7d919655e75a29360137cd141e6b77daea78b3d2878861cce8b1fd635" => :sierra
    sha256 "c8c273c604aaba8163d0599d6b191ff69917c0fd7f1f6683e9a6693bb3244b02" => :el_capitan
    sha256 "b5cf6472fefe7d51e1dbcee912c6062925630d2042ab94e1e43d694e1686b4eb" => :yosemite
  end

  depends_on "php71-ast"
  depends_on "php71"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
