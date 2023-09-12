fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### init_project

```sh
[bundle exec] fastlane init_project
```

Init project with shared variables

### bump_version_number_and_build_number

```sh
[bundle exec] fastlane bump_version_number_and_build_number
```

Bump version and build number

### retrieve_version

```sh
[bundle exec] fastlane retrieve_version
```

Retrieve version with regex parameter

### display_badge_on_appIcon

```sh
[bundle exec] fastlane display_badge_on_appIcon
```

Add badge on the appIcon

https://github.com/HazAT/badge

Option 1 : No badge and display only version or not

Option 2 : Alpha badge and display version or not and chosse the mode: dark or light

Option 3 : Beta badge and display version or not and chosse the mode: dark or light

### download_certificates_and_profiles

```sh
[bundle exec] fastlane download_certificates_and_profiles
```

Download certificates and profiles

### build

```sh
[bundle exec] fastlane build
```

Build iOS

### deploy

```sh
[bundle exec] fastlane deploy
```

Deploy iOS

### generate_release_note

```sh
[bundle exec] fastlane generate_release_note
```

Generate release note between two tags

----


## iOS

### ios setup_project

```sh
[bundle exec] fastlane ios setup_project
```

Init project variables

### ios build_ios

```sh
[bundle exec] fastlane ios build_ios
```

Build

### ios gen

```sh
[bundle exec] fastlane ios gen
```

Gen

### ios deploy_ios

```sh
[bundle exec] fastlane ios deploy_ios
```

Deploy

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
