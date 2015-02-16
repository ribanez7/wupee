class NotifyWith::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number path
    unless @prev_migration_nr
    @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    else
    @prev_migration_nr += 1
    end
    @prev_migration_nr.to_s
  end

  def copy_notification_migration
    migration_template "create_notification.rb", "db/migrate/create_notification.rb"
  end

  def copy_notification_model
    template "notification.rb", "app/models/notification.rb"
  end

  def copy_notification_type_model
    template "notification_type.rb", "app/models/notification_type.rb"
  end

  def copy_notifications_mailer
    template "notifications_mailer.rb", "app/mailers/notifications_mailer.rb"
  end

  def copy_initializer
    template "notify_with.rb", "config/initializers/notify_with.rb"
  end

  def add_subject_locale
    append_file "config/locales/#{I18n.locale.to_s}.yml" do
<<-CODE
  notifications_mailer:
    send_mail_by:
CODE
    end
  end
end