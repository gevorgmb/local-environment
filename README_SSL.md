# Generate SSL Certificate

## 1. Create a Configuration File certificate_info.cnf

File must be created in directory [project_root]/docker/etc/ssl_sources based on file certificate_info.cnf.dist
Set your data under req_distinguished_name and alt_names

## 2. Create a parameter file params.sh

To make certificate files with unique names create params.sh file based on params.sh.dist
Set vales for parameters.

## 3. Generate the Certificate

command: bash ssl_certificate_generator.sh

It will create certificate files in [project_root]/docker/etc/ssl folder

## 4. Use the Certificate

* Apache: Update SSLCertificateFile and SSLCertificateKeyFile in the VirtualHost config.
* NGINX: Use ssl_certificate [prefix]_cert.pem; and ssl_certificate_key [prefix]_key.pem; in the server block.

## 5. Add generated SSL Certificate to the "Trusted List"

### OS: Windows
#### 1. Open Certificate Manager
* Press `Win + R`, type `mmc`, and hit **Enter**.
* Go to **File** → **Add/Remove Snap-in**.
* Select **Certificates** → Click **Add** → Choose **Computer account** → Click **Next** → **Finish** → **OK**.
#### 2. Import the Certificate
* Expand **Trusted Root Certification Authorities** → **Certificates**.
* Right-click **Certificates** → **All Tasks** → **Import**.
* Browse and select your **[prefix]_cert.pem** file.
* Click **Next** and **Finish**.
#### 3. Restart Your Browser
Close and reopen your browser for changes to take effect.

### OS: macOS
#### 1. Open Keychain Access
* Press `Cmd + Space`, type `Keychain Access`, and open it.
#### 2. Import the Certificate
* Drag and drop your **[prefix]_cert.pem** into **System** or **Login** keychain.
#### 3. Mark as Trusted
* Double-click the certificate.
* Expand Trust and set **"When using this certificate"** to **Always Trust**.
#### 4. Restart Your Browser
Close and reopen your browser to apply changes.

### OS: Linux (Ubuntu/Debian)
#### 1. Copy Certificate to Trusted Store
command: sudo cp [prefix]_cert.pem /usr/local/share/ca-certificates/[prefix]_cert.crt
#### 2. Update the Trusted Certificates
command: sudo update-ca-certificates

## 6. Google Chrome / Firefox (Manual Trust)
* Open **Settings** → **Privacy & Security** → **Certificates**.
* Import [prefix]_cert.pem and mark it as trusted.
