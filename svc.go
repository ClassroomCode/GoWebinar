package main

import (
	"log"
	"net/http"

	"accelebrate.com/svc/handlers"
	"accelebrate.com/svc/models"
	"accelebrate.com/svc/repository"
)

func main() {
	repository.AddProduct(models.Product{
		Name:      "Milk",
		UnitPrice: 4.00,
	})
	repository.AddProduct(models.Product{
		Name:      "Bread",
		UnitPrice: 5.00,
	})

	http.HandleFunc("/", handlers.HandleRequest)

	err := http.ListenAndServe(":80", nil)
	if err != nil {
		log.Println(err)
		return
	}
}
