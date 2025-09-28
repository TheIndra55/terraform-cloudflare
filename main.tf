terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

variable "zones" {
  default = ["theindra.nl", "theindra.eu", "theindra.dev", "tombraidermodding.com", "cdcengine.re", "tombraid.ing"]
}

data "cloudflare_zone" "zones" {
  for_each = toset(var.zones)
  name     = each.value
}