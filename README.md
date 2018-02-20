# x-compile-golang

this Docker image contains oracle instant client 12.1 golang 1.9.2

| Software                    | Version       |
|-----------------------|----------|
| system                    | CentOS-7 |
| Go                    | 1.9.2    |
| Oracle Instant Client | 12.1     |

## you can cross compile golang by following command

```bash
    docker run --rm -v "$PWD":/go/src/example.com/service -w /go/src/example.com/service ravenzz/x-compile:0.1 go build -o service1
```