# dextea-v3-proto

Dextea 服务间 RPC 的共享 protobuf 契约仓库。

## 目录

```text
proto/                 protobuf 源文件，所有语言共享
gen/go/                生成的 Go 客户端与服务端代码
```

## 生成 Go 代码

```bash
make generate
make test
```

需要安装 `protoc`、`protoc-gen-go` 和 `protoc-gen-go-grpc`。其他语言的项目应直接基于 `proto/` 生成各自客户端代码。

协议发布后，各服务通过仓库版本或 Git tag 固定依赖。对现有字段应保持向后兼容：不要修改已发布字段编号，不要复用已删除字段编号。
