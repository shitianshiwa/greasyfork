class ForumMailer < ApplicationMailer
  include UserTextHelper

  def comment_on_script(author_user, comment)
    site_name = 'Greasy Fork'
    locale = author_user.available_locale_code
    mail(to: author_user.email, subject: t('mailers.script_comment.subject', script_name: comment.script.name(locale), site_name: site_name, locale: locale)) do |format|
      format.text do
        render plain: t('mailers.script_comment.text',
                        script_name: comment.script.name(locale),
                        site_name: site_name,
                        script_url: script_url(comment.script, locale: locale),
                        commenter_name: comment.poster.name,
                        comment_text: format_user_text_as_plain(comment.text, comment.text_markup),
                        comment_url: comment.url,
                        notification_preferences_url: edit_user_registration_url(locale: locale),
                        locale: locale)
      end
    end
  end

  def comment_on_subscribed(user, comment)
    site_name = 'Greasy Fork'
    locale = user.available_locale_code
    mail(to: user.email, subject: t('mailers.subscribed_discussion.subject', discussion_title: comment.discussion.title, site_name: site_name, locale: locale)) do |format|
      format.text do
        render plain: t('mailers.subscribed_discussion.text',
                        discussion_title: comment.discussion.title(locale: locale),
                        site_name: site_name,
                        commenter_name: comment.poster.name,
                        comment_text: format_user_text_as_plain(comment.text, comment.text_markup),
                        comment_url: comment.url,
                        discussion_url: comment.discussion.url,
                        locale: locale)
      end
    end
  end
end
