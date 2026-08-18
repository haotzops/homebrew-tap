cask "cue-notchpad" do
  version "0.4.0"
  sha256 "5b41c7a12a9302425e49deaefc2ba324201c6e920b14d47853056332aa6273c9"

  url "https://github.com/haotzops/cue-notchpad/releases/download/v#{version}/Cue-Notchpad-#{version}-macOS-arm64.zip"
  name "Cue Notchpad"
  desc "Notch-attached prompt editor for command-line workflows"
  homepage "https://github.com/haotzops/cue-notchpad"

  depends_on macos: :ventura
  depends_on arch: :arm64

  app "Cue Notchpad.app"
  command_wrapper "cue",
                   executable: "#{appdir}/Cue Notchpad.app/Contents/MacOS/cue"

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
