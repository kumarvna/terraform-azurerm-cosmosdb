variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = false
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
  description = "Consistency levels in Azure Cosmos DB"
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
  description = "Cross-Origin Resource Sharing (CORS) is an HTTP feature that enables a web application running under one domain to access resources in another domain."
  default     = null
}

variable "managed_identity" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Cosmos Account. Possible value is only SystemAssigned. Defaults to false."
  default     = false
}

variable "enable_private_endpoint" {
  description = "Manages a Private Endpoint to Azure cosmosdb account"
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

variable "create_cosmosdb_table" {
  description = "Manages a Table within a Cosmos DB Account"
  default     = false
}

variable "cosmosdb_table_name" {
  description = "Specifies the name of the Cosmos DB Table"
  default     = null
}

variable "cosmosdb_table_throughput" {
  description = "The throughput of Table (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = null
}

variable "cosmosdb_table_autoscale_settings" {
  type = object({
    max_throughput = string
  })
  description = "The maximum throughput of the Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = null
}

variable "create_cosmosdb_sql_database" {
  description = "Manages a SQL Database within a Cosmos DB Account"
  default     = false
}

variable "cosmosdb_sql_database_name" {
  description = "Specifies the name of the Cosmos DB SQL database"
  default     = null
}

variable "cosmosdb_sqldb_throughput" {
  description = "The throughput of Table (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = 400
}

variable "cosmosdb_sqldb_autoscale_settings" {
  type = object({
    max_throughput = string
  })
  description = "The maximum throughput of the Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = null
}

variable "create_cosmosdb_sql_container" {
  description = "Manages a SQL Container within a Cosmos DB Account"
  default     = false
}

variable "cosmosdb_sql_container_name" {
  description = "Specifies the name of the Cosmos DB sql container"
  default     = null
}

variable "partition_key_path" {
  description = "Define a partition key"
  default     = "/definition/id"
}

variable "partition_key_version" {
  description = "Define a partition key version. Possible values are `1` and `2`. This should be set to `2` in order to use large partition keys."
  default     = 1
}

variable "sql_container_throughput" {
  description = "The throughput of SQL container (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon container creation otherwise it cannot be updated without a manual terraform destroy-apply"
  default     = null
}

variable "sql_container_autoscale_settings" {
  type = object({
    max_throughput = string
  })
  description = "The maximum throughput of the Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = null
}

variable "unique_key" {
  type = object({
    paths = list(string)
  })
  description = "A list of paths to use for this unique key"
  default     = null
}

variable "indexing_policy" {
  type = object({
    indexing_mode = optional(string)
    included_path = optional(object({
      path = string
    }))
    excluded_path = optional(object({
      path = string
    }))
    composite_index = optional(object({
      index = optional(object({
        path  = string
        order = string
      }))
    }))
    spatial_index = optional(object({
      path = string
    }))
  })
  description = "Specifies how the container's items should be indexed. The default indexing policy for newly created containers indexes every property of every item and enforces range indexes for any string or number"
  default     = null
}

variable "conflict_resolution_policy" {
  type = object({
    mode                          = string
    conflict_resolution_path      = string
    conflict_resolution_procedure = string
  })
  description = "Conflicts and conflict resolution policies are applicable if your Azure Cosmos DB account is configured with multiple write regions"
  default     = null
}

variable "default_ttl" {
  description = "The default time to live of SQL container. If missing, items are not expired automatically. If present and the value is set to `-1`, it is equal to infinity, and items don’t expire by default. If present and the value is set to some number `n` – items will expire `n` seconds after their last modified time."
  default     = null
}

variable "analytical_storage_ttl" {
  description = "The default time to live of Analytical Storage for this SQL container. If present and the value is set to `-1`, it is equal to infinity, and items don’t expire by default. If present and the value is set to some number `n` – items will expire `n2` seconds after their last modified time."
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
