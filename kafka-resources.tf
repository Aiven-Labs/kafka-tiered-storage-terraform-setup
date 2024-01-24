resource "aiven_kafka" "kafka1" {
  project                 = var.project_name
  cloud_name              = "google-europe-west1"
  plan                    = "business-4"
  service_name            = "example-kafka-service-with-tiered-storage"

  kafka_user_config {
    tiered_storage {
        enabled = true
    }
    kafka_version   = "3.6"
  }
}

# Topic for Kafka
resource "aiven_kafka_topic" "sample_topic" {
  project      = var.project_name
  service_name = aiven_kafka.kafka1.service_name
  topic_name   = "sample_topic_with_tiered_storage"
  partitions   = 3
  replication  = 2
  config {
    remote_storage_enable = true
    local_retention_ms = 300000 # 5 min
    segment_bytes = 1000000 # 1 Mb
  }
}