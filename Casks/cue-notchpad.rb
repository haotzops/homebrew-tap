cask "cue-notchpad" do
  version "0.3.1"
  sha256 "697330d6f34e8d7b1ddaccf8577dd49bf0e7bfa16842cd560f91f4a7f7691e67"

  url "https://github.com/haotzops/cue-notchpad/releases/download/v#{version}/Cue-Notchpad-#{version}-macOS-arm64.zip"
  name "Cue Notchpad"
  desc "Notch-attached prompt editor for command-line workflows"
  homepage "https://github.com/haotzops/cue-notchpad"

  depends_on macos: :ventura

  app "Cue Notchpad.app"
  binary "#{appdir}/Cue Notchpad.app/Contents/MacOS/cue", target: "cue"

  postflight do
    app_path = appdir/"Cue Notchpad.app"
    next unless app_path.exist?

    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", app_path]
  end

  caveats <<~EOS
    Cue Notchpad #{version} 使用 ad-hoc 签名，未经过 Apple 公证。
    Homebrew 安装完成后会自动移除该 app 的 quarantine 属性。
  EOS
end
