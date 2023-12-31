# RIME Configuration

这是个人的 RIME 输入法配置。

## 文件结构

- `/`：rime 配置根目录
  - `README.md`：本文件
  - `Makefile`
  - `default.custom.yaml`：默认配置自定义
  - `happy.*`：Happy 双拼输入方案

## 部署

以 Linux 平台的 Fcitx5 框架为例。
将此项目复制到“`~/.local/share/fcitx5/rime`”，
并执行“`make build`”。
重启 Fcitx，即可使用 RIME。

使用其它系统或框架时，
须按照 RIME 文档找到相应的用户数据目录，
并参考 Makefile 的内容编译输入方案和词库，
方可使用。

## Happy 方案

Happy，即 HardGraphite's Double Pinyin Schema，
是一个自定义的双拼输入方案。
它借鉴了 RIME 的自然码方案（rime-double-pinyin）的规则，
并使用了其它的词库。
除此之外，它还支持辅助码。
在双拼后添加“/”，后跟辅助码序列。
辅助码与前面“/”的字一一对应，每个字只能有一位辅助码。
辅助码使用自然码的辅助码方案，但只取第一位。

列如，要输入“你好”，可键入“nihk/rn”（Ni Hao 亻女）。
“/rn”这部分也可以省略。

若要添加拼音词库，
应将 RIME 可读格式的词库（YAML文件）复制到
“`happy.dicts/`”目录下，
并在“`happy.dict.yaml`”中导入相应词库。
若要修改辅助码规则，
则应该改动“`happy.bushou.dict.yaml`”。

## 参考

- [RIME 帮助与反馈](https://rime.im/docs/)：RIME 的文档
- [Rime description](https://github.com/LEOYoon-Tsaw/Rime_collections/blob/master/Rime_description.md)：如何编写 Schema 和 Dict 配置
- [librime-lua wiki/Scripting](https://github.com/hchunhui/librime-lua/wiki/Scripting)：RIME 中 Lua 提供的接口
- [四叶草拼音输入方案](https://github.com/fkxxyz/rime-cloverpinyin)：一些获得词库的方法和思路
- [搜狗细胞词库](https://pinyin.sogou.com/dict/)：搜狗拼音词库
- [GitHub: copperay/ZRM_Aux-code](https://github.com/copperay/ZRM_Aux-code)：自然码辅助码
