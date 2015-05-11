object @api
attributes :version, :last_response_time

child @users do
  attributes :name, :created_at
end