module Slugable
    module ClassMethods
        def find_by_slug(slug)
            self.find_by(name: "#{slug.titleize}")
        end
    end

    module InstanceMethods
        def slug
            self.name.downcase.gsub(" ","-")
        end
    end
end