# frozen_string_literal: true

class ActiveStorageBlob < ApplicationRecord
  def export
    super(%i[id key filename content_type metadata service_name byte_size checksum])
  end
end
