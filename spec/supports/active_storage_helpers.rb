module ActiveStorageHelpers
  def clear_enqueued_jobs
    ActiveJob::Base.queue_adapter.enqueued_jobs.clear
  end
end
