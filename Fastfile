desc "Deploy a new version to the App Store"
lane :appstore do
  match(type: "appstore")
  snapshot
  gym
  deliver(force: true)
  frameit
end
lane :beta do
  ensure_git_status_clean

  # Increment the build number (not the version number)
  # Providing the xcodeproj is optional
  increment_build_number(xcodeproj: "OpenPokeMap.xcodeproj")

  # Commit the version bump
  commit_version_bump(xcodeproj: "OpenPokeMap.xcodeproj")

  # Add a git tag for this build. This will automatically
  # use an appropriate git tag name
  add_git_tag

  # Push the new commit and tag back to your git remote
  push_to_git_remote  

  match(type: "appstore")       # see code signing guide for more information
  gym(scheme: "OpenPokeMap")          # build your app
  testflight                    # upload your app to TestFlight
  slack(message: "Successfully distributed a new beta build")
end
