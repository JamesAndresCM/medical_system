#json.partial! "comments/comment", comment: @comment
json.extract! @comment, :id, :body, :user_id
