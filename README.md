# RIME Configuration

这是个人的 RIME 输入法配置。

主要使用自然码双拼（`rime-double-pinyin`）。
对 RIME 的自然码进行了改动，
关闭了繁简转换、笔画查找和内置的词库，
并使用了自定义的词库。

## 文件结构

- `/`：rime 配置根目录
  - `README.md`：本文件
  - `Makefile`
  - `default.custom.yaml`：主配置
  - `double_pinyin.custom.yaml`：自然码双拼配置
  - `my_pinyin.dict.yaml`：自定义拼音词库
  - `my_pinyin_dicts/`：存放拼音词库的目录，由“`my_pinyin.dict.yaml`”引用

## 部署

以 Linux 平台的 Fcitx5 框架为例。
将此项目复制到“`~/.local/share/fcitx5/rime`”，
并执行“`make build`”。
重启 Fcitx，即可使用 RIME。

使用其它系统或框架时，
须按照 RIME 文档找到相应的用户数据目录，
并参考 Makefile 的内容编译输入方案和词库，
方可使用。

## 添加词库

若要添加拼音词库，
应将 RIME 可读格式的词库（YAML文件）复制到
“`my_pinyin_dicts/`”目录下，
并在“`my_pinyin.dict.yaml`”中导入相应词库。

## 参考

- [RIME 帮助与反馈](https://rime.im/docs/)：RIME 的文档
- [Rime description](https://github.com/LEOYoon-Tsaw/Rime_collections/blob/master/Rime_description.md)：如何编写 Schema 和 Dict 配置
- [四叶草拼音输入方案](https://github.com/fkxxyz/rime-cloverpinyin)：一些获得词库的方法和思路
- [搜狗细胞词库](https://pinyin.sogou.com/dict/)：搜狗拼音词库
