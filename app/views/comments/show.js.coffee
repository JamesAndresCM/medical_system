$('#comments_<%= @comment.post_id %>').prepend('<%= j render @comment %>')
$('#comment_body_<%= @comment.post.id %>').val(' ')