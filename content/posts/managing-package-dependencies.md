---
title: "Managing package dependencies with Swift Package Manager in Xcode 📦"
subtitle: published jan 16th, 2022
slug: "managing-package-dependencies-with-swift-package-manager-in-xcode"
date: "2022-01-16T16:10:49+01:00"
lastmod: "2022-01-16T16:10:49+01:00"
draft: false
summarize: false
categories:
  - dev
---

## Table of Contents

1. [Adding a Package dependency](#adding-a-package-dependency)
2. [Adding a package dependency to multiple targets](#adding-a-package-dependency-to-multiple-targets)
3. [Updating a package dependency](#updating-a-package-dependency)
4. [Removing a package dependency](#removing-a-package-dependency)

## Adding a Package dependency

In Xcode, go to **File** → **Add Packages...** OR select your project in the **Project Editor**, go to the **Package Dependencies** tab, and press the **+ (plus)**.

Enter a Package URL (e.g. a GitHub repository URL) or a search term in the search field in the upper right.

![Window for adding package dependencies](/img/select-a-package.png)

Select the package you want to add.

Select a **Dependency Rule**. In most cases, you probably want to set this to **Up to Next Major Version**.

Click **Add Package**.

Under **Add to Target**, select the target you want to add the package to. <small>(Want to add to multiple targets? See below.)</small>

**Done!** 🚀 Yes, it's that simple.

## Adding a package dependency to multiple targets

Select the additional target you want to add your package to in the **Project Editor**.

In the **General** tab, scroll down to **Frameworks, Libraries, and Embedded Content**.

![General tab for selected target](/img/additional-target.png)

Click the **+ (plus)**, select your package in the list, and click **Add**.

![Package selection window](/img/add-package-to-another-target.png)

## Updating a package Dependency

Find your package under **Package Dependencies** in the **Project Navigator**

**Right-click** the package and select **Update Package**.

![Package dependency's right-click options in Project Navigator](/img/update-package.png)

You can also update *all package dependencies* to their latest versions by **right-clicking** **Package Dependencies** and selecting **Update to Latest Package Versions** OR by going to **File** → **Packages** → **Update to Latest Package Versions**.

## Removing a package dependency

Select your project in the **Project Editor**.

In the **Package Dependencies** tab, select the package you want to remove.

Click the **− (minus)** and then **Remove**.

![Package Dependencies tab for selected project](/img/removing-package.png)
