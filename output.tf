output "cosmosdb_id" {
  description = "The CosmosDB Account resource ID."
  value       = element(concat([for n in azurerm_cosmosdb_account.main : n.id], [""]), 0)
}

output "cosmosdb_endpoint" {
  description = "The endpoint used to connect to the CosmosDB account."
  value       = element(concat([for n in azurerm_cosmosdb_account.main : n.endpoint], [""]), 0)
}

output "cosmosdb_read_endpoints" {
  description = "A list of read endpoints available for this CosmosDB account"
  value       = [for n in azurerm_cosmosdb_account.main : n.read_endpoints]
}

output "cosmosdb_write_endpoints" {
  description = "A list of write endpoints available for this CosmosDB account."
  value       = [for n in azurerm_cosmosdb_account.main : n.write_endpoints]
}

output "cosmosdb_primary_key" {
  description = "The Primary master key for the CosmosDB Account"
  value       = element(concat([for n in azurerm_cosmosdb_account.main : n.primary_key], [""]), 0)
  sensitive   = true
}

output "cosmosdb_secondary_key" {
  description = "The Secondary master key for the CosmosDB Account."
  value       = element(concat([for n in azurerm_cosmosdb_account.main : n.secondary_key], [""]), 0)
  sensitive   = true
}

output "cosmosdb_primary_readonly_key" {
  description = "The Primary read-only master Key for the CosmosDB Account"
  value       = element(concat([for n in azurerm_cosmosdb_account.main : n.primary_readonly_key], [""]), 0)
  sensitive   = true
}

output "cosmosdb_secondary_readonly_key" {
  description = "The Secondary read-only master key for the CosmosDB Account"
  value       = element(concat([for n in azurerm_cosmosdb_account.main : n.secondary_readonly_key], [""]), 0)
  sensitive   = true
}

output "cosmosdb_connection_strings" {
  description = "A list of connection strings available for this CosmosDB account"
  value       = [for n in azurerm_cosmosdb_account.main : n.connection_strings]
  sensitive   = true
}

output "cosmosdb_private_endpoint" {
  description = "id of the Redis Cache server Private Endpoint"
  value       = var.enable_private_endpoint ? element(concat(azurerm_private_endpoint.pep1.*.id, [""]), 0) : null
}

output "cosmosdb_private_dns_zone_domain" {
  description = "DNS zone name of Redis Cache server Private endpoints dns name records"
  value       = var.existing_private_dns_zone == null && var.enable_private_endpoint ? element(concat(azurerm_private_dns_zone.dnszone1.*.name, [""]), 0) : var.existing_private_dns_zone
}

output "cosmosdb_private_endpoint_ip" {
  description = "Redis Cache server private endpoint IPv4 Addresses"
  value       = var.enable_private_endpoint ? element(concat(data.azurerm_private_endpoint_connection.private-ip1.*.private_service_connection.0.private_ip_address, [""]), 0) : null
}

output "cosmosdb_private_endpoint_fqdn" {
  description = "Redis Cache server private endpoint FQDN Addresses"
  value       = var.enable_private_endpoint ? element(concat(azurerm_private_dns_a_record.arecord1.*.fqdn, [""]), 0) : null
}

output "cosmosdb_table_id" {
  description = "The resource ID of the CosmosDB Table"
  value = var.create_cosmosdb_table ? azurerm_cosmosdb_table.main.0.id : null
}

output "cosmosdb_sql_database_id" {
  description = "The resource ID of the CosmosDB SQL Database."
  value = var.create_cosmosdb_sql_database ? azurerm_cosmosdb_sql_database.main.0.id : null
}