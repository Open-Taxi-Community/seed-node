package main

import (
	"context"
	"fmt"

	"github.com/libp2p/go-libp2p"
	dht "github.com/libp2p/go-libp2p-kad-dht"
	"github.com/spf13/cobra"
	"log"
	"os"
)

func main() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintf(os.Stderr, "Error executing seednode command: %v\n", err)
		os.Exit(1)
	}
}

func startSeedNode() error {
	ctx := context.Background()

	host, err := libp2p.New()
	if err != nil {
		return err
	}
	defer host.Close()

	dhtInstance, err := dht.New(ctx, host)
	if err != nil {
		return err
	}

	if err := dhtInstance.Bootstrap(ctx); err != nil {
		return err
	}

	log.Println("Seed node is running...")
	<-ctx.Done()

	return nil
}

var rootCmd = &cobra.Command{
	Use:   "seed-node",
	Short: "Runs the seed node for a Cosmos blockchain network.",
	Long: `A foundational seed node implementation for Open-Taxis Cosmos blockchain networks,
			   leveraging Distributed Hash Table (DHT) technology for efficient peer discovery 
               and network bootstrap.`,
	Run: func(cmd *cobra.Command, args []string) {
		// Call the function to start your seed node here.
		fmt.Println("Initializing seed node...")
		if err := startSeedNode(); err != nil {
			fmt.Fprintf(os.Stderr, "Failed to initialize seed node: %v\n", err)
			os.Exit(1)
		}
	},
}
