.PHONY: generate test

generate:
	protoc -I proto \
		--go_out=gen/go --go_opt=paths=source_relative \
		--go-grpc_out=gen/go --go-grpc_opt=paths=source_relative \
		proto/product/v1/product.proto proto/store/v1/store.proto proto/order/v1/order.proto proto/xos/v1/xos.proto

test:
	go test ./...
