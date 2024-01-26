BINARY_NAME=go-fast-cdn

prep:
	go mod tidy
	go mod download
	cd frontend && pnpm i

build: build_ui build_bin

build_ui:
	pnpm --dir ./frontend build

build_bin:
	GOARCH=amd64 GOOS=darwin CGO_ENABLED=0 go build ./backend/cmd/ -o bin/${BINARY_NAME}-darwin 
	CC="x86_64-linux-musl-gcc" GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build ./backend/cmd/ -o bin/${BINARY_NAME}-linux
	CC="x86_64-w64-mingw32-gcc" GOARCH=amd64 GOOS=windows CGO_ENABLED=0 go build ./backend/cmd/ -o bin/${BINARY_NAME}-windows

run: build
	bin/${BINARY_NAME}-linux

clean: 
	go clean
	rm -rf bin/*
	rm -rf ui/build/*

vet:
	go vet

test:
	go test ./...
