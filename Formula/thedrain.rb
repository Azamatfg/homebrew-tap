class Thedrain < Formula
  desc "See what Claude actually did for you today — tokens, cost, commits, lines"
  homepage "https://github.com/Azamatfg/thedrain"
  url "https://github.com/Azamatfg/thedrain/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "ddc99be68276b68e0ffcd7192da9aabc0ac007dbeae6ac4be44afd1bb06ba36e"
  license "MIT"
  head "https://github.com/Azamatfg/thedrain.git", branch: "main"

  depends_on "python@3.12"

  def install
    libexec.install "drain.py", "engine.py", "legends.json"
    (bin/"drain").write <<~SH
      #!/bin/bash
      exec "#{Formula["python@3.12"].opt_bin}/python3.12" "#{libexec}/drain.py" "$@"
    SH
    chmod 0755, bin/"drain"
  end

  test do
    assert_match "usage", shell_output("#{bin}/drain --help")
  end
end
