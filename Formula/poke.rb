class Poke < Formula
  desc "A simple CLI poke tool"
  homepage ""
  version "0.4"
  
  url "file://#{ENV['HOME']}/poke/poke-0.4.tar.gz"
  sha256 "e84ac1833e2a033fa086d9246bfa48a915a834a4c438547a3a5bf343677e5905"
  
  def install
    bin.install "poke"
  end
  
  test do
    system "poke", "version"
  end
end
