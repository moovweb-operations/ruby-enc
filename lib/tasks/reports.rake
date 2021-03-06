namespace :report do
  desc "Clean old reports"
  task :clean => [:environment] do
    include ActionView::Helpers::TextHelper

    reports = ReportCleaning.new(ENV["AGE"].to_i.days.ago).clean
    puts "Cleaned #{pluralize(reports.count, 'report')}"
  end
end
