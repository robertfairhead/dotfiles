#! /usr/bin/env bash

HOST='spectre.fairhead.us'

# https://docs.docker.com/engine/security/https/#create-a-ca-server-and-client-keys-with-openssl

# Create root CA private key; will ask for pass
openssl genrsa -aes256 -out ca-key.pem 4096

# Create root CA certificate signed by private key; must enter pass
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem

# Create private key for server
openssl genrsa -out server-key.pem 4096

# Create a signing request for the CA for the server
openssl req -subj "/CN=$HOST" -sha256 -new -key server-key.pem -out server.csr

echo subjectAltName = DNS:$HOST,IP:127.0.0.1 > extfile.cnf

# Have CA sign the server certificate; must enter CA private key password
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out server-cert.pem -extfile extfile.cnf

# Create client key and signing request
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth > extfile.cnf

# Have CA sign the client certificate; must enter CA private key password
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out cert.pem -extfile extfile.cnf

# Clean up files
rm -f extfile.cnf client.csr server.csr ca-key.pem

cp ca.pem server-cert.pem server-key.pem /mnt/c/ProgramData/Docker/certs.d
rm -f server-cert.pem server-key.pem

mkdir ~/.docker
mv ca.pem key.pem cert.pem ~/.docker
chmod 0400 ~/.docker/key.pem
chmod 0444 ~/.docker/ca.pem ~./docker/cert.pem

# Make sure docker daemon config has the following snippet
# https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon

# {
#     "hosts": ["tcp://0.0.0.0:2376"],
#     "tlsverify": true,
#     "tlscacert": "C:\\ProgramData\\docker\\certs.d\\ca.pem",
#     "tlscert": "C:\\ProgramData\\docker\\certs.d\\server-cert.pem",
#     "tlskey": "C:\\ProgramData\\docker\\certs.d\\server-key.pem",
# }