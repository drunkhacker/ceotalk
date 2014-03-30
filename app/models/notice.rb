class Notice < OtherDatabase
  self.table_name = "xe_documents"
  self.primary_key = "document_srl"

  def created_at
    Time.parse(self.regdate)
  end
end
