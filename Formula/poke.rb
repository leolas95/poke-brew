class Poke < Formula
  desc "A simple CLI tool"
  homepage "https://github.com/leonardo/poke-brew"
  url "https://github.com/leonardo/poke-brew/archive/refs/tags/v0.5.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  
  def install
    bin.install "bin/poke"
  end
  
  test do
    system "#{bin}/poke", "version"
  end
end
