resource "cloudflare_ruleset" "redirect_rules" {
  for_each = data.cloudflare_zone.zones
  zone_id  = each.value.id

  name  = "redirects"
  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules {
    description = "redirect www"

    expression = "(http.request.full_uri wildcard r\"https://www.*\")"
    action     = "redirect"

    action_parameters {
      from_value {
        status_code           = 301
        preserve_query_string = false
        target_url {
          expression = "wildcard_replace(http.request.full_uri, r\"https://www.*\", r\"https://$${1}\")"
        }
      }
    }
  }
}