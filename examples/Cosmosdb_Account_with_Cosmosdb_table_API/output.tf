output "cosmosdb_id" {
  description = "The CosmosDB Account resource ID."
  value       = module.cosmosdb.cosmosdb_id
}

output "cosmosdb_endpoint" {
  description = "The endpoint used to connect to the CosmosDB account."
  value       = module.cosmosdb.cosmosdb_endpoint
}

output "cosmosdb_read_endpoints" {
  description = "A list of read endpoints available for this CosmosDB account"
  value       = module.cosmosdb.cosmosdb_read_endpoints
}

output "cosmosdb_write_endpoints" {
  description = "A list of write endpoints available for this CosmosDB account."
  value       = module.cosmosdb.cosmosdb_write_endpoints
}

output "cosmosdb_primary_key" {
  description = "The Primary master key for the CosmosDB Account"
  value       = module.cosmosdb.cosmosdb_primary_key
  sensitive   = true
}

output "cosmosdb_secondary_key" {
  description = "The Secondary master key for the CosmosDB Account."
  value       = module.cosmosdb.cosmosdb_secondary_key
  sensitive   = true
}

output "cosmosdb_primary_readonly_key" {
  description = "The Primary read-only master Key for the CosmosDB Account"
  value       = module.cosmosdb.cosmosdb_primary_readonly_key
  sensitive   = true
}

output "cosmosdb_secondary_readonly_key" {
  description = "The Secondary read-only master key for the CosmosDB Account"
  value       = module.cosmosdb.cosmosdb_secondary_readonly_key
  sensitive   = true
}

output "cosmosdb_connection_strings" {
  description = "A list of connection strings available for this CosmosDB account"
  value       = module.cosmosdb.cosmosdb_connection_strings
  sensitive   = true
}

output "cosmosdb_private_endpoint" {
  description = "id of the CosmosDB Account Private Endpoint"
  value       = module.cosmosdb.cosmosdb_private_endpoint
}

output "cosmosdb_private_dns_zone_domain" {
  description = "DNS zone name of CosmosDB Account Private endpoints dns name records"
  value       = module.cosmosdb.cosmosdb_private_dns_zone_domain
}

output "cosmosdb_private_endpoint_ip" {
  description = "CosmosDB Account private endpoint IPv4 Addresses"
  value       = module.cosmosdb.cosmosdb_private_endpoint_ip
}

output "cosmosdb_private_endpoint_fqdn" {
  description = "CosmosDB Account private endpoint FQDN Addresses"
  value       = module.cosmosdb.cosmosdb_private_endpoint_fqdn
}
