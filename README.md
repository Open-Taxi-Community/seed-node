# Seed Node for Open Taxi Community

The Seed Node project is part of the Open Taxi Community's initiative to create a decentralized network for ride-sharing services. This repository contains the source code and deployment scripts for setting up a seed node using `libp2p` and a Distributed Hash Table (DHT) for efficient peer discovery within the Cosmos blockchain network.

## Overview

The seed node acts as an initial point of contact for new nodes joining the network, assisting in peer discovery and network synchronization. It is built with Go and leverages the `libp2p` framework to create a robust, scalable, and secure P2P network.

## Installation

### Prerequisites

- A Unix-like VPS operating system
- `sudo` privileges for the installation process
- Internet connection for downloading Go and dependencies

### Automated Installation

1. Clone the repository and install:

```
   git clone https://github.com/Open-Taxi-Community/seed-node.git
   cd seed-node
   sudo ./install.sh
```

This script will:
- Install the Go programming language.
- Compile the `seed-node` binary.
- Create a `seed-node` user and group for secure operation.
- Set up a `systemd` service for the seed node.
- (Optionally) Reboot the system to apply all changes.

**Note:** The script prompts for a reboot at the end to ensure that all changes take effect. Please save all work before proceeding with the installation.

## Configuration

The seed node configuration can be adjusted by editing the `seed-node.service` file located in `packaging/systemd/`. For custom configurations, refer to the [libp2p documentation](https://docs.libp2p.io/) and [Go's official documentation](https://golang.org/doc/).

## Usage

After installation, the seed node will start automatically on system boot. You can manually control the seed node service using `systemd`:

- Start the service: `sudo systemctl start seed-node.service`
- Stop the service: `sudo systemctl stop seed-node.service`
- Restart the service: `sudo systemctl restart seed-node.service`
- Check service status: `sudo systemctl status seed-node.service`

## Contributing

We welcome contributions to the Open Taxi Community Seed Node project! Please feel free to submit pull requests, report issues, or suggest improvements.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- The Go Team for the Go programming language.
- The `libp2p` project for the P2P networking library.
