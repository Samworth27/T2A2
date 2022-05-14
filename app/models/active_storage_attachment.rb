# frozen_string_literal: true

class ActiveStorageAttachment < ApplicationRecord
  def export
    super(%i[name record_type record_id blob_id])
  end
end
