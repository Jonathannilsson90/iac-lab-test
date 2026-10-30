provider "local" {}

# ${path.module} = filesystem path to the directory of the current module
resource "local_file" "config" {
  filename = "${path.module}/config.json"
  content = jsonencode({
    project     = "Test deployment without docker"
    environment = "locally"
    created_by  = "Terraform"
    version     = formatdate("YYYY.MM.DD", timestamp())
  })
}


# Bootstrapping a src/www folder with a index.html file
resource "local_file" "src_bootstrap" {
  filename = "${path.module}/src/www/index.html"
  content  = "<h1>test!</h1>"
}


# Provisioner is what allows terraform to exec commands instead of creating
resource "terraform_data" "cleanup" {
  provisioner "local-exec" {
    when = destroy
    command = "rm -rf ${path.module}/src"
  }
}


# Bootstrapping .env file to src/www
resource "local_file" "env_bootstrap" {
  filename = "${path.module}/src/www/.env"
  content  = "API_KEY=${var.API_KEY}"
}




# Förslag på projekt:
# 1. Webserver
# 2. Mappar för NAS
# 3. Backup för filer
# 4. Lägga till användare på en maskin
# 5. Skapa en password gen som sparar hashar



# HOST => LOCALLY