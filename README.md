# flutter-projects

Flutter Monorepo（单体仓库）。这个仓库包含多个相关项目或包

# 整理

> [一些 UI 搜集整理](./packages_ui/screenshots.md)

> [一些 APP 搜集整理](./packages_app/screenshots.md)

> [一款基于 RethinkDB 的聊天 APP](./packages_app/flutter_chat_app/README.md)

## Web

web 产物在`ts-pages`分支可查看。
[查看运行效果](https://miaopasiflutter.github.io/flutter-projects/)

## Android

![one_download](./screenshots/app_download.jpg)
[JD-Android-V0.1 下载地址](https://www.pgyer.com/1lJA)

## iOS

无苹果开发者账号, 暂时无法打包 APP, 请亲自进行编译并在模拟器或手机上运行

### Flutter 多版本管理 (使用 FVM)

```
$ fvm list  # 查看本地的flutter sdk 列表
Cache directory:  /Users/aosom/fvm/versions
Directory Size: 7.48 GB

┌─────────┬─────────┬─────────────────┬──────────────┬──────────────┬────────┬───────┐
│ Version │ Channel │ Flutter Version │ Dart Version │ Release Date │ Global │ Local │
├─────────┼─────────┼─────────────────┼──────────────┼──────────────┼────────┼───────┤
│ 3.32.4  │ stable  │ 3.32.4          │ 3.8.1        │ Jun 13, 2025 │ ●      │       │
├─────────┼─────────┼─────────────────┼──────────────┼──────────────┼────────┼───────┤
│ 3.19.4  │ stable  │ 3.19.4          │ 3.3.2        │ Mar 21, 2024 │        │       │
└─────────┴─────────┴─────────────────┴──────────────┴──────────────┴────────┴───────┘

$ fvm use 3.32.4 # 设置 flutter 版本为 3.32.4
You should add the fvm version directory ".fvm/" to .gitignore.
✔ Would you like to do that now? · yes
✓ Added .fvm/ to .gitignore

✓ Dependencies resolved. (2.9s)
✓ Project now uses Flutter SDK : SDK Version : 3.32.4
┌────────────────────────────────────────────────────────────────────┐
│ ✓ Running on VsCode, please restart the terminal to apply changes. │
└────────────────────────────────────────────────────────────────────┘
You can then use "flutter" command within the VsCode terminal.

```

### 使用脚本生成 package
创建 ocean_utils 模块儿
sh hzy_rob_project.sh -n ocean_utils -l pro -t package


### 使用 Melos 管理多项目

```
$ fvm dart pub global activate melos # 全局安装 Melos
Package melos is currently active at version 6.3.3.
Downloading packages... . (40.8s)
The package melos is already activated at newest available version.
To recompile executables, first run `dart pub global deactivate melos`.
Installed executable melos.
Warning: Pub installs executables into $HOME/.pub-cache/bin, which is not on your path.
You can fix that by adding this to your shell's config file (.zshrc, .bashrc, .bash_profile, etc.):

  export PATH="$PATH":"$HOME/.pub-cache/bin"

Activated melos 6.3.3.

$ fvm dart pub add melos --dev # 将 Melos 添加为开发依赖项

$ fvm dart pub global run melos bootstrap # 安装依赖包
melos bootstrap
  └> /Users/aosom/Documents/yhui/github/ZYHB/flutter-projects

Running "flutter pub get" in workspace...
[flutter_projects]: Resolving dependencies...
[flutter_projects]: Downloading packages...
[flutter_projects]:   characters 1.4.0 (1.4.1 available)
[flutter_projects]:   flutter_lints 5.0.0 (6.0.0 available)
[flutter_projects]:   leak_tracker 10.0.9 (11.0.1 available)
[flutter_projects]:   leak_tracker_flutter_testing 3.0.9 (3.0.10 available)
[flutter_projects]:   leak_tracker_testing 3.0.1 (3.0.2 available)
[flutter_projects]:   lints 5.1.1 (6.0.0 available)
[flutter_projects]:   material_color_utilities 0.11.1 (0.13.0 available)
[flutter_projects]:   meta 1.16.0 (1.17.0 available)
[flutter_projects]:   test_api 0.7.4 (0.7.6 available)
[flutter_projects]:   vector_math 2.1.4 (2.2.0 available)
[flutter_projects]:   vm_service 15.0.0 (15.0.2 available)
[flutter_projects]: Got dependencies!
[flutter_projects]: 11 packages have newer versions incompatible with dependency constraints.
[flutter_projects]: Try `flutter pub outdated` for more information.
  > SUCCESS

Generating IntelliJ IDE files...
  > SUCCESS

 -> 8 packages bootstrapped

$ fvm dart pub global run melos hello # 运行定义的 script
Resolving dependencies in `/Users/aosom/Documents/yhui/github/ZYHB/flutter-projects`... (8.4s)
Downloading packages...
Got dependencies in `/Users/aosom/Documents/yhui/github/ZYHB/flutter-projects`.
Building package executable...
Built melos:melos.
melos run hello
  └> echo '$GREETING World'
     └> RUNNING

$GREETING World

```

### melos aliases

每次都要加上前缀 `fvm dart pub global run melos xxx` 才能执行命令比较繁琐，可以给 melos 创建一个 aliases

```
在 .zshrc 文件加上：
alias melos="fvm dart pub global run melos"

```

### package 介绍

```
# 创建 package
$ fvm flutter  create --template=package athena_network
```

### 推荐脚本的写法以及常用脚本分享

#### hello

一个简单脚本，执行后输出：

```
$ fvm dart pub global run melos hello # 运行定义的 script
Resolving dependencies in `/Users/aosom/Documents/yhui/github/ZYHB/flutter-projects`... (8.4s)
Downloading packages...
Got dependencies in `/Users/aosom/Documents/yhui/github/ZYHB/flutter-projects`.
Building package executable...
Built melos:melos.
melos run hello
  └> echo '$GREETING World'
     └> RUNNING

$GREETING World
```

#### test:selective_unit_test
