class Eureka < Formula
  desc "CLI tool to input and store your ideas without leaving the terminal"
  homepage "https://github.com/simeg/eureka"
  url "https://github.com/simeg/eureka/archive/v2.0.0.tar.gz"
  sha256 "e874549e1447ee849543828f49c4c1657f7e6cfe787deea13d44241666d4aaa0"
  license "MIT"
  head "https://github.com/simeg/eureka.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "3a9a6d7a5b0a7e599f5704bb7729285836bb25978a586243e5fb78695c30a157"
    sha256 cellar: :any,                 arm64_big_sur:  "861dfd095945e5600666a2ca79366b52df59a72cc27e0d25e6b10a60c5781066"
    sha256 cellar: :any,                 monterey:       "37888fa43d99d9740479bf57078b60a87eaaf7f082f18a790bdf81df6fb4ce8e"
    sha256 cellar: :any,                 big_sur:        "6b50c3a975f63a84f975c16b919f775ffb163d8b7c1d40f0219ee660d12f9f88"
    sha256 cellar: :any,                 catalina:       "0e7559a426bc893f8c14aca3e9110465658a94a0fb7561264e05fcf3c8756096"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b8df396a1e2c9e87f093dfd44dafed480bd97ff2115beac25725d12d3d028439"
  end

  depends_on "rust" => :build
  depends_on "openssl@3"

  uses_from_macos "zlib"

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "eureka [OPTIONS]", shell_output("#{bin}/eureka --help 2>&1")

    (testpath/".eureka/repo_path").write <<~EOS
      homebrew
    EOS

    assert_match "ERROR eureka > No such file or directory", pipe_output("#{bin}/eureka --view 2>&1")
  end
end
