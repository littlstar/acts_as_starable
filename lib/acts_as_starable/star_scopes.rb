module ActsAsStarable #:nodoc:
  module StarScopes

    def for_starer(starer)
      where(starer_id: starer.id, starer_type: parent_class_name(starer))
    end

    def for_starable(starable)
      where(starable_id: starable.id, starable_type: parent_class_name(starable))
    end

    def for_starer_type(starer_type)
      where(starer_type: starer_type)
    end

    def for_starable_type(starable_type)
      where(starable_type: starable_type)
    end

    def recent(from)
      where(["created_at > ?", (from || 2.weeks.ago).to_s(:db)])
    end

    def descending
      order("stars.created_at DESC")
    end

  end
end
