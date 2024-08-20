class Retire < Formula
  desc "Scanner detecting the use of JavaScript libraries with known vulnerabilities"
  homepage "https://retirejs.github.io/retire.js/"
  url "https://registry.npmjs.org/retire/-/retire-5.2.2.tgz"
  sha256 "2e5998d559f651ef813421b3d1f9fac1eb892647f21ccd9274d80dee4d68fce2"
  license "Apache-2.0"
  head "https://github.com/RetireJS/retire.js.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "146c942f40acc45e420d76664e34cc3e059b85e04eeba3577e53d9b9212bf4ce"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/retire --version")

    system "git", "clone", "https://github.com/appsecco/dvna.git"
    output = shell_output("#{bin}/retire --path dvna 2>&1", 13)
    assert_match(/jquery (\d+(?:\.\d+)+) has known vulnerabilities/, output)
  end
end
