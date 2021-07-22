module "cosmosdb" {
  source  = "kumarvna/cosmosdb/azurerm"
  version = "1.0.0"

  # By default, this module will create a resource group
  # proivde a name to use an existing resource group and set the argument 
  # to `create_resource_group = false` if you want to existing resoruce group. 
  # If you use existing resrouce group location will be the same as existing RG.
  create_resource_group = false
  resource_group_name   = "rg-shared-westeurope-01"
  location              = "westeurope"

  # Cosmosdb account details.
  # Currently Offer Type supports only be set to `Standard`
  # Specifies the Kind of CosmosDB to create - possible values are `GlobalDocumentDB` and `MongoDB`
  cosmosdb_account = {
    demo-cosmosdb = {
      offer_type = "Standard"
      kind       = "GlobalDocumentDB"
    }
  }

  # `max_staleness_prefix` must be greater then `100000` when more then one geo_location is used
  # `max_interval_in_seconds` must be greater then 300 (5min) when more then one geo_location is used
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_staleness_prefix    = 100000
    max_interval_in_seconds = 300
  }

  # Configures the geographic locations the data is replicated
  # Location prefix (key) must be 3 - 50 characters long, contain only lowercase letters, numbers and hyphens 
  failover_locations = [
    {
      location          = "westeurope"
      failover_priority = 0
      zone_redundant    = true
    },
    {
      location          = "norwayeast"
      failover_priority = 1
      zone_redundant    = true
    }
  ]

  # Azure Cosmos DB automatically takes a full backup of your database every 4 hours
  # Change the default backup interval and the retention period below 
  backup = {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
  }

  # Advanced Threat Protection for Azure Cosmos DB represents an additional layer of protection
  enable_advanced_threat_protection = true

  # Creating Private Endpoint requires, VNet name and address prefix to create a subnet
  # By default this will create a `privatelink.mysql.database.azure.com` DNS zone. 
  # To use existing private DNS zone specify `existing_private_dns_zone` with valid zone name
  # Private endpoints doesn't work If using `subnet_id` to create redis inside a specified VNet.
  enable_private_endpoint       = true
  virtual_network_name          = "vnet-shared-hub-westeurope-001"
  private_subnet_address_prefix = ["10.1.5.0/29"]
  #  existing_private_dns_zone     = "demo.example.com"

  # (Optional) To enable Azure Monitoring for Azure MySQL database
  # (Optional) Specify `storage_account_name` to save monitoring logs to storage. 
  log_analytics_workspace_name = "loganalytics-we-sharedtest2"

  # CosmosDB Firewall Support: Specifies the set of IP addresses / ranges to be included as an allowed list 
  # IP addresses/ranges must be comma separated and must not contain any spaces.
  # Only publicly routable ranges are enforceable through IpRules. 
  # IPv4 addresses or ranges contained in [10.0.0.0/8,100.64.0.0/10,172.16.0.0/12,192.168.0.0/16] not valid.
  # To allow access from azure portal add ["104.42.195.92", "40.76.54.131", "52.176.6.30", "52.169.50.45", "52.187.184.26"]
  # To allow [0.0.0.0] to Accept connections from within public Azure datacenters
  allowed_ip_range_cidrs = [
    "49.204.226.198",
    "1.2.3.4",
    "0.0.0.0",
    "104.42.195.92",
    "40.76.54.131",
    "52.176.6.30",
    "52.169.50.45",
    "52.187.184.26"
  ]

  # Capabilities required for cosmosdb table 
  capabilities = ["EnableTable"]

  # cosmosdb Table within a Cosmos DB Account
  # To use a custom name, set an argument `cosmosdb_table_name` to valid string
  # Either `cosmosdb_table_throughput` or `cosmosdb_table_autoscale_settings` to be present and not both
  # Switching between autoscale and manual throughput is not supported via Terraform and manual task.
  # The minimum value for `throughput` is `400` and `autoscale_settings` minimum value is `10000`
  create_cosmosdb_table = true
  cosmosdb_table_autoscale_settings = {
    max_throughput = 10000
  }

  # Tags for Azure Resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
