default: build

clean:
	rm -f visitTrack

prepare:
	go get -u gopkg.in/yaml.v2
	go get -u github.com/gin-gonic/gin
	go get -u github.com/jinzhu/gorm

build:
	go build
