#!/bin/bash
. ./etc/ssl_sources/params.sh
# Generate the SSL Certificate
# Step 1: Generate the Private Key
openssl genrsa -out etc/ssl/"$key_prefix"_key.pem 4096
# Step 2: Create the Certificate Signing Request (CSR)
openssl req -new -key etc/ssl/"$key_prefix"_key.pem -out etc/ssl/"$key_prefix"_cert.csr -config etc/ssl_sources/certificate_info.cnf
# Step 3: Generate the Self-Signed Certificate
openssl x509 -req -days 365 -in etc/ssl/"$key_prefix"_cert.csr -signkey etc/ssl/"$key_prefix"_key.pem -out etc/ssl/"$key_prefix"_cert.pem -extensions v3_ca -extfile etc/ssl_sources/certificate_info.cnf
# Verify the Certificate
openssl x509 -in etc/ssl/"$key_prefix"_cert.pem -text -noout | grep -A 1 "Subject Alternative Name"