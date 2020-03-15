package app

import (
	"fmt"
	"log"
	"os"
)

const logsPath = "/app/logs/api-gateway/"

func AccessLog(msg string) {
	filename := logsPath + "access.log"
	writeLog(filename, msg)
}

func ErrorLog(msg string) {
	filename := logsPath + "error.log"
	writeLog(filename, msg)
}

func writeLog(filename, msg string) {
	file, err := os.OpenFile(filename, os.O_RDWR | os.O_CREATE | os.O_APPEND, 0666)
	if err != nil {
		fmt.Printf("[ERR] error opening file: %v\n", err)
	}
	defer file.Close()

	log.SetOutput(file)
	log.Println(msg)
}
