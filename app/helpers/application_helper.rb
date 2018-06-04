module ApplicationHelper

  def page_title
    name = controller.class.to_s.sub('Controller', '').tr('::', ' ')
    "#{I18n.t('title')} - #{name}"
  end

  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }.fetch(flash_type.to_sym, flash_type.to_s)
  end

  def bootstrap_icon_for(flash_type)
    {
      success: 'ok-circle',
      error: 'remove-circle',
      alert: 'warning-sign',
      notice: 'exclamation-sign'
    }.fetch(flash_type, 'question-sign')
  end

  def yes_no_label(value)
    value ? 'Yes' : 'No'
  end

  def points_icon(points)
    if points == 3
      'king'
    elsif points == 1
      'ok'
    else
      'remove'
    end
  end

  def points_color(points)
    return unless points
    points > 0 ? 'green' : 'red'
  end

end
