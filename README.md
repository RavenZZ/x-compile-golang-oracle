# x-compile-golang

this Docker image contains oracle instant client 12.1 golang 1.9.2

| Software              | Version  |
|-----------------------|----------|
| system                | CentOS-7 |

```bash
   ./build-image.sh 1.9.7 88573008f4f6233b81f81d8ccf92234b4f67238df0f0ab173d75a302a1f3d6ee
   ./build-image.sh 1.10.8 d8626fb6f9a3ab397d88c483b576be41fa81eefcec2fd18562c87626dbb3c39e
   ./build-image.sh 1.11.13 50fe8e13592f8cf22304b9c4adfc11849a2c3d281b1d7e09c924ae24874c6daa
   ./build-image.sh 1.12.9 ac2a6efcc1f5ec8bdc0db0a988bb1d301d64b6d61b7e8d9e42f662fbb75a2b9b
```

## cross compile golang by following command

```bash
    docker run --rm -v "$PWD":/go/src/example.com/service -w /go/src/example.com/service ravenzz/x-compile:0.1 go build -o service1
```