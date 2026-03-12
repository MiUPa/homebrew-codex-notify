class CodexNotify < Formula
  desc "macOS desktop notification bridge for Codex CLI"
  homepage "https://github.com/MiUPa/codex-notify"
  version "0.3.3"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/MiUPa/codex-notify/releases/download/v0.3.3/codex-notify_v0.3.3_darwin_arm64.tar.gz"
    sha256 "967cb8e22f8213dd0c1cb2a18008afd193fca6088721b00184ade49260c0871d"
  else
    url "https://github.com/MiUPa/codex-notify/releases/download/v0.3.3/codex-notify_v0.3.3_darwin_amd64.tar.gz"
    sha256 "e0142ffa4959956dd51471da71a882ad300d8eff6afb23e3495c6fc98c8226ec"
  end

  def install
    bin.install "codex-notify"
  end

  def post_install
    system_command(bin/"codex-notify", args: ["init"])
  rescue ErrorDuringExecution
    opoo "Automatic Codex notify hook setup failed. Run `codex-notify init --replace` manually."
  end

  test do
    assert_match "macOS desktop notifications for Codex CLI", shell_output("#{bin}/codex-notify help")
  end
end
