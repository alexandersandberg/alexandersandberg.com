---
title: Managing package dependencies with Swift Package Manager (SwiftPM) in Xcode
description: A simple guide to SwiftPM (Swift Package Manager).
layout: article
publishedAt: 2022-01-16
updatedAt: 2024-03-20
---

1. [Find a package](#find)
1. [Add a package](#add)
1. [Add to multiple targets](#multiple)
1. [Update packages](#update)
1. [Remove packages](#remove)

---

## <span id="find"></span>Find a package

You can find a small selection of curated packages on [Swift.org‘s Packages page](https://www.swift.org/packages/).

For a more complete library, the [Swift Package Index](https://swiftpackageindex.com) hosts a large number of packages for you to explore.

## <span id="add"></span>Add a package

In Xcode, go to **File → Add Package Dependencies...**

In the search field in the upper right, enter your package URL. This is usually a GitHub repository URL, like `https://github.com/apple/swift-markdown`.

![Xcode‘s add package dependency panel after finding your package](https://cdn.alexandersandberg.com/articles/swiftpm-add-package.png)

Select your package.

Select a **Dependency Rule**. In most cases, you probably want to set this to **Up to Next Major Version**.

Click **Add Package**.

Under **Add to Target**, select the target you want to add the package to.

![Xcode‘s add package dependency panel at the second step, when selecting a target to add the package to](https://cdn.alexandersandberg.com/articles/swiftpm-add-package-target.png)

Click **Add Package**.

_Done!_ Yes, it‘s that simple.

## <span id="multiple"></span>Add to multiple targets

Select the additional target you want to add your package to in the Project Editor.

In the **General** tab, scroll down to **Frameworks and Libraries** and click the **+ (plus)** below the list.

![Xcode‘s 'General' tab scrolled down to the 'Frameworks and Libraries' section](https://cdn.alexandersandberg.com/articles/swiftpm-add-multiple.png)

Select your package in the list, and click **Add**.

![Xcode‘s framework and library selection panel when adding a package to a target](https://cdn.alexandersandberg.com/articles/swiftpm-add-multiple-selection.png)

## <span id="update"></span>Update packages

### Single package

Under **Package Dependencies** in the Project Navigator, control-click (right-click) the package and select **Update Package**.

![Xcode‘s context menu options for a package dependency](https://cdn.alexandersandberg.com/articles/swiftpm-update-single.png)

### All packages

Control-click (right-click) **Package Dependencies** in the Project Navigator and select **Update to Latest Package Versions**.

![Xcode‘s context menu options for all package dependencies](https://cdn.alexandersandberg.com/articles/swiftpm-update-all.png)

## <span id="remove"></span>Remove packages

### Single target

Select the target you want to remove your package from in the Project Editor.

In the **General** tab, scroll down to **Frameworks and Libraries** and click the **− (minus)** below the list.

![Xcode‘s 'General' tab scrolled down to the 'Frameworks and Libraries' section with a package dependency added](https://cdn.alexandersandberg.com/articles/swiftpm-remove-single.png)

Confirm by clicking **Delete**.

![Xcode‘s alert when removing a package dependency, asking to confirm removal](https://cdn.alexandersandberg.com/articles/swiftpm-remove-single-confirm.png)

### Project (all targets)

Select your project in the Project Editor.

In the **Package Dependencies** tab, select the package you want to remove and click the **− (minus)** below the list.

![Xcode‘s 'Package Dependencies' tab for a project with a package dependency added](https://cdn.alexandersandberg.com/articles/swiftpm-remove-all.png)

Confirm by clicking **Remove**.

![Xcode‘s alert when removing a package dependency from the project, asking to confirm removal](https://cdn.alexandersandberg.com/articles/swiftpm-remove-all-confirm.png)
