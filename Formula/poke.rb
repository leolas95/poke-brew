class Poke < Formula
  desc "A simple CLI tool"
  homepage "https://github.com/leolas95/poke-brew"
  url "https://github.com/leolas95/poke-brew/archive/refs/tags/v0.6.tar.gz"
  sha256 "9c4ae49f869c32c9317dd0f6ddaa32545cb10ca750750128dee8071f2846038c"
  
  def install
    bin.install "bin/poke"
  end
  
  test do
    system "#{bin}/poke", "version"
  end
end
