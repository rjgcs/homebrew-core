class AwsCdk < Formula
  desc "AWS Cloud Development Kit - framework for defining AWS infra as code"
  homepage "https://github.com/aws/aws-cdk"
  url "https://registry.npmjs.org/aws-cdk/-/aws-cdk-2.151.0.tgz"
  sha256 "7ed033d426ba3c8daca3d6413da68348f6424e16b40d360dba4ea2a954f54b93"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2312daea786e4b6ee833824cfa6c167601e5f246c918a0266bc208eb6ae23ed5"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2312daea786e4b6ee833824cfa6c167601e5f246c918a0266bc208eb6ae23ed5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2312daea786e4b6ee833824cfa6c167601e5f246c918a0266bc208eb6ae23ed5"
    sha256 cellar: :any_skip_relocation, sonoma:         "2312daea786e4b6ee833824cfa6c167601e5f246c918a0266bc208eb6ae23ed5"
    sha256 cellar: :any_skip_relocation, ventura:        "2312daea786e4b6ee833824cfa6c167601e5f246c918a0266bc208eb6ae23ed5"
    sha256 cellar: :any_skip_relocation, monterey:       "2312daea786e4b6ee833824cfa6c167601e5f246c918a0266bc208eb6ae23ed5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2b5e14ef6a9587e34cff624adf2c8a983d3499bbbe168ae1b451c269c204e90b"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Replace universal binaries with native slices.
    deuniversalize_machos
  end

  test do
    # `cdk init` cannot be run in a non-empty directory
    mkdir "testapp" do
      shell_output("#{bin}/cdk init app --language=javascript")
      list = shell_output("#{bin}/cdk list")
      cdkversion = shell_output("#{bin}/cdk --version")
      assert_match "TestappStack", list
      assert_match version.to_s, cdkversion
    end
  end
end
