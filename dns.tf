resource "cloudflare_record" "spf" {
  for_each = data.cloudflare_zone.zones
  zone_id  = each.value.id

  name    = "@"
  type    = "TXT"
  content = "\"v=spf1 -all\""
}

resource "cloudflare_record" "dmarc" {
  for_each = data.cloudflare_zone.zones
  zone_id  = each.value.id

  name    = "_dmarc"
  type    = "TXT"
  content = "\"v=DMARC1; p=reject; rua=mailto:admin@yocto.eu; ruf=mailto:admin@yocto.eu\""
}