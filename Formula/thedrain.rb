class Thedrain < Formula
  include Language::Python::Virtualenv

  desc "See what Claude actually did for you today — tokens, cost, commits, lines"
  homepage "https://github.com/Azamatfg/thedrain"
  url "https://github.com/Azamatfg/thedrain/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d7686b8e20186c8a49543ecd747bbfc6c23bc0db6c953741b86ccff1e6514b75"
  license "MIT"
  head "https://github.com/Azamatfg/thedrain.git", branch: "main"

  depends_on "python@3.12"

  def install
    libexec.install "drain.py", "engine.py", "legends.json"
    (bin/"drain").write <<~SH
      #!/bin/bash
      exec "#{Formula["python@3.12"].opt_bin}/python3.12" "#{libexec}/drain.py" "\"
    SH
    chmod 0755, bin/"drain"
  end

  test do
    assert_match "drain", shell_output("#{bin}/drain --help")
  end
end
