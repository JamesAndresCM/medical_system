#json.partial! "posts/post", post: @post
json.extract! @post, :id, :body, :user_id

