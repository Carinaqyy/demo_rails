json.extract! comment, :id, :commenter, :body, :micropost_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
