cask "cue-notchpad" do
  version "0.1.0"
  sha256 "620d7a220c7a8bef51b497e14dc65d6014f1b0b4952ce09546dd905ee80d6ba1"

  url "https://github.com/haotzops/cue-notchpad/releases/download/v#{version}/Cue-Notchpad-#{version}-macOS-universal.zip"
  name "Cue Notchpad"
  desc "Notch-attached prompt editor for command-line workflows"
  homepage "https://github.com/haotzops/cue-notchpad"

  depends_on macos: ">= :ventura"

  app "Cue Notchpad.app"
  binary "#{appdir}/Cue Notchpad.app/Contents/MacOS/cue", target: "cue"

  caveats <<~EOS
    Cue Notchpad #{version} 使用 ad-hoc 签名，未经过 Apple 公证。
    确认下载来源可信后，可在“系统设置 → 隐私与安全性”选择“仍要打开”，
    或仅移除该 app 的 quarantine 属性：

      xattr -dr com.apple.quarantine "#{appdir}/Cue Notchpad.app"
  EOS
end
