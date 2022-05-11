package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
)

var (
	port string
)

func init() {
	flag.StringVar(&port, "port", "7080", "server port")
}

func main() {
	flag.Parse()

	router := http.NewServeMux()
	router.HandleFunc("/", whoamiHandler)
	server := &http.Server{
		Addr:    ":" + port,
		Handler: router,
	}
	log.Println("server start on port:", port)
	log.Fatal(server.ListenAndServe())
}

func whoamiHandler(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintln(w, "Your Addr:", strings.Split(r.RemoteAddr, ":")[0])
	fmt.Fprintln(w, "I am", hostname)
}
