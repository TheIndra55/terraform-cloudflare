resource "cloudflare_zone_settings_override" "settings" {
  for_each = data.cloudflare_zone.zones
  zone_id  = each.value.id

  settings {
    always_use_https  = "on"
    min_tls_version   = "1.2"
    tls_1_3           = "on"
    browser_cache_ttl = 31536000
    always_online     = "on"

    security_header {
      enabled            = true
      preload            = true
      include_subdomains = true
      max_age            = 31536000
      nosniff            = true
    }
  }
}

resource "cloudflare_authenticated_origin_pulls" "origin_pulls" {
  for_each = data.cloudflare_zone.zones
  zone_id  = each.value.id

  enabled = true
}