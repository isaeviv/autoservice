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
      "open"        => "info",
      "in_progress" => "primary",
      "suspended"   => "warning",
      "completed"   => "success",
      "closed"      => "secondary"
    }

    content_tag(:span, class: "badge text-bg-#{classes[task.status]} rounded-pill ms-1") do
      Task.human_enum_name :status, task.status
    end
  end

  def localized_statuses_collection(model, statuses)
    statuses.keys.map { |key| [ I18n.t("activerecord.attributes.#{model}.statuses.#{key}"), key ] }
  end

  def tasks_statistic_bar(tasks)
    one_percent = tasks.size.to_f / 100
    open_tasks_count = tasks.open.count
    in_progress_tasks_count = tasks.in_progress.count
    suspended_tasks_count = tasks.suspended.count
    completed_tasks_count = tasks.completed.count
    closed_tasks_count = tasks.closed.count
    config = {
      open: {
        percentage: (open_tasks_count.to_f / one_percent).round,
        count: open_tasks_count,
        class: "info"
      },
      in_progress: {
        percentage: (in_progress_tasks_count.to_f / one_percent).round,
        count: in_progress_tasks_count,
        class: "primary"
      },
      suspended: {
        percentage: (suspended_tasks_count.to_f / one_percent).round,
        count: suspended_tasks_count,
        class: "warning"
      },
      completed: {
        percentage: (completed_tasks_count.to_f / one_percent).round,
        count: completed_tasks_count,
        class: "success"
      },
      closed: {
        percentage: (closed_tasks_count.to_f / one_percent).round,
        count: closed_tasks_count,
        class: "secondary"
      }
    }
    content_tag :div, class: "progress-stacked" do
      config.map do |key, options|
        content_tag(:div, class: "progress", role: "progressbar", 
                  aria: { label: "Segment one", valuenow: options[:percentage], valuemin: 0, valuemax: 100},
                  data: { bs_toggle:"tooltip", bs_placement:"top", bs_title: "#{key}: #{options[:percentage]}% | #{options[:count]} count"},
                  style: "width: #{options[:percentage]}%") do
          content_tag :div, nil, class: "progress-bar bg-#{options[:class]}"
        end
      end.join.html_safe
    end
  end
end
