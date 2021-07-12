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
