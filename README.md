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

## Product 与 Store 服务边界

`proto/product/v1/product.proto` 当前按调用面拆分为两个 gRPC service：

- `ProductAdminService`：商品、客制化、菜单、标签、原料、图片和菜单派发等管理能力；
- `ProductBusinessService`：商品详情、门店状态和业务菜单等顾客/订单读取能力。

Product 服务端内部仍可共享领域 service，但调用方应分别生成并使用
`ProductAdminServiceClient` 或 `ProductBusinessServiceClient`。其中两个 service
都提供 `GetMenuTree`，服务端会分别固定为管理视图和业务视图；调用方不应依赖请求中的
`mode` 来跨越服务边界。

`proto/store/v1/store.proto` 同样拆分为 `StoreAdminService`、
`StoreBusinessService` 和 `StoreCredentialService`。管理字段、顾客可见门店读取、
以及账号认证/改密分别从对应 client 导入，避免把凭据或管理字段带入业务读取接口。

这是 service 名称和部分 message 类型的契约变更。其他模块接入时应以本仓库的
`proto/` 重新生成客户端，不要继续引用旧的 `ProductService` 或 `StoreService`。

## XOS 图片服务

`proto/xos/v1/xos.proto` 定义上传、图库分页、删除、存在性校验和批量 URL 查询。生成的 Go 包为 `gen/go/xos/v1`。上传使用 bytes 字段传递原始图片内容，调用方需匹配服务配置的消息大小限制。
