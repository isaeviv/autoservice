module ApplicationHelper
  include Pagy::Frontend

  def pagy_bootstrap_nav(pagy)
    super if pagy.pages > 1
  end

  def task_status(task)
    # span.badge.text-bg-primary.ms-1
    #   = task.status
    # :open, :in_progress, :suspended, :completed, :closed
    classes = {
      'open'        => 'info',
      'in_progress' => 'primary',
      'suspended'   => 'warning',
      'completed'   => 'success',
      'closed'      => 'secondary'
    }

    content_tag(:span, class: "badge text-bg-#{classes[task.status]} rounded-pill ms-1") do
      Task.human_enum_name :status, task.status
    end
  end

  def localized_statuses_collection(model, statuses)
    statuses.keys.map { |key| [I18n.t("activerecord.attributes.#{model}.statuses.#{key}"), key] }
  end
end
