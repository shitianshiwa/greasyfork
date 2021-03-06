module DiscussionHelper
  def render_poster(comment_or_discusion)
    render_user(comment_or_discusion.poster, comment_or_discusion.poster_id, script: comment_or_discusion.script)
  end

  def discussion_snippet(discussion)
    first_comment = discussion.comments.first
    format_user_text_as_plain(first_comment.text, first_comment.text_markup).truncate(200)
  end

  def scoped_comment_create_path(discussion)
    if discussion.script
      script_discussion_comments_path(discussion.script, discussion)
    else
      discussion_comments_path(discussion)
    end
  end

  def scoped_comment_path(comment)
    if comment.discussion.script
      script_discussion_comment_path(comment.discussion.script, comment.discussion, comment)
    else
      discussion_comment_path(comment.discussion, comment)
    end
  end

  def scoped_subscribe_path(discussion)
    if discussion.script
      subscribe_script_discussion_path(discussion.script, discussion)
    else
      subscribe_discussion_path(discussion)
    end
  end

  def scoped_unsubscribe_path(discussion)
    if discussion.script
      unsubscribe_script_discussion_path(discussion.script, discussion)
    else
      unsubscribe_discussion_path(discussion)
    end
  end

  def user_activity_title(discussion, post:)
    if discussion.script
      key = if discussion.actual_rating?
              post ? 'discussions.user_activity.script_review.posted_html' : 'discussions.user_activity.script_review.replied_html'
            else
              post ? 'discussions.user_activity.script_question.posted_html' : 'discussions.user_activity.script_question.replied_html'
            end
      return t(key, script: discussion.script.name(request_locale))
    end
    raise 'not implemented'
  end
end
