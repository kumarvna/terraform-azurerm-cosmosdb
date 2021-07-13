variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = true
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "cosmosdb_account" {
  type = map(object({
    offer_type                            = string
    kind                                  = optional(string)
    enable_free_tier                      = optional(bool)
    analytical_storage_enabled            = optional(bool)
    enable_automatic_failover             = optional(bool)
    public_network_access_enabled         = optional(bool)
    is_virtual_network_filter_enabled     = optional(bool)
    key_vault_key_id                      = optional(string)
    enable_multiple_write_locations       = optional(bool)
    access_key_metadata_writes_enabled    = optional(bool)
    mongo_server_version                  = optional(string)
    network_acl_bypass_for_azure_services = optional(bool)
    network_acl_bypass_ids                = optional(list(string))
  }))
  description = "Manages a CosmosDB (formally DocumentDB) Account specifications"
}

variable "allowed_ip_range_cidrs" {
  type        = list(string)
  description = "CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. IP addresses/ranges must be comma separated and must not contain any spaces."
  default     = []
}

variable "consistency_policy" {
  type = object({
    consistency_level       = string
    max_interval_in_seconds = optional(number)
    max_staleness_prefix    = optional(number)
  })
}

variable "failover_locations" {
  #  type        = map(map(string))
  type = list(object({
    location          = string
    failover_priority = number
    zone_redundant    = optional(bool)
  }))
  description = "The name of the Azure region to host replicated data and their priority."
  default     = null
}

variable "capabilities" {
  type        = list(string)
  description = "Configures the capabilities to enable for this Cosmos DB account. Possible values are `AllowSelfServeUpgradeToMongo36`, `DisableRateLimitingResponses`, `EnableAggregationPipeline`, `EnableCassandra`, `EnableGremlin`, `EnableMongo`, `EnableTable`, `EnableServerless`, `MongoDBv3.4` and `mongoEnableDocLevelTTL`."
  default     = []
}

variable "virtual_network_rules" {
  description = "Configures the virtual network subnets allowed to access this Cosmos DB account"
  type = list(object({
    id                                   = string
    ignore_missing_vnet_service_endpoint = optional(bool)
  }))
  default = null
}

variable "backup" {
  type        = map(string)
  description = "Specifies the backup setting for different types, intervals and retention time in hours that each backup is retained."
  default = {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
  }
}

variable "cors_rules" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  description = "value"
  default     = null
}

variable "managed_identity" {
  description = "If you want your SQL Server to have an managed identity. Defaults to false."
  default     = false
}

variable "enable_private_endpoint" {
  description = "Manages a Private Endpoint to Azure database for Redis"
  default     = false
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = ""
}

variable "existing_private_dns_zone" {
  description = "Name of the existing private DNS zone"
  default     = null
}

variable "private_subnet_address_prefix" {
  description = "The name of the subnet for private endpoints"
  default     = null
}

variable "enable_advanced_threat_protection" {
  description = "Threat detection policy configuration, known in the API as Server Security Alerts Policy. Currently available only for the SQL API."
  default     = false
}

variable "log_analytics_workspace_name" {
  description = "The name of log analytics workspace name"
  default     = null
}

variable "extaudit_diag_logs" {
  description = "CosmosDB Monitoring Category details for Azure Diagnostic setting"
  default     = ["DataPlaneRequests", "MongoRequests", "QueryRuntimeStatistics", "PartitionKeyStatistics", "PartitionKeyRUConsumption", "ControlPlaneRequests", "CassandraRequests", "GremlinRequests", "TableApiRequests"]
}

variable "storage_account_name" {
  description = "The name of the storage account name"
  default     = null
}

variable "cosmosdb_table" {
  type = map(object({
    throughput = optional(number)
    autoscale_settings = optional(object({
      max_throughput = number
    }))
  }))
  description = "Manages a Table within a Cosmos DB Account"
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
