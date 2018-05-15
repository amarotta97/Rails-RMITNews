json.by @comment.user.username
json.id @comment.id
json.time @comment.created_at.to_i
json.title @comment.body

