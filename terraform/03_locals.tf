locals {
  lambda_package_path = "../lambda_el_marketstack_package.zip"
  lambda_package_hash = filebase64("../lambda_el_marketstack_package.zip")
}
