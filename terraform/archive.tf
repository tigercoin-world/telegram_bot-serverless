data "archive_file" "sales_api_file" {
  type             = "zip"
  source_dir       = "${path.module}/src"
  output_path      = "${path.module}/src/src.zip"
}
