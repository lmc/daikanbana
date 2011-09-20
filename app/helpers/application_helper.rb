module ApplicationHelper
  def session_status_classes
    [].tap do |classes|
      classes << "signed_in"  if user_signed_in?
      classes << "signed_out" if not user_signed_in?
    end.join(' ')
  end
end
