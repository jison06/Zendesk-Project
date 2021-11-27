# frozen_string_literal: true

json.tickets tickets do |ticket|
  json.id ticket['id']
  json.created_at ticket['created_at']
  json.updated_at ticket['updated_at']
  json.type ticket['type']
  json.subject ticket['subject']
  json.description ticket['description']
  json.priority ticket['priority']
  json.status ticket['status']
  json.due_at ticket['due_at']
  json.tags ticket['tags']
end

json.count count
