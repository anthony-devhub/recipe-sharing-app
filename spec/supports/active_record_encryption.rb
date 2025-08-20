Rails.application.config.active_record.encryption.primary_key = Rails.application.credentials.dig(:active_record_encryption, :primary_key)
Rails.application.config.active_record.encryption.deterministic_key = Rails.application.credentials.dig(:active_record_encryption, :deterministic_key)
Rails.application.config.active_record.encryption.key_derivation_salt = Rails.application.credentials.dig(:active_record_encryption, :key_derivation_salt)
