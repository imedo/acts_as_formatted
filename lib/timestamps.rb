module ActiveRecord::Timestamps
  def without_timestamps(&block)
    rec_ts = ActiveRecord::Base.record_timestamps
    applied_to = self.is_a?(Class) ? self : self.class
    applied_to.record_timestamps = false
    begin
      yield
    ensure
      applied_to.record_timestamps = rec_ts
    end
  end
end

ActiveRecord::Base.send(:extend, ActiveRecord::Timestamps)
ActiveRecord::Base.send(:include, ActiveRecord::Timestamps)
