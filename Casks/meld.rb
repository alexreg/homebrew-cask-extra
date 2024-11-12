cask "meld" do
  arch arm: "arm64", intel: "x86_64"

  version "3.22.2+68"
  sha256 "5c21f6a4c5aad410e515484740b461fefdfa231635326c69a844938b4dfe37b5"

  url "https://gitlab.com/api/v4/projects/51547804/packages/generic/meld_macos/#{version}/Meld-#{version}_#{arch}.dmg",
      verified: "https://gitlab.com/api/v4/projects/51547804"
  name "Meld for macOS"
  desc "Visual diff and merge tool"
  homepage "https://gitlab.com/dehesselle/meld_macos"

  conflicts_with cask: "meld@cask"

  depends_on macos: ">= :high_sierra"

  app "Meld.app"
  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/meld.wrapper.sh"
  binary shimscript, target: "meld"

  preflight do
    File.write shimscript, <<~EOS
      #!/bin/sh
      exec '#{appdir}/Meld.app/Contents/MacOS/Meld' "$@"
    EOS
  end

  zap trash: [
    "~/.local/share/meld",
    "~/Library/Preferences/org.gnome.meld.plist",
    "~/Library/Saved Application State/org.gnome.meld.savedState/",
  ]
end
