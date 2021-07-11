module "cosmosdb" {
  // source  = "kumarvna/cosmosdb/azurerm"
  //version = "1.0.0"
  source = "../../"

  # By default, this module will create a resource group
  # proivde a name to use an existing resource group and set the argument 
  # to `create_resource_group = false` if you want to existing resoruce group. 
  # If you use existing resrouce group location will be the same as existing RG.
  create_resource_group = false
  resource_group_name   = "rg-shared-westeurope-01"
  location              = "westeurope"

  cosmosdb_account = {
    demo-cosmosdb-account = {
      offer_type = "Standard"
      kind       = "GlobalDocumentDB"
    }
  }

  consistency_policy = {
    consistency_level = "BoundedStaleness"
  }

  # gio-failover 
  failover_locations = {
    failover-to-ne = {
      location          = "northeurope"
      failover_priority = 0
      zone_redundant    = true
    }
  }

  #capabilities
  capabilities = [
    "AllowSelfServeUpgradeToMongo36",
    "DisableRateLimitingResponses",
    "EnableAggregationPipeline",
    "EnableCassandra",
    "EnableGremlin",
    "EnableMongo",
    "EnableTable",
    "EnableServerless",
    "MongoDBv3.4",
    "mongoEnableDocLevelTTL"
  ]

  # backup
  backup = {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
  }

  managed_identity = true

  # CosmosDB Firewall Support: Specifies the set of IP addresses / ranges to be included as an allowed list 
  # IP addresses/ranges must be comma separated and must not contain any spaces.
  #  allowed_ip_range_cidrs = ["1.2.3.4", "2.3.4.5"]

  # Tags for Azure Resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
