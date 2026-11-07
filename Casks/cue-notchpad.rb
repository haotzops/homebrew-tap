cask "cue-notchpad" do
  version "0.5.0"
  sha256 "1fe055790b329f49a618c6d92b653d3b3db38a559971585a1b11f92bab2d5b11"

  url "https://github.com/haotzops/cue-notchpad/releases/download/v#{version}/Cue-Notchpad-#{version}-macOS-arm64.zip"
  name "Cue Notchpad"
  desc "Notch-attached prompt editor for command-line workflows"
  homepage "https://github.com/haotzops/cue-notchpad"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  preflight_steps do
    run "/bin/sh", args: [
      "-c",
      'if /usr/bin/pgrep -x cue-host >/dev/null 2>&1; then ' \
      'echo "Cue has an active edit session; submit or cancel it before updating." >&2; ' \
      "exit 1; fi",
    ]
  end

  app "Cue Notchpad.app"
  command_wrapper "cue",
                   executable: "#{appdir}/Cue Notchpad.app/Contents/MacOS/cue"

  postflight_steps do
    if_path_exists "{{appdir}}/Cue Notchpad.app" do
      run "/usr/bin/xattr",
          args: ["-dr", "com.apple.quarantine", "{{appdir}}/Cue Notchpad.app"]
    end
  end

  caveats <<~EOS
    Cue Notchpad #{version} 使用 ad-hoc 签名，未经过 Apple 公证。
    Homebrew 安装完成后会自动移除该 app 的 quarantine 属性。
  EOS
end
