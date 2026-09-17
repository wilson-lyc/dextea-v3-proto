.PHONY: generate test

generate:
	protoc -I proto \
		--go_out=gen/go --go_opt=paths=source_relative \
		--go-grpc_out=gen/go --go-grpc_opt=paths=source_relative \
		proto/product/v1/product.proto

test:
	go test ./...
