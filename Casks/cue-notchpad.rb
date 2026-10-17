cask "cue-notchpad" do
  version "0.5.0"
  sha256 "1fe055790b329f49a618c6d92b653d3b3db38a559971585a1b11f92bab2d5b11"

  url "https://github.com/haotzops/cue-notchpad/releases/download/v#{version}/Cue-Notchpad-#{version}-macOS-arm64.zip"
  name "Cue Notchpad"
  desc "Notch-attached prompt editor for command-line workflows"
  homepage "https://github.com/haotzops/cue-notchpad"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  preflight do
    result = system_command(
      "/usr/bin/pgrep",
      args: ["-x", "cue-host"],
      must_succeed: false,
      print_stdout: false,
      print_stderr: false,
    )
    raise Cask::CaskError, "Cue has an active edit session; submit or cancel it before updating." if result.success?
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
    Set the editor in your coding agent's settings file to:
      "externalEditor": "cue --wait"
  EOS
end
