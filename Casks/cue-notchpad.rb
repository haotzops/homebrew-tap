cask "cue-notchpad" do
  version "0.1.0"
  sha256 "620d7a220c7a8bef51b497e14dc65d6014f1b0b4952ce09546dd905ee80d6ba1"

  url "https://github.com/haotzops/cue-notchpad/releases/download/v#{version}/Cue-Notchpad-#{version}-macOS-universal.zip"
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
